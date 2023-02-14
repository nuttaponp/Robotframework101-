*** Settings ***
Suite Setup    Connect to Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect from Database	
Resource    ../Resources/DB_Testing/DB_Testing_KW.robot


#robot -d results/DB_Testing Tests/DB_Testing.robot

#2.1 Insert the new customer in table name “customer_identity” and “customer_identity_info”

#2.2 Select your customer that you created from step 1 

#2.3 Delete your customer that you created from step 1


*** Test Cases ***
TC1 Insert the new customer in table name “customer_identity” and “customer_identity_info”
    Drop all table if exists
    Create table customer_identity
    Create table customer_identity_info
    Insert data in customer_identity table
    Insert data in customer_identity_info table

TC2 Select your customer that you created from step 1
    Check customer data in customer_identity table
    Check customer data in customer_identity_info table

TC3 Delete your customer that you created from step 1
    Delete customer data in customer_identity and customer_identity_info tables

