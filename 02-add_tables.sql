SET IGNORECASE 1;             
;             
ALTER USER SA SET SALT '3eda9e583a4acb3f' HASH '61cd5cf78f6cdf9a6044b2ec0e7554c6eb00a95f24fbb6420d720c1c9a40ba3d';
CREATE USER IF NOT EXISTS HRS_USER SALT 'e3d1fbfee212fc9f' HASH '5627dd7253bf3cdf957276f5b88eb8cf2b578a40717adbe998477d96aa593344' ADMIN;
           

CREATE SCHEMA IF NOT EXISTS HRS_SCH AUTHORIZATION HRS_USER;   
CREATE SEQUENCE HRS_SCH.PERMISSIONS_SEQ START WITH 1 MAXVALUE 99999;         
CREATE SEQUENCE HRS_SCH.ROLES_SEQ START WITH 1 MAXVALUE 99999;
CREATE SEQUENCE HRS_SCH.USERS_SEQ START WITH 1 MAXVALUE 99999;
CREATE CACHED TABLE HRS_SCH."Users"(
    "Id" INT DEFAULT (NEXT VALUE FOR HRS_SCH.USERS_SEQ) NOT NULL,
    "Role" VARCHAR_IGNORECASE(24) NOT NULL,
    "Pass" VARCHAR_IGNORECASE(60) NOT NULL,
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
ALTER TABLE HRS_SCH."Roles" ADD CONSTRAINT HRS_SCH.CONSTRAINT_4B7 FOREIGN KEY("Permission") REFERENCES HRS_SCH."Permissions"("Id") NOCHECK;   
GRANT ALL ON SCHEMA HRS_SCH TO HRS_USER;      
