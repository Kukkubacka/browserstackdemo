*** Settings ***
Library                     Selenium2Library
Library                     ../libs/pi3.py
Resource            		    ../resources/pi3_kw.robot       

*** Variables ***

*** Test Cases ***

Test Pi3
    Log             BrowserStack Test - Pi3.
    Open Remote Browser     BROWSER=Chrome  BROWSER_VERSION=47.0  OS=Windows  OS_VERSION=7  
    Wait Until Page Contains Element        //*[@name='orderer']//li


*** Keywords ***


Open Remote Browser
    [Arguments]   ${BROWSER}  ${BROWSER_VERSION}  ${OS}  ${OS_VERSION}
    Open Browser   url=${SiteUrl}   browser=${BROWSER}   remote_url=${RemoteURL}   desired_capabilities=browser:${BROWSER},browser_version:${BROWSER_VERSION},os:${OS},os_version:${OS_VERSION}


Maximize Browser
    Maximize Browser Window

