CREATE SCHEMA IF NOT EXISTS "apiDB";


CREATE TYPE user_role AS ENUM ('admin', 'user');

CREATE TABLE IF NOT EXISTS "apiDB"."Account" (
  "id" INTEGER PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "apiDB"."Question" (
     "id" INTEGER PRIMARY KEY,
     "createdAt" TIMESTAMP DEFAULT NOW(),
     "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "apiDB"."Office" (
    "id" INTEGER PRIMARY KEY,
    "status" SMALLINT,
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "apiDB"."Date" (
  "dateValue" DATE PRIMARY KEY,
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "apiDB"."AccountOffice" (
   "accountId" INTEGER NOT NULL REFERENCES "apiDB"."Account" (id),
   "officeId" INTEGER NOT NULL REFERENCES "apiDB"."Office" (id),
   "createdAt" TIMESTAMP DEFAULT NOW(),
   "updatedAt" TIMESTAMP DEFAULT NOW(),
   PRIMARY KEY ("accountId", "officeId")
);


CREATE TABLE IF NOT EXISTS "apiDB"."DateOffice" (
    "officeId" INTEGER NOT NULL REFERENCES "apiDB"."Office" (id),
    "date" DATE NOT NULL,
    "questionId" INTEGER NOT NULL REFERENCES "apiDB"."Question" (id),
    "status" SMALLINT,
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW(),
   PRIMARY KEY ("officeId", "date", "questionId")
);

CREATE TABLE IF NOT EXISTS "apiDB"."AccountQuestion" (
    "questionId" INTEGER NOT NULL REFERENCES "apiDB"."Question" (id),
    "accountId" INTEGER NOT NULL REFERENCES "apiDB"."Account" (id),
    "createdAt" TIMESTAMP DEFAULT NOW(),
    "updatedAt" TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY ("accountId", "questionId")
);



DO $$
    BEGIN
        FOR i IN 151..200 LOOP
                INSERT INTO "apiDB"."Office" ("id", "status", "createdAt", "updatedAt")
                VALUES (i, 4, NOW(), NOW());
            END LOOP;
    END $$;

INSERT INTO "apiDB"."Question" ("id")
VALUES ('56');
INSERT INTO "apiDB"."Question" ("id")
VALUES ('55');

INSERT INTO "apiDB"."Account" ("id")
VALUES ('725433593');

INSERT INTO "apiDB"."AccountQuestion" ("questionId", "accountId")
VALUES ('56', '725433593');

INSERT INTO "apiDB"."AccountQuestion" ("questionId", "accountId")
VALUES ('55', '725433593');



