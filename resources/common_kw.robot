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

