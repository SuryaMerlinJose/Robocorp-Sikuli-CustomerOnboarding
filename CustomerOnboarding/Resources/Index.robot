*** Settings ***
Library     SikuliLibrary
Library     RPA.Browser.Selenium 
Library     RPA.Desktop   
Library     RPA.Excel.Files
Library     RPA.Tables

Variables   C:\\Users\\Surya\\Documents\\GitHub\\Robocorp-Sikuli-CustomerOnboarding\\CustomerOnboarding\\Variables\\Image.py

*** Variables ***
${URL}    https://pathfinder.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html?_fsi=yNOdb4jl
${csv}    C:\\Users\\Surya\\Documents\\GitHub\\Robocorp-Sikuli-CustomerOnboarding\\CustomerOnboarding\\Input\\customer-onboarding-challenge .csv
*** Keywords ***

Automation anywhere login
    Sleep    3
    SikuliLibrary.Input Text    ${search_bar}    ${URL}e
    RPA.Desktop.Press Keys    ENTER
    Sleep    3
    SikuliLibrary.Click    ${accept_cookies}
    SikuliLibrary.Click    ${community_login}
    Sleep    2
    SikuliLibrary.Input Text    ${email}    suryamerlinjose@gmail.com
    RPA.Desktop.Press Keys    ENTER
    Sleep    2
    SikuliLibrary.Input Text    ${password}   surya123
    RPA.Desktop.Press Keys    ENTER
    Sleep    2

Scroll Page
    # RPA.Browser.Selenium.Is Element Visible    ${customer_id}    #Error: no browseropen
    # FOR    ${i}    IN RANGE    7
        SikuliLibrary.Click    ${scroll}
        SikuliLibrary.Wheel Down    5    
    # END
   
Fill and submit the form for one person    
    
    [Arguments]    ${customers}
    SikuliLibrary.Input Text    ${customer_name}   ${customers}[Company Name]
    SikuliLibrary.Input Text    ${customer_id}     ${customers}[Customer ID]
    SikuliLibrary.Input Text    ${primary_contact}    ${customers}[Primary Contact]
    SikuliLibrary.Input Text    ${street_address}    ${customers}[Street Address]
    SikuliLibrary.Input Text    ${city}    ${customers}[City]
    # ${customers}[State]
    SikuliLibrary.Click    ${state}
    SikuliLibrary.Input Text    ${state}    ${customers}[State]
    RPA.Desktop.Press Keys    ENTER
    
    SikuliLibrary.Input Text    ${zip}    ${customers}[Zip]
    SikuliLibrary.Input Text   ${email_input}    ${customers}[Email Address]

    IF    "${customers}[Offers Discounts]" == "YES"
       SikuliLibrary.click    ${yes}
    ELSE
        SikuliLibrary.click    ${no}
    END

    IF    "${customers}[Non-Disclosure On File]" == "YES"
        SikuliLibrary.Click    ${nda}
    END

    SikuliLibrary.Click    ${register}

Fill the form using the data from the Excel file
    ${customer}=    Read table from CSV    ${csv}    dialect=excel
    FOR    ${customers}    IN    @{customer}
        Fill and submit the form for one person    ${customers}

    END

*** Tasks ***
Customer Onboarding
    # Automation anywhere login
    Scroll Page
    Fill the form using the data from the Excel file