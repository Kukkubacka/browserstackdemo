*** Settings ***
Library                     Selenium2Library

*** Variables ***

# BrowserStack’s Dashboard

# BrowserStack Account
${BSUser}                   YOUR-USER
${AccessKey}                YOUR-ACCESS-KEY
${RemoteUrl}                http://${BSUser}:${AccessKey}@hub.browserstack.com/wd/hub

${SiteUrl}                  http://jussi.pi3.dy.fi


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
    Open Remote Browser     BROWSER=Chrome  BROWSER_VERSION=47.0  OS=Windows  OS_VERSION=7  
    Sleep           3
    Wait Until Page Contains Element        //*[@class="entry-title"]
    Close Browser
    #Close All Browsers
    Sleep           3


*** Keywords ***


Open Remote Browser
    [Arguments]   ${BROWSER}  ${BROWSER_VERSION}  ${OS}  ${OS_VERSION}
    Open Browser   url=${SiteUrl}   browser=${BROWSER}   remote_url=${RemoteURL}   desired_capabilities=browser:${BROWSER},browser_version:${BROWSER_VERSION},os:${OS},os_version:${OS_VERSION},projectName:Pi3


Maximize Browser
    Maximize Browser Window




