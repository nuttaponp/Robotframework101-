*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    String
Library    Collections


#1.1 Create one book order

#1.2 Update an order by changing the customer name

#1.3 Get/check the order that you order from step 1 and 2

#1.4 Delete/cancel your order

*** Variables ***
${baseUrl}    https://simple-books-api.glitch.me
${Endpoint_Books}    /books/
${Endpoint_Orders}    /orders/
${Endpoint_Auth}    /api-clients/


*** Keywords ***
Get access token
    ${random_string}=    Generate Random String    4    [NUMBERS]
    Create Session    my_session    ${baseUrl}    verify=true
    ${header}=    Create Dictionary    Content-Type=application/json    Accept=*/*
    &{body}=  Create Dictionary    clientName=QA${random_string}    clientEmail=QA${random_string}@email.com
    ${response}=       POST On Session    my_session    ${Endpoint_Auth}    headers=${header}    json=&{body}
    ${get_accesstoken}=    Get Value From Json    ${response.json()}    $.accessToken
    Set Global Variable    $accesstoken    ${get_accesstoken[0]}
    Should Be Equal As Strings  ${response.status_code}  201

# Random book id from list
#     Create Session    my_session    ${baseUrl}    verify=true
#     ${header}=    Create Dictionary    Content-Type=application/json    Accept=*/*
#     ${response}=       GET On Session    my_session    ${Endpoint_Books}
#     ${get_all_book_id}=    Get Value From Json    ${response.json()}    $.[*].id
#     ${random_book_id}=     Evaluate    random.choice($get_all_book_id) 
#     Set Global Variable    $bookId    ${random_book_id}  
        
Submit an order
    Create Session    my_session    ${baseUrl}    verify=true
    ${header}=    Create Dictionary    Content-Type=application/json    Accept=*/*    Authorization=Bearer ${accesstoken}
    &{body}=  Create Dictionary    bookId=6    customerName=test cust
    ${response}=       POST On Session    my_session    ${Endpoint_Orders}    headers=${header}    json=${body}
    ${get_order_id}    Get Value From Json    ${response.json()}    $.orderId
    Set Global Variable    $orderId    ${get_order_id[0]}
    Should Be Equal As Strings  ${response.status_code}  201

Change customer name
    Create Session  my_session    ${base_url}    verify=true
    ${header}=  Create Dictionary    Content-Type=application/json    Accept=*/*    Authorization=Bearer ${accesstoken}
    ${body}=  Create Dictionary    customerName=Nuttapon Phitha
    ${response}=  PATCH On Session    my_session    ${Endpoint_Orders}${orderId}     headers=${header}    json=${body}
    Should Be Equal As Strings    ${response.status_code}    204 

Get an order
    Create Session  my_session    ${base_url}    verify=true
    ${header}=  Create Dictionary    Content-Type=application/json    Accept=*/*    Authorization=Bearer ${accesstoken}
    ${response}=  GET On Session    my_session    ${Endpoint_Orders}${orderId}     headers=${header}
    Should Be Equal As Strings    ${response.status_code}    200

Delete an order
    Create Session  my_session    ${base_url}    verify=true
    ${header}=  Create Dictionary    Content-Type=application/json    Accept=*/*    Authorization=Bearer ${accesstoken}
    ${response}=  DELETE On Session    my_session    ${Endpoint_Orders}${orderId}     headers=${header}
    Should Be Equal As Strings    ${response.status_code}    204
    Should Be Equal As Strings    ${response.reason}    No Content


