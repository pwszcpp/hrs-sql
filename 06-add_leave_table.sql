SET IGNORECASE 1;             
;             
ALTER USER SA SET SALT '41aa162b20572f45' HASH '2d8b8c49eecde0b0b97675b777cfbd3c657d5f5a042172a9abe963c03d3f04b9';
CREATE USER IF NOT EXISTS HRS_USER SALT '602e49c9d8eb8bdd' HASH '36739355bb004cc9ae266202735535589428fd853c95d72491520c2dbb3562e5' ADMIN;
CREATE SCHEMA IF NOT EXISTS HRS_SCH AUTHORIZATION HRS_USER;   
CREATE SEQUENCE HRS_SCH.CONTRACTOR_SEQ START WITH 11 MAXVALUE 99999;          
CREATE SEQUENCE HRS_SCH.ROLES_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.PERMISSIONS_SEQ START WITH 1 MAXVALUE 99999;          
CREATE SEQUENCE HRS_SCH.LEAVE_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.INVOICE_SEQ START WITH 11 MAXVALUE 99999;             
CREATE SEQUENCE HRS_SCH.USERS_SEQ START WITH 11 MAXVALUE 99999;               
CREATE SEQUENCE HRS_SCH.TRAINING_SEQ START WITH 11 MAXVALUE 99999;            
CREATE CACHED TABLE HRS_SCH."Users"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.USERS_SEQ) NOT NULL,
    "Role" VARCHAR_IGNORECASE(24) NOT NULL,
    "Pass" VARCHAR_IGNORECASE(24) NOT NULL,
    "Status" ENUM('DISABLED','ENABLED') NOT NULL,
    "Pass_Expire" DATE,
    "Username" VARCHAR_IGNORECASE(24),
    "e-mail" VARCHAR_IGNORECASE(24),
    "Pass_changed_date" DATE,
    "Login_last_success" DATE,
    "Login_last_failed" DATE,
    "Login_attempts_failed" INT
);
ALTER TABLE HRS_SCH."Users" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4 PRIMARY KEY("Id");            
-- 10 +/- SELECT COUNT(*) FROM HRS_SCH."Users";               
INSERT INTO HRS_SCH."Users"("Id", "Role", "Pass", "Status", "Pass_Expire", "Username", "e-mail", "Pass_changed_date", "Login_last_success", "Login_last_failed", "Login_attempts_failed") VALUES
(1, CAST('CEO' AS VARCHAR_IGNORECASE), CAST('kh3ajj34' AS VARCHAR_IGNORECASE), DISABLED, DATE '2018-01-04', CAST('user7' AS VARCHAR_IGNORECASE), CAST('user2@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-11', DATE '2017-12-13', 1),
(2, CAST('Manager' AS VARCHAR_IGNORECASE), CAST('1ik8zff1' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user10' AS VARCHAR_IGNORECASE), CAST('user4@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-13', DATE '2017-12-13', 1),
(3, CAST('External individuals' AS VARCHAR_IGNORECASE), CAST('9O9qKBZ9' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user10' AS VARCHAR_IGNORECASE), CAST('user4@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-11', DATE '2017-12-07', 1),
(4, CAST('Instructors' AS VARCHAR_IGNORECASE), CAST('mtg67BXa' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user4' AS VARCHAR_IGNORECASE), CAST('user3@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-13', DATE '2017-12-14', 2),
(5, CAST('CEO' AS VARCHAR_IGNORECASE), CAST('NYGRwfKs' AS VARCHAR_IGNORECASE), DISABLED, DATE '2018-01-04', CAST('user10' AS VARCHAR_IGNORECASE), CAST('user6@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-08', DATE '2017-12-07', 2),
(6, CAST('Employee' AS VARCHAR_IGNORECASE), CAST('jcbD73mM' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user9' AS VARCHAR_IGNORECASE), CAST('user5@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-15', DATE '2017-12-13', 1),
(7, CAST('Administrator' AS VARCHAR_IGNORECASE), CAST('QexzjGHA' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user2' AS VARCHAR_IGNORECASE), CAST('user5@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-07', DATE '2017-12-12', 2),
(8, CAST('HR expert' AS VARCHAR_IGNORECASE), CAST('fAOL2CBy' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user8' AS VARCHAR_IGNORECASE), CAST('user9@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-11', DATE '2017-12-16', 2),
(9, CAST('Instructors' AS VARCHAR_IGNORECASE), CAST('CJZXCvSN' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user7' AS VARCHAR_IGNORECASE), CAST('user4@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-11', DATE '2017-12-16', 3),
(10, CAST('Setup administrator' AS VARCHAR_IGNORECASE), CAST('BgxJMsT8' AS VARCHAR_IGNORECASE), ENABLED, DATE '2018-01-04', CAST('user5' AS VARCHAR_IGNORECASE), CAST('user10@comapny.com' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-11', DATE '2017-12-16', 2);       
CREATE CACHED TABLE HRS_SCH."Roles"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.ROLES_SEQ) NOT NULL,
    "Name" VARCHAR_IGNORECASE(32) NOT NULL,
    "Permission" VARCHAR_IGNORECASE(32) NOT NULL
);    
ALTER TABLE HRS_SCH."Roles" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4B PRIMARY KEY("Id");           
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Roles";
CREATE CACHED TABLE HRS_SCH."Permissions"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.PERMISSIONS_SEQ) NOT NULL,
    "Name" VARCHAR_IGNORECASE NOT NULL,
    "Read" BOOL NOT NULL,
    "Write" BOOL NOT NULL,
    "Modify" BOOL NOT NULL,
    "Remove" BOOL NOT NULL,
    "Save" BOOL NOT NULL
);   
ALTER TABLE HRS_SCH."Permissions" ADD CONSTRAINT HRS_SCH.CONSTRAINT_A PRIMARY KEY("Id");      
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Permissions";          
CREATE CACHED TABLE HRS_SCH."Training"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.TRAINING_SEQ) NOT NULL,
    "Company" VARCHAR_IGNORECASE(24) NOT NULL,
    "From_Day" DATE NOT NULL,
    "Until_Day" DATE NOT NULL,
    "Price" DECIMAL NOT NULL,
    "Consent" BOOL NOT NULL,
    "Place" VARCHAR_IGNORECASE(24) NOT NULL,
    "Theme" VARCHAR_IGNORECASE(48) NOT NULL,
    "Author_Id" INT NOT NULL,
    "Cancelled" ENUM('No','Yes') NOT NULL,
    "No_of_seats" INT NOT NULL
);          
ALTER TABLE HRS_SCH."Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4F PRIMARY KEY("Id");        
-- 10 +/- SELECT COUNT(*) FROM HRS_SCH."Training";            
INSERT INTO HRS_SCH."Training"("Id", "Company", "From_Day", "Until_Day", "Price", "Consent", "Place", "Theme", "Author_Id", "Cancelled", "No_of_seats") VALUES
(1, CAST('Company15' AS VARCHAR_IGNORECASE), DATE '2018-01-09', DATE '2018-01-15', 1000.00, TRUE, CAST('Place7' AS VARCHAR_IGNORECASE), CAST('Theme8' AS VARCHAR_IGNORECASE), 6, Yes, 12),
(2, CAST('Company10' AS VARCHAR_IGNORECASE), DATE '2018-02-13', DATE '2018-02-14', 2500.00, TRUE, CAST('Place3' AS VARCHAR_IGNORECASE), CAST('Theme3' AS VARCHAR_IGNORECASE), 1, No, 20),
(3, CAST('Company8' AS VARCHAR_IGNORECASE), DATE '2018-02-03', DATE '2018-02-14', 3500.00, TRUE, CAST('Place9' AS VARCHAR_IGNORECASE), CAST('Theme6' AS VARCHAR_IGNORECASE), 9, Yes, 10),
(4, CAST('Company12' AS VARCHAR_IGNORECASE), DATE '2018-03-20', DATE '2018-02-26', 2500.00, TRUE, CAST('Place18' AS VARCHAR_IGNORECASE), CAST('Theme9' AS VARCHAR_IGNORECASE), 9, No, 10),
(5, CAST('Company13' AS VARCHAR_IGNORECASE), DATE '2017-12-25', DATE '2018-03-01', 1000.00, TRUE, CAST('Place11' AS VARCHAR_IGNORECASE), CAST('Theme6' AS VARCHAR_IGNORECASE), 3, Yes, 16),
(6, CAST('Company11' AS VARCHAR_IGNORECASE), DATE '2018-01-19', DATE '2018-01-06', 350.00, TRUE, CAST('Place4' AS VARCHAR_IGNORECASE), CAST('Theme5' AS VARCHAR_IGNORECASE), 9, No, 20),
(7, CAST('Company18' AS VARCHAR_IGNORECASE), DATE '2017-12-25', DATE '2018-03-13', 700.00, TRUE, CAST('Place12' AS VARCHAR_IGNORECASE), CAST('Theme19' AS VARCHAR_IGNORECASE), 3, No, 15),
(8, CAST('Company12' AS VARCHAR_IGNORECASE), DATE '2018-02-23', DATE '2018-01-27', 600.00, TRUE, CAST('Place15' AS VARCHAR_IGNORECASE), CAST('Theme10' AS VARCHAR_IGNORECASE), 7, Yes, 15),
(9, CAST('Company15' AS VARCHAR_IGNORECASE), DATE '2018-01-29', DATE '2017-12-16', 600.00, TRUE, CAST('Place7' AS VARCHAR_IGNORECASE), CAST('Theme19' AS VARCHAR_IGNORECASE), 7, No, 16),
(10, CAST('Company10' AS VARCHAR_IGNORECASE), DATE '2018-03-10', DATE '2018-03-22', 400.00, TRUE, CAST('Place1' AS VARCHAR_IGNORECASE), CAST('Theme3' AS VARCHAR_IGNORECASE), 8, No, 15);            
CREATE CACHED TABLE HRS_SCH."Users_Training_list"(
    "Training_ID" INT NOT NULL,
    "Users_ID" INT NOT NULL,
    "Note" VARCHAR_IGNORECASE(48),
    "Date_of_sign" DATE NOT NULL,
    "Cancelled" ENUM('No','Yes') NOT NULL,
    "Agreed" ENUM('No','Yes')
);       
-- 10 +/- SELECT COUNT(*) FROM HRS_SCH."Users_Training_list"; 
INSERT INTO HRS_SCH."Users_Training_list"("Training_ID", "Users_ID", "Note", "Date_of_sign", "Cancelled", "Agreed") VALUES
(1, 8, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-15', Yes, Yes),
(6, 3, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-31', No, Yes),
(2, 5, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-15', Yes, Yes),
(7, 2, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-15', No, Yes),
(5, 6, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-29', No, Yes),
(2, 4, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-15', No, Yes),
(10, 7, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-31', Yes, No),
(10, 4, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-17', No, Yes),
(4, 2, CAST('' AS VARCHAR_IGNORECASE), DATE '2017-12-31', No, Yes),
(2, 3, CAST('' AS VARCHAR_IGNORECASE), DATE '2018-01-02', No, No);               
CREATE CACHED TABLE HRS_SCH."Contractor"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.CONTRACTOR_SEQ) NOT NULL,
    "Name" VARCHAR_IGNORECASE(48) NOT NULL,
    "Address" VARCHAR_IGNORECASE(32) NOT NULL,
    "NIP_Number" BIGINT NOT NULL,
    "REGON_Number" BIGINT NOT NULL,
    "Bank_Account_Number" VARCHAR_IGNORECASE(28) NOT NULL,
    "Payment_Form" VARCHAR_IGNORECASE(12) NOT NULL,
    "Active_Taxpayer_VAT_Tax" BOOL NOT NULL
);      
ALTER TABLE HRS_SCH."Contractor" ADD CONSTRAINT HRS_SCH.CONSTRAINT_9 PRIMARY KEY("Id");       
-- 10 +/- SELECT COUNT(*) FROM HRS_SCH."Contractor";          
INSERT INTO HRS_SCH."Contractor"("Id", "Name", "Address", "NIP_Number", "REGON_Number", "Bank_Account_Number", "Payment_Form", "Active_Taxpayer_VAT_Tax") VALUES
(1, CAST('Company Name 9' AS VARCHAR_IGNORECASE), CAST('City5, Sample Street 5' AS VARCHAR_IGNORECASE), 5491357924, 567890123, CAST('01222233330000555566667777' AS VARCHAR_IGNORECASE), CAST('cash' AS VARCHAR_IGNORECASE), TRUE),
(2, CAST('Company Name 8' AS VARCHAR_IGNORECASE), CAST('City8, Sample Street 8' AS VARCHAR_IGNORECASE), 5498765432, 890123456, CAST('01222233330000333322221111' AS VARCHAR_IGNORECASE), CAST('transfer' AS VARCHAR_IGNORECASE), TRUE),
(3, CAST('Company Name 2' AS VARCHAR_IGNORECASE), CAST('City2, Sample Street 2' AS VARCHAR_IGNORECASE), 5492345678, 345678901, CAST('01222233330000555566667777' AS VARCHAR_IGNORECASE), CAST('cash' AS VARCHAR_IGNORECASE), TRUE),
(4, CAST('Company Name 5' AS VARCHAR_IGNORECASE), CAST('City4, Sample Street 4' AS VARCHAR_IGNORECASE), 5492345678, 890123456, CAST('01222233330000999988887777' AS VARCHAR_IGNORECASE), CAST('transfer' AS VARCHAR_IGNORECASE), TRUE),
(5, CAST('Company Name 8' AS VARCHAR_IGNORECASE), CAST('City1, Sample Street 1' AS VARCHAR_IGNORECASE), 5491234567, 234567890, CAST('01222233330000222233334444' AS VARCHAR_IGNORECASE), CAST('cash' AS VARCHAR_IGNORECASE), TRUE),
(6, CAST('Company Name 7' AS VARCHAR_IGNORECASE), CAST('City4, Sample Street 4' AS VARCHAR_IGNORECASE), 5491357924, 890123456, CAST('01222233330000555566667777' AS VARCHAR_IGNORECASE), CAST('cash' AS VARCHAR_IGNORECASE), TRUE),
(7, CAST('Company Name 9' AS VARCHAR_IGNORECASE), CAST('City6, Sample Street 6' AS VARCHAR_IGNORECASE), 5490123456, 456789012, CAST('01222233330000444433332222' AS VARCHAR_IGNORECASE), CAST('transfer' AS VARCHAR_IGNORECASE), TRUE),
(8, CAST('Company Name 1' AS VARCHAR_IGNORECASE), CAST('City8, Sample Street 8' AS VARCHAR_IGNORECASE), 5498765432, 456789012, CAST('01222233330000333322221111' AS VARCHAR_IGNORECASE), CAST('transfer' AS VARCHAR_IGNORECASE), TRUE),
(9, CAST('Company Name 2' AS VARCHAR_IGNORECASE), CAST('City10, Sample Street 10' AS VARCHAR_IGNORECASE), 5497654321, 890123456, CAST('01222233330000222233334444' AS VARCHAR_IGNORECASE), CAST('cash' AS VARCHAR_IGNORECASE), TRUE),
(10, CAST('Company Name 7' AS VARCHAR_IGNORECASE), CAST('City6, Sample Street 6' AS VARCHAR_IGNORECASE), 5490123456, 901234567, CAST('01222233330000555566667777' AS VARCHAR_IGNORECASE), CAST('transfer' AS VARCHAR_IGNORECASE), TRUE);     
CREATE CACHED TABLE HRS_SCH."Invoice"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.INVOICE_SEQ) NOT NULL,
    "Seller_Name" VARCHAR_IGNORECASE(48) NOT NULL,
    "Seller_Address" VARCHAR_IGNORECASE(32) NOT NULL,
    "Seller_NIP" BIGINT NOT NULL,
    "Seller_Account_Number" VARCHAR_IGNORECASE(28) NOT NULL,
    "Buyer_Name" VARCHAR_IGNORECASE(48) NOT NULL,
    "Buyer_Address" VARCHAR_IGNORECASE(32) NOT NULL,
    "Buyer_NIP" BIGINT NOT NULL,
    "Payment_Method" VARCHAR_IGNORECASE(12) NOT NULL,
    "Issue_Date" DATE NOT NULL,
    "Sale_Date" DATE NOT NULL,
    "Payment_Date" DATE NOT NULL,
    "Goods_Service" VARCHAR_IGNORECASE(48) NOT NULL,
    "Quantity" INT NOT NULL,
    "Net_Price" DECIMAL NOT NULL,
    TAX INT NOT NULL,
    "Gross_Price" DECIMAL NOT NULL,
    "Document_Issued" VARCHAR_IGNORECASE(24) NOT NULL
);   
ALTER TABLE HRS_SCH."Invoice" ADD CONSTRAINT HRS_SCH.CONSTRAINT_D PRIMARY KEY("Id");          
-- 10 +/- SELECT COUNT(*) FROM HRS_SCH."Invoice";             
INSERT INTO HRS_SCH."Invoice"("Id", "Seller_Name", "Seller_Address", "Seller_NIP", "Seller_Account_Number", "Buyer_Name", "Buyer_Address", "Buyer_NIP", "Payment_Method", "Issue_Date", "Sale_Date", "Payment_Date", "Goods_Service", "Quantity", "Net_Price", TAX, "Gross_Price", "Document_Issued") VALUES
(1, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 5' AS VARCHAR_IGNORECASE), CAST('City10, Sample Street 10' AS VARCHAR_IGNORECASE), 5499876543, CAST('cash' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 6' AS VARCHAR_IGNORECASE), 8, 3000.00, 23, 3150.00, CAST('Abacki' AS VARCHAR_IGNORECASE)),
(2, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 9' AS VARCHAR_IGNORECASE), CAST('City4, Sample Street 4' AS VARCHAR_IGNORECASE), 5492345678, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 9' AS VARCHAR_IGNORECASE), 5, 2000.00, 23, 2450.00, CAST('Babacki' AS VARCHAR_IGNORECASE)),
(3, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 3' AS VARCHAR_IGNORECASE), CAST('City6, Sample Street 6' AS VARCHAR_IGNORECASE), 5494297531, CAST('cash' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 6' AS VARCHAR_IGNORECASE), 8, 1900.00, 23, 1900.00, CAST('Babacki' AS VARCHAR_IGNORECASE)),
(4, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 8' AS VARCHAR_IGNORECASE), CAST('City8, Sample Street 8' AS VARCHAR_IGNORECASE), 5493456789, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 1' AS VARCHAR_IGNORECASE), 5, 3000.00, 23, 2300.00, CAST('Babacki' AS VARCHAR_IGNORECASE)),
(5, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 10' AS VARCHAR_IGNORECASE), CAST('City7, Sample Street 7' AS VARCHAR_IGNORECASE), 5490123456, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 6' AS VARCHAR_IGNORECASE), 9, 2000.00, 23, 2450.00, CAST('Babacki' AS VARCHAR_IGNORECASE)),
(6, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 7' AS VARCHAR_IGNORECASE), CAST('City6, Sample Street 6' AS VARCHAR_IGNORECASE), 5499876543, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 2' AS VARCHAR_IGNORECASE), 10, 1800.00, 23, 1250.00, CAST('Babacki' AS VARCHAR_IGNORECASE)),
(7, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 3' AS VARCHAR_IGNORECASE), CAST('City4, Sample Street 4' AS VARCHAR_IGNORECASE), 5494297531, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 9' AS VARCHAR_IGNORECASE), 10, 1000.00, 23, 1540.00, CAST('Abacki' AS VARCHAR_IGNORECASE)),
(8, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 8' AS VARCHAR_IGNORECASE), CAST('City3, Sample Street 3' AS VARCHAR_IGNORECASE), 5497654321, CAST('cash' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 9' AS VARCHAR_IGNORECASE), 9, 1000.00, 23, 1250.00, CAST('Abacki' AS VARCHAR_IGNORECASE));            
INSERT INTO HRS_SCH."Invoice"("Id", "Seller_Name", "Seller_Address", "Seller_NIP", "Seller_Account_Number", "Buyer_Name", "Buyer_Address", "Buyer_NIP", "Payment_Method", "Issue_Date", "Sale_Date", "Payment_Date", "Goods_Service", "Quantity", "Net_Price", TAX, "Gross_Price", "Document_Issued") VALUES
(9, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 9' AS VARCHAR_IGNORECASE), CAST('City7, Sample Street 7' AS VARCHAR_IGNORECASE), 5498765432, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 10' AS VARCHAR_IGNORECASE), 6, 1800.00, 23, 2450.00, CAST('Babacki' AS VARCHAR_IGNORECASE)),
(10, CAST('Our company' AS VARCHAR_IGNORECASE), CAST('Oswiecim, ul. Zamkowa 5' AS VARCHAR_IGNORECASE), 5491213145, CAST('01222233330000111122223333' AS VARCHAR_IGNORECASE), CAST('Company Name 7' AS VARCHAR_IGNORECASE), CAST('City3, Sample Street 3' AS VARCHAR_IGNORECASE), 5493456789, CAST('transfer' AS VARCHAR_IGNORECASE), DATE '2017-12-05', DATE '2017-12-05', DATE '2017-12-19', CAST('Training Name 10' AS VARCHAR_IGNORECASE), 10, 1900.00, 23, 2380.00, CAST('Abacki' AS VARCHAR_IGNORECASE));   
CREATE CACHED TABLE HRS_SCH."Contractor_Users"(
    "Contractor_ID" INT NOT NULL,
    "Users_ID" INT NOT NULL,
    "Note" VARCHAR_IGNORECASE(48),
    "Active_Worker" BOOL NOT NULL,
    "Participation" ENUM('No','Yes')
);            
-- 10 +/- SELECT COUNT(*) FROM HRS_SCH."Contractor_Users";    
INSERT INTO HRS_SCH."Contractor_Users"("Contractor_ID", "Users_ID", "Note", "Active_Worker", "Participation") VALUES
(9, 1, CAST('staly klient' AS VARCHAR_IGNORECASE), TRUE, No),
(3, 1, CAST('' AS VARCHAR_IGNORECASE), FALSE, Yes),
(9, 4, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes),
(4, 8, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes),
(8, 9, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes),
(3, 3, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes),
(4, 7, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes),
(8, 7, CAST('staly klient' AS VARCHAR_IGNORECASE), TRUE, Yes),
(8, 2, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes),
(1, 6, CAST('' AS VARCHAR_IGNORECASE), TRUE, Yes);          
CREATE CACHED TABLE HRS_SCH."Leave"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.LEAVE_SEQ) NOT NULL,
    "Users_Id" INT NOT NULL,
    "Create_date" DATE NOT NULL,
    "Start_date" DATE NOT NULL,
    "End_date" DATE NOT NULL,
    "Leave_dimension" INT NOT NULL,
    "Overdue_leave" INT NOT NULL,
    "Days_used" INT NOT NULL,
    "Agreed" ENUM('No','Yes') NOT NULL,
    "Disagree_reason" VARCHAR_IGNORECASE(64)
);     
ALTER TABLE HRS_SCH."Leave" ADD CONSTRAINT HRS_SCH.CONSTRAINT_45 PRIMARY KEY("Id");           
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Leave";
ALTER TABLE HRS_SCH."Users_Training_list" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DC FOREIGN KEY("Training_ID") REFERENCES HRS_SCH."Training"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;    
ALTER TABLE HRS_SCH."Contractor_Users" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DF FOREIGN KEY("Contractor_ID") REFERENCES HRS_SCH."Contractor"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;   
ALTER TABLE HRS_SCH."Users_Training_list" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DC2 FOREIGN KEY("Users_ID") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;         
ALTER TABLE HRS_SCH."Contractor_Users" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DF5 FOREIGN KEY("Users_ID") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;            
ALTER TABLE HRS_SCH."Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4FE FOREIGN KEY("Author_Id") REFERENCES HRS_SCH."Users"("Id") NOCHECK;       
ALTER TABLE HRS_SCH."Roles" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4B7 FOREIGN KEY("Permission") REFERENCES HRS_SCH."Permissions"("Id") NOCHECK;   
ALTER TABLE HRS_SCH."Leave" ADD CONSTRAINT HRS_SCH.CONSTRAINT_45E FOREIGN KEY("Users_Id") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;       
GRANT ALL ON SCHEMA HRS_SCH TO HRS_USER;      
