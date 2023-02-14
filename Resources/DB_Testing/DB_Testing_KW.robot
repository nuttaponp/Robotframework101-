*** Settings ***
Library    DatabaseLibrary
Library    OperatingSystem


*** Variables ***
${DBHost}    127.0.0.1
${DBName}    Identity
${DBPort}    3306
${DBUser}    root
${DBPass}    root


*** Keywords ***
Create table customer_identity
    ${output}=    Execute Sql String    Create table customer_identity(customer_id integer,first_name varchar(20),last_name varchar(20),phone varchar(20));
    Should Be Equal As Strings    ${output}    None

Create table customer_identity_info
    ${output}=    Execute Sql String    Create table customer_identity_info(customer_type_id integer,customer_id integer,customer_type_name varchar(20),customer_status varchar(20));
    Should Be Equal As Strings    ${output}    None

Insert data in customer_identity table
    ${output}=    Execute Sql String    Insert into customer_identity values(100,'Nuttapon','Phitha','+66883280924');
    Should Be Equal As Strings    ${output}    None

Insert data in customer_identity_info table
    ${output}=    Execute Sql String    Insert into customer_identity_info values(1,100,'loyalty','active');
    Should Be Equal As Strings    ${output}    None

Check customer data in customer_identity table
    Check If Exists In Database    SELECT customer_id FROM customer_identity WHERE first_name = 'Nuttapon';

Check customer data in customer_identity_info table
    Check If Exists In Database    SELECT customer_type_id FROM customer_identity_info WHERE customer_type_name = 'loyalty';

Delete customer data in customer_identity and customer_identity_info tables
    ${output}=    Execute Sql Script   ${EXECDIR}${/}resources${/}DB_Testing${/}delete_script.sql
    # Delete All Rows From Table    customer_identity 
    # ${output}=    Execute Sql String    DELETE ALL ROWS FROM TABLE customer_identity        #Delete All Records
    Should Be Equal As Strings    ${output}    None

# Update 'customer_type_name' in customer_identity_info table
#     ${output}=    Execute Sql String    Update customer_identity_info Set customer_type_name = 'online' WHERE customer_id = 100;
#     Should Be Equal As Strings    ${output}    None 

# Check 'customer_type_name = loyalty' not exists in customer_identity_info table
#     Check If Not Exists In Database    SELECT customer_type_id FROM customer_identity_info WHERE customer_type_name = 'loyalty';

Drop all table if exists
    ${output}=    Execute Sql String    Drop table if exists customer_identity,customer_identity_info;
    Should Be Equal As Strings    ${output}    None
