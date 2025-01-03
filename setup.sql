CREATE SCHEMA IF NOT EXISTS "apiDB";


CREATE TYPE user_role AS ENUM ('admin', 'user');

CREATE TABLE IF NOT EXISTS "Account" (
  "id" INTEGER PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "Question" (
     "id" INTEGER PRIMARY KEY,
     "createdAt" TIMESTAMP DEFAULT NOW(),
     "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "Office" (
    "id" INTEGER PRIMARY KEY,
    "status" SMALLINT,
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "AccountOffice" (
   "accountId" INTEGER NOT NULL REFERENCES "Account" (id),
   "officeId" INTEGER NOT NULL REFERENCES "Office" (id),
   "createdAt" TIMESTAMP DEFAULT NOW(),
   "updatedAt" TIMESTAMP DEFAULT NOW(),
   PRIMARY KEY ("accountId", "officeId")
);

CREATE TABLE "Date" (
    "dateValue" DATE PRIMARY KEY,
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "DateOffice" (
    "officeId" INTEGER NOT NULL REFERENCES "Office" (id),
    "date" DATE NOT NULL,
    "questionId" INTEGER NOT NULL REFERENCES "Question" (id),
    "status" SMALLINT,
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW(),
   PRIMARY KEY ("officeId", "date", "questionId")
);

CREATE TABLE IF NOT EXISTS "AccountQuestion" (
    "questionId" INTEGER NOT NULL REFERENCES "Question" (id),
    "accountId" INTEGER NOT NULL REFERENCES "Account" (id),
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY ("accountId", "questionId")
);


CREATE TABLE IF NOT EXISTS "AccountOffice" (
   "accountId" INTEGER NOT NULL REFERENCES "Account" (id),
   "officeId" INTEGER NOT NULL REFERENCES "Office" (id),
   "createdAt" TIMESTAMP DEFAULT NOW(),
   "updatedAt" TIMESTAMP DEFAULT NOW(),
   PRIMARY KEY ("accountId", "officeId")
);


DO $$
    BEGIN
        FOR i IN 151..200 LOOP
                INSERT INTO "Office" ("id", "status", "createdAt", "updatedAt")
                VALUES (i, 4, NOW(), NOW());
            END LOOP;
    END $$;


INSERT INTO "Account" ("id")
VALUES ('725433593');

INSERT INTO "AccountQuestion" ("questionId", "accountId")
VALUES ('56', '725433593');

INSERT INTO "AccountQuestion" ("questionId", "accountId")
VALUES ('55', '725433593');



