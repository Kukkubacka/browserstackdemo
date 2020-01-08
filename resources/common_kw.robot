*** Keywords ***

SuiteSetup
    [Documentation]     Read bs_browsers.json.

    Log                 Reading JSON from XX
    Log                 ${json_file}
    ${json-obj}=        Read JSON File     ${json_file}
    Set Suite Variable  ${avail_browsers}   ${json-obj}
    Build Name

SuiteTeardown
    [Documentation]     Write updated .json and push to git
    Log                 Write .JSON file to disk
    Write JSON File     ${json_file}    ${avail_browsers}

TestTeardown
    Run Keyword If Test Failed      Close Browser
    Run Keyword If      '${build-id}' == 'Not Defined'
    ...                 Request Build Id
    Run Keyword If Test Passed          Api Marker      Passed
    Run Keyword If Test Failed          Api Marker      Failed

Request Build Id
    [Documentation]     Request build-id from BrowserStack

    ${api_url}=         Catenate    SEPARATOR=    ${api_base}     builds.json
    @{auth}=            Create List     ${BSUser}  ${AccessKey}
    Create Session      alias=bs_build    url=${api_url}     auth=${auth} 
    ${resp}=            Get Request         bs_build     /
    Log to console      ${resp}
    Should Be Equal     ${resp.status_code}  ${200}
    ${json} =           Set Variable  ${resp.json()}

    ${name-id}=         Get Value From Json  ${json}  $..name,hashed_id

    @{ref_list}         Convert To List     ${name-id}
    ${len}=             Get Length      ${name-id}
    :FOR   ${index}   IN RANGE    0    ${len}
    \       Log     ${ref_list}[${index}]
    \       Run Keyword If     '${ref_list}[${index}]' == '${build}'
            ...     Set Suite Variable    ${build_ind}      ${index}
    \       Exit For Loop If   '${ref_list}[${index}]' == '${build}'

    # Fail jos ei loydy
    ${build_ind}=       Evaluate        ${build_ind} + 1
    Set Suite Variable    ${build-id}   ${ref_list}[${build_ind}]

Api Marker
    [Arguments]         ${status}
    Log                 ${status}
    Set To Dictionary   ${data}     status    ${status}

    # build_id --> Sessions
    ${api_url}=         Catenate    SEPARATOR=    ${api_base}   builds/     ${build-id}      /sessions.json
    @{auth}=            Create List     ${BSUser}  ${AccessKey}
    Create Session      alias=bs_build    url=${api_url}     auth=${auth} 
    ${resp}=            Get Request         bs_build     /
    Log to console      ${resp}
    Should Be Equal     ${resp.status_code}  ${200}
    ${json} =           Set Variable  ${resp.json()}
    Log Many            ${json}
    
    # build_id  -->  sessionName  -->  session_id
    ${name-id}=         Get Value From Json  ${json}  $..name,hashed_id
    @{ref_list}         Convert To List     ${name-id}
    ${len}=             Get Length      ${name-id}
    :FOR   ${index}   IN RANGE    0    ${len}
    \       Log     ${ref_list}[${index}]
    \       Run Keyword If     '${ref_list}[${index}]' == '${TEST NAME}'
            ...     Set Suite Variable    ${session_ind}      ${index}
    \       Exit For Loop If   '${ref_list}[${index}]' == '${TEST NAME}'

    # Fail jos ei loydy
    ${session_ind}=       Evaluate        ${session_ind} + 1
    Set Suite Variable    ${session-id}   ${ref_list}[${session_ind}]
 
    ${rnd_fail}=        Mark Random Test Failed

    # Set Session Status
    ${api_url}=         Catenate    SEPARATOR=    ${api_base}   sessions/     ${session-id}      .json
    @{auth}=            Create List     ${BSUser}  ${AccessKey}
    Create Session      alias=bs_build    url=${api_url}     auth=${auth}     headers=${headers} 
    ${resp}=            Put Request         bs_build            /     data=${data}  
    Log to console      ${resp}
    Should Be Equal     ${resp.status_code}  ${200}
    
    
