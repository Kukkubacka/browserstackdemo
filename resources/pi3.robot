*** Variables ***

*** Keywords ***

# json_kw.robot
Load JSON from File
    [Documentation]                     Load JSON from file and return 
    [Arguments]                         ${src_file}
    Log                                 ${src_file}
    ${json_obj}=                        read json data          ${src_file}
    Return From Keyword                 ${json_obj}

# json_kw.robot
Get Data From JSON
    [Documentation]     	            Search data JSON
    [Arguments]                         ${src}    ${search}
    ${values}=                          Get Value From Json     ${src}         ${search}
    @{y_list}                           Convert To List         ${values}
    ${lenght}=                          Get Length              ${y_list}
    Return From Keyword                 ${y_list}               ${lenght}


Selenium Demo
    [Documentation]                     Set selenium speed, without value returns previous
    [Arguments]                         ${speed}= 0
    #Run Keyword If    '${speed}' <> '0'    ${demoseleniumspeed} =         Set Selenium Speed     ${speed}
    Run Keyword If    '${speed}' == '0'    Set Selenium Speed            ${demoseleniumspeed}    
    ...    ELSE       ${demoseleniumspeed} =         Set Selenium Speed     ${speed}
    Log             ${speed}
    Log            ${demoseleniumspeed}
