*** Settings ***
Documentation       Template robot main suite.


*** Tasks ***
Customer Onboarding challange
    TRY
        Log    message
    
    EXCEPT    AS  ${e}
        ${error_msg}    Set Variable    ERP Automation - Failed in initialization. Error: ${e}
        Log Message    ${error_msg}    level=ERROR
        Fail  ${error_msg}
    
    END