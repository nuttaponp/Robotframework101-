*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Books_API/Books_API_KW.robot

#robot -d results/Books_API Tests/Books_API.robot


*** Test Cases ***
TC1 Create one book order
    Get access token
    Submit an order

TC2 Update an order by changing the customer name
    Change customer name

TC3 Get/check the order that you order from step 1 and 2
    Get an order

TC4 Delete/cancel your order
    Delete an order

