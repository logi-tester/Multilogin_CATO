*** Settings ***
Test Teardown     Close Browser
Library           SeleniumLibrary
Library           ExcelLibrary

*** Variables ***
${excel_file_name}    credential_details.xls
${SheetName}      Sheet1
${baseurl}        http://webtest.xerago.com/cvm/

*** Test Cases ***
To enter Valid username & Valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    2
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    2
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Creator login successfully

To Enter valid username & Invalid password
    Jenkins browser launch
    Input Text    xpath=(.//*[@type='text'])[1]    testpurpose
    Input Text    xpath=.//*[@type='password']    testdata
    Click Element    xpath=(.//*[@type='submit'])[1]
    Page Should Contain    Please enter a valid username/password

To Enter Invalid username & valid password
    Jenkins browser launch
    Input Text    xpath=(.//*[@type='text'])[1]    testdata
    Input Text    xpath=.//*[@type='password']    testpurpose
    Click Element    xpath=(.//*[@type='submit'])[1]
    Page Should Contain    Please enter a valid username/password

To Enter Invalid username & Invalid password
    Jenkins browser launch
    Input Text    xpath=(.//*[@type='text'])[1]    testdata
    Input Text    xpath=.//*[@type='password']    testdata
    Click Element    xpath=(.//*[@type='submit'])[1]
    Page Should Contain    Please enter a valid username/password

*** Keywords ***
Jenkins browser launch
    Set Selenium Speed    1s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${baseurl}
    Maximize Browser Window
    Set Browser Implicit Wait    15s

Multilogin_repeated
    Click Button    id=form_login
    Wait Until Element Is Visible    id=loginuser    25s
    Mouse Over    id=loginuser
    Click Element    xpath=.//ul[@class='dropdown-menu welcome-icon']/li/span
