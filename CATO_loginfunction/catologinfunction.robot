*** Settings ***
Test Teardown     Close Browser
Library           SeleniumLibrary
Library           ExcelLibrary

*** Variables ***
${excel_file_name}    credential_details.xls
${SheetName}      Sheet1
${baseurl}        http://webtest.xerago.com/cvm/

*** Test Cases ***
To Enter Admin Valid username and Valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    1
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    1
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Admin login successfully
	
To Enter Creator Valid username and Valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    2
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    2
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Creator login successfully

To Enter Reviewer valid username and valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    3
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    3
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Reviewer login successfully

To Enter Creatorhead valid username and valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    6
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    6
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Creator head login successfully

To Enter Rester valid username and valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    4
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    4
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Marketing module login successfully
	
To Enter Compliancehead valid username and valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}/${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    5
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    5
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Compliance head login successfully
	
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

Local browser launch
    Set Selenium Speed    1s
    Open Browser    ${baseurl}    chrome
    Maximize Browser Window
    Set Browser Implicit Wait    15s

Multilogin_repeated
    Click Button    id=form_login
    Wait Until Element Is Visible    id=loginuser    25s
    Mouse Over    id=loginuser
    Click Element    xpath=.//ul[@class='dropdown-menu welcome-icon']/li/span
