SET IGNORECASE 1;             
;             
CREATE USER IF NOT EXISTS HRS_USER SALT '602e49c9d8eb8bdd' HASH '36739355bb004cc9ae266202735535589428fd853c95d72491520c2dbb3562e5' ADMIN;     
CREATE USER IF NOT EXISTS SA SALT '9001f728ab9c9b01' HASH '7e59bdd2056970216715dc0db05ab0aca8962aa573096bf3530c6c808ba822a2' ADMIN;           
CREATE SCHEMA IF NOT EXISTS HRS_SCH AUTHORIZATION HRS_USER;   
CREATE SEQUENCE HRS_SCH.PERMISSSIONS_SEQ START WITH 1 MAXVALUE 99999;         
CREATE SEQUENCE HRS_SCH.ROLES_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.USERS_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.TRAINING_SEQ START WITH 1 MAXVALUE 99999;             
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
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Users";
CREATE CACHED TABLE HRS_SCH."Roles"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.ROLES_SEQ) NOT NULL,
    "Name" VARCHAR_IGNORECASE(32) NOT NULL,
    "Permission" VARCHAR_IGNORECASE(32) NOT NULL
);    
ALTER TABLE HRS_SCH."Roles" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4B PRIMARY KEY("Id");           
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Roles";
CREATE CACHED TABLE HRS_SCH."Permissions"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.PERMISSSIONS_SEQ) NOT NULL,
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
-- 0 +/- SELECT COUNT(*) FROM HRS_SCH."Training";             
ALTER TABLE HRS_SCH."Roles" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4B7 FOREIGN KEY("Permission") REFERENCES HRS_SCH."Permissions"("Id") NOCHECK;   
ALTER TABLE HRS_SCH."Training" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4FE FOREIGN KEY("Author_Id") REFERENCES HRS_SCH."Users"("Id") NOCHECK;         
GRANT ALL ON SCHEMA HRS_SCH TO HRS_USER;      
