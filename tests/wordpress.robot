*** Settings ***
Library                     Selenium2Library
Library                     Collections
Library                     JSONLibrary
Library                     OperatingSystem
#Library                    DebugLibrary
Library                     RequestsLibrary

Library                     ../libs/pi3.py

Resource                  ../resources/common_kw.robot

Suite Setup                 SuiteSetup
Suite Teardown              SuiteTeardown

# Test Setup                TestSetup
Test Teardown               TestTeardown


*** Variables ***

# BrowserStack Account
${BSUser}                   YOUR-USER
${AccessKey}                YOUR-ACCESS-KEY
${RemoteUrl}                http://${BSUser}:${AccessKey}@hub.browserstack.com/wd/hub

${url}                      http://www.google.com

# Built-In variables ${TEST NAME} and ${SUITE NAME}

${build}                    Pi3 Suite
${project}                  Pi3 Project
${build-id}                 Not Defined
${session-id}

${json_file}                resources/bs_browsers.json
${builds_file}              resources/builds.json


${BROWSER}                  chrome


&{capabilities}             browser=${BROWSER}
...                         browser_version=47.0
...                         os=Windows
...                         os_version=10
...                         build=${build}
...                         projectName=${project}
...                         name=TEST NAME

&{headers}              Content-Type=application/json

&{data}                 status=PASSED
...                     reason=Robot Framework


# robot -d output -i BS tests/wordpress.robot

*** Test Cases ***


Test 1
    [Tags]              BS
    Log                 Running Test 1
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 2
    [Tags]              BS
    Log                 Running Test 2
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 3
    [Tags]              BS
    Log                 Running Test 3
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 4
    [Tags]              BS
    Log                 Running Test 4
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 5
    [Tags]              BS
    Log                 Running Test 5
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 6
    [Tags]              BS
    Log                 Running Test 6
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 7
    [Tags]              BS
    Log                 Running Test 7
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

Test 8
    [Tags]              BS
    Log                 Running Test 8
    ${browser_ref}=     Get Next Browser Ref
    Log                 ${browser_ref}
    Create Capabilities   ${browser_ref}    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1