Mark Random Test Failed
    [Documentation]     Mark random test Failed to test BrowserStack session status
    ${tmp}=             Random True False      25
    Log                 ${tmp}
    Run Keyword If      '${tmp}' == 'False'
    ...                 Set To Dictionary   ${data}     status    Failed    


Create Capabilities
    [Documentation]     Read params from json and create capabilities dictionary.
    ...                 xxx
    [Arguments]         ${ref}  ${T_NAME}

    ${tmp}= 	        Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.ref=${ref})].browser
    ${j_browser}=       Get From List   ${tmp}    0

    ${tmp}=             Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.ref=${ref})].browser_version
    ${j_brow_v}=        Get From List   ${tmp}    0

    ${tmp}=             Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.ref=${ref})].os
    ${j_os}=            Get From List   ${tmp}    0

    ${tmp}=             Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.ref=${ref})].os_version
    ${j_os_vers}=       Get From List   ${tmp}    0

    Set Suite Variable      ${BROWSER}         ${j_browser}
    Set To Dictionary       ${capabilities}    browser              ${j_browser}
    Set To Dictionary       ${capabilities}    browser_version      ${j_brow_v}
    Set To Dictionary       ${capabilities}    os                   ${j_os}
    Set To Dictionary       ${capabilities}    os_version           ${j_os_vers}
    Set To Dictionary       ${capabilities}    name                 ${T_NAME}

    

Get Next Browser Ref
    [Documentation]     Search next browser from .json
    ...                 If no argements all browsers in round, lowest count selected.
    ...                 Weight defined to browsers. 
    [Arguments]         ${w_browser}=none
    Log                 ${w_browser}
    Log                 ${avail_browsers}

    ${values}= 	    Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.valid=True)].ref            #  All ref
    @{ref_list}             Convert To List     ${values}

    # Loop over the list
    ${list-len}=            Get Length      ${ref_list}           # for loop ei vahenn
    #${select}=              Get From List   ${ref_list}    0
    Set Test Variable       ${ref_val}     1000000        # Must be big enough

    :FOR   ${index}   IN RANGE    0    ${list-len}
    \       ${item}=        Get From List    ${ref_list}      ${index}
    \       ${tmpl}=        Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.ref=${item})].count
    \       ${new_val}=     Get From List   ${tmpl}   0     # Get Value palauttaa listan
    \       Log Many        ${new_val}    ${ref_val}
    \       Run Keyword If     ${new_val} < ${ref_val}     Set Test Variable     ${select}      ${item}
    \       Run Keyword If     ${new_val} < ${ref_val}     Set Test Variable     ${ref_val}     ${new_val}

    # read weight
    ${tmpl}=                Get Value From Json  ${avail_browsers}  $.BrowserStack.*[?(@.ref=${item})].weight
    ${weight}=              Get From List   ${tmpl}    0
    ${ref_val}=             Evaluate   ${ref_val} + ${weight}

    Update Value To Json    ${avail_browsers}     $.BrowserStack.*[?(@.ref=${select})].count    ${ref_val}
 
    Log     ${avail_browsers}

    ${w_browser}=           Set Variable    ${select}
    Return From Keyword     ${w_browser}

Build Name
    [Documentation]     Read index from builds.json
    ${builds-obj}=      Read JSON File     ${builds_file}
    ${value}=           Get From Dictionary     ${builds-obj}   NextIndex
    ${tmp}=             Convert To String   ${value}
    ${tmp}=             Catenate    SEPARATOR=    wp-     ${tmp}
    Set Suite Variable  ${build}   ${tmp}
    ${value}=           Evaluate    ${value} + 1
    Set To Dictionary       ${builds-obj}    NextIndex              ${value}
    Write JSON File     ${builds_file}    ${builds-obj}
    Set To Dictionary   ${capabilities}   build      ${tmp}       # ei paivity

Open Remote Browser
    #Open Browser    ${url}      chrome
    Open Browser   url=${url}   browser=${BROWSER}   remote_url=${RemoteURL}   desired_capabilities=${capabilities}


Maximize Browser
    Maximize Browser Window

