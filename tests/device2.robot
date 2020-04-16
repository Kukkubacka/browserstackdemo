*** Settings ***
Library                     Selenium2Library
Library                     Collections
Library                     JSONLibrary
Library                     OperatingSystem
#Library                    DebugLibrary
Library                     RequestsLibrary

Library                     ../libs/pi3.py

Resource                  ../resources/common_kw.robot

Suite Setup                 SuiteSetupDev
Suite Teardown              SuiteTeardown

# Test Setup                TestSetup
Test Teardown               TestTeardown        # REST 


*** Variables ***

# BrowserStack Account
${BSUser}                   %{BROWSERSTACK_USERNAME}
${AccessKey}                %{BROWSERSTACK_ACCESS_KEY}
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


&{capabilities}             realMobile=true
...                         device=Samsung Galaxy Tab S5e
...                         os_version=9.0
...                         browserstack.local=false
...                         build=${build}
...                         projectName=${project}
...                         name=TEST NAME


#...                         browserstack.appium_version=1.6.5
#...                         browser=${BROWSER}
#...                         browser_version=47.0

# REST API

${api_base}             https://api.browserstack.com/automate/
&{headers}              Content-Type=application/json
&{data}                 status=PASSED
...                     reason=Robot Framework

${Tag}


# robot -d output -v BSUser:<user> -v AccessKey:<access-key> -i DEV tests/wp_local.robot


*** Test Cases ***

Device 1
    [Tags]              DEV      Android
    Log                 Running Test 1
    #${browser_ref}=     Get Next Browser Ref
    #Log                 ${browser_ref}
    #Create Capabilities   ${browser_ref}    ${TEST NAME}
    Set To Dictionary       ${capabilities}     name    ${TEST NAME}
    Log Many            &{capabilities}
    Open Remote Browser   
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
Sleep 1
