*** Settings ***
Library                     Selenium2Library
Library                     Collections

*** Variables ***

# BrowserStack’s Dashboard

# BrowserStack Account
${BSUser}                   YOUR-USER
${AccessKey}                YOUR-ACCESS-KEY
${RemoteUrl}                http://${BSUser}:${AccessKey}@hub.browserstack.com/wd/hub

${SiteUrl}                  http://jussi.pi3.dy.fi


${BROWSER}              chrome      # SelGrid: chrome / firefox
#&{capabilities}         platformName=LINUX
#...                     browserName=${BROWSER}
#...                     version=${VER}

&{capabilities}        browser=${BROWSER}
...                    browser_version=47.0
...                    os=Windows
...                    os_version=10
...                    build=Pi3 Suite
...                    projectName=Pi3
...                    name=Pi3 Test 2


# https://www.browserstack.com/list-of-browsers-and-platforms/live

# ${BROWSER}                Chrome | Firefox | EDGE | Safari
# ${BROWSER_VERSION}        
# ${OS}                     Windows  | Mac | Linux ?
# ${OS_VERSION}             10, 8, 7 |  ?  | 

# Real Mobile & Tablet Devices      ... Android, Ios, Windows Phone

*** Test Cases ***

Test Pi3
    [Tags]          BS
    Log             BrowserStack Test - Pi3.
    Open Remote Browser     BROWSER=Chrome  BROWSER_VERSION=47.0  OS=Windows  OS_VERSION=10  
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    #Close All Browsers
    Sleep           1


Test 2 Pi3
    [Tags]          BS
    Log             BrowserStack Test - Pi3.
    Open Remote Browser2    
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    #Close All Browsers
    Sleep           1


Test 2 Pi3 FF
    [Tags]          BS
    Log             BrowserStack Test - Pi3.
    ${BROWSER}=     Set Variable  firefox
    Set To Dictionary       ${capabilities}    browser              firefox
    Set To Dictionary       ${capabilities}    browser_version      71.0
    Open Remote Browser2    
    Sleep           2
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    Sleep           1



*** Keywords ***


Open Remote Browser
    [Arguments]   ${BROWSER}  ${BROWSER_VERSION}  ${OS}  ${OS_VERSION}
    Open Browser   url=${SiteUrl}   browser=${BROWSER}   remote_url=${RemoteURL}   desired_capabilities=browser:${BROWSER},browser_version:${BROWSER_VERSION},os:${OS},os_version:${OS_VERSION},build:Pi3 Suite,projectName:Pi3,name:Pi3 Test
    #Open Browser   url=${SiteUrl}   browser=${BROWSER}   remote_url=${RemoteURL}   desired_capabilities=${capabilities}

Open Remote Browser2
    #[Arguments]   ${BROWSER}  ${BROWSER_VERSION}  ${OS}  ${OS_VERSION}
    Open Browser   url=${SiteUrl}   browser=${BROWSER}   remote_url=${RemoteURL}   desired_capabilities=${capabilities}


Maximize Browser
    Maximize Browser Window




