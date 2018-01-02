SET IGNORECASE 1;             
;             
ALTER USER SA SET SALT '7ae6135bfbcc1e17' HASH 'a4cfe7b5ac128b3d643c2f5682254b3f4aa4d4f1e3368208db24c8368fc9ad6a';           
CREATE USER IF NOT EXISTS HRS_USER SALT 'bc176d542009ef66' HASH 'd3553cf4e4269ea192e87bbba777384943664122d00cf5a520da13995a8e5699' ADMIN;     
CREATE SCHEMA IF NOT EXISTS HRS_SCH AUTHORIZATION HRS_USER;   
CREATE SEQUENCE HRS_SCH.CONTRACTOR_SEQ START WITH 1 MAXVALUE 99999;           
CREATE SEQUENCE HRS_SCH.ROLES_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.SALARIES_SEQ START WITH 1 MAXVALUE 999999;            
CREATE SEQUENCE HRS_SCH.PERMISSIONS_SEQ START WITH 1 MAXVALUE 99999;          
CREATE SEQUENCE HRS_SCH.LEAVE_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.INVOICE_SEQ START WITH 1 MAXVALUE 99999;              
CREATE SEQUENCE HRS_SCH.USERS_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.TRAINING_SEQ START WITH 1 MAXVALUE 99999;             
CREATE CACHED TABLE HRS_SCH."Users"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.USERS_SEQ) NOT NULL,
    "Role" VARCHAR_IGNORECASE(24) NOT NULL,
    "Pass" VARCHAR_IGNORECASE(60) NOT NULL,
    "Status" BOOL NOT NULL,
    "Pass_Expire" DATE NOT NULL,
    "Username" VARCHAR_IGNORECASE(24) NOT NULL,
    "e-mail" VARCHAR_IGNORECASE(24) NOT NULL,
    "Pass_changed_date" DATE NOT NULL,
    "Login_last_success" DATE NOT NULL,
    "Login_last_failed" DATE NOT NULL,
    "Login_attempts_failed" INT NOT NULL,
    "Address" VARCHAR_IGNORECASE(64) NOT NULL COMMENT 'Dla obliczenia kosztow uzyskania przychodu przydatny',
    "Employment_start_date" DATE NOT NULL COMMENT 'Zatrudniony od - do kolumny Salaries.Seniority',
    "Position" VARCHAR_IGNORECASE(64) NOT NULL COMMENT 'Stanowisko - do kolumny Salaries.Salary_supplement',
    "TAX_office" VARCHAR_IGNORECASE(32) NOT NULL COMMENT 'US wlasciwy dla uzytkownika'
);    
ALTER TABLE HRS_SCH."Users" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4 PRIMARY KEY("Id");            
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Users";
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
    "Cancelled" BOOL NOT NULL,
    "No_of_seats" INT NOT NULL
);      
ALTER TABLE HRS_SCH."Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4F PRIMARY KEY("Id");        
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Training";             
CREATE CACHED TABLE HRS_SCH."User_Training"(
    "Training_ID" INT NOT NULL,
    "Users_ID" INT NOT NULL,
    "Note" VARCHAR_IGNORECASE(48),
    "Date_of_sign" DATE NOT NULL,
    "Cancelled" BOOL NOT NULL,
    "Agreed" BOOL NOT NULL
);           
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."User_Training";       
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
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Contractor";           
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
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Invoice";              
CREATE CACHED TABLE HRS_SCH."Contractor_Users"(
    "Contractor_ID" INT NOT NULL,
    "Users_ID" INT NOT NULL,
    "Note" VARCHAR_IGNORECASE(48),
    "Active_Worker" BOOL NOT NULL,
    "Participation" BOOL NOT NULL
);               
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Contractor_Users";     
CREATE CACHED TABLE HRS_SCH."Leave"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.LEAVE_SEQ) NOT NULL,
    "Users_Id" INT NOT NULL,
    "Create_date" DATE NOT NULL,
    "Start_date" DATE NOT NULL,
    "End_date" DATE NOT NULL,
    "Leave_dimension" INT NOT NULL,
    "Overdue_leave" INT NOT NULL,
    "Days_used" INT NOT NULL,
    "Agreed" BOOL NOT NULL,
    "Disagree_reason" VARCHAR_IGNORECASE(64)
); 
ALTER TABLE HRS_SCH."Leave" ADD CONSTRAINT HRS_SCH.CONSTRAINT_45 PRIMARY KEY("Id");           
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Leave";
CREATE CACHED TABLE HRS_SCH."Salaries"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.SALARIES_SEQ) NOT NULL,
    "Users_Id" INT NOT NULL COMMENT 'klucz obcy do tabeli Users.Id',
    "Employment_arrangement" VARCHAR_IGNORECASE(24) NOT NULL COMMENT 'wymiar etatu, np. pelny etat',
    "Base_salary" DECIMAL NOT NULL,
    "Seniority" INT NOT NULL COMMENT 'Wys�uga lat - staz',
    "Salary_supplement" DECIMAL NOT NULL COMMENT 'Dodatki do wyplaty, zalezne od stanowiska itp.',
    "Employment_status" VARCHAR_IGNORECASE(24) NOT NULL COMMENT 'Rodzaj umowy, np. na czas okreslony, nieokreslony, probny'
);          
ALTER TABLE HRS_SCH."Salaries" ADD CONSTRAINT HRS_SCH.CONSTRAINT_7 PRIMARY KEY("Id");         
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Salaries";             
ALTER TABLE HRS_SCH."User_Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DC FOREIGN KEY("Training_ID") REFERENCES HRS_SCH."Training"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;         
ALTER TABLE HRS_SCH."Salaries" ADD CONSTRAINT HRS_SCH.CONSTRAINT_77 FOREIGN KEY("Users_Id") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;     
ALTER TABLE HRS_SCH."Contractor_Users" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DF FOREIGN KEY("Contractor_ID") REFERENCES HRS_SCH."Contractor"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;   
ALTER TABLE HRS_SCH."User_Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DC2 FOREIGN KEY("Users_ID") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;              
ALTER TABLE HRS_SCH."Contractor_Users" ADD CONSTRAINT HRS_SCH.CONSTRAINT_DF5 FOREIGN KEY("Users_ID") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;            
ALTER TABLE HRS_SCH."Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4FE FOREIGN KEY("Author_Id") REFERENCES HRS_SCH."Users"("Id") NOCHECK;       
ALTER TABLE HRS_SCH."Roles" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4B7 FOREIGN KEY("Permission") REFERENCES HRS_SCH."Permissions"("Id") NOCHECK;   
ALTER TABLE HRS_SCH."Leave" ADD CONSTRAINT HRS_SCH.CONSTRAINT_45E FOREIGN KEY("Users_Id") REFERENCES HRS_SCH."Users"("Id") ON DELETE CASCADE ON UPDATE CASCADE NOCHECK;       
GRANT ALL ON SCHEMA HRS_SCH TO HRS_USER;      
