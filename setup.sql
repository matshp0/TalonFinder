CREATE SCHEMA IF NOT EXISTS "apiDB";


CREATE TYPE user_role AS ENUM ('admin', 'user');

CREATE TABLE IF NOT EXISTS "apiDB"."Account" (
  "id" INTEGER PRIMARY KEY,
  "role" user_role NOT NULL DEFAULT 'user',
  "createdAt" TIMESTAMP DEFAULT NOW(),
  "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "apiDB"."Question" (
     "id" INTEGER PRIMARY KEY,
     "category" VARCHAR(255),
     "createdAt" TIMESTAMP DEFAULT NOW(),
     "updatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "apiDB"."Office" (
    "id" INTEGER PRIMARY KEY,
    "address" VARCHAR(255),
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

CREATE TABLE "apiDB"."Cookie" (
  id SERIAL PRIMARY KEY,
  value TEXT
);

SELECT * FROM "apiDB"."AccountOffice" JOIN "apiDB"."Office" On "AccountOffice"."officeId" = "Office".id;

INSERT INTO "apiDB"."Cookie" (value) VALUES ('cookie');

INSERT INTO "apiDB"."Question" ("id")
VALUES ('56');
INSERT INTO "apiDB"."Question" ("id")
VALUES ('49');



UPDATE "apiDB"."Question" SET "category" = 'Практичний іспит на категорію В (транспортний засіб сервісного центру з механічною коробкою передач)' WHERE "id" = 49;
UPDATE "apiDB"."Question" SET "category" = 'Практичний іспит на категорію В (транспортний засіб автошколи з механічною коробкою передач)' WHERE "id" = 56;

INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (3, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Бровари, вул. Броварської сотні, 4А');


INSERT INTO "apiDB"."Account" ("id", "role")
VALUES (303314235, 'user');

INSERT INTO "apiDB"."Account" ("id", "role")
VALUES (725433593, 'admin');

INSERT INTO "apiDB"."AccountOffice" ("accountId", "officeId")
VALUES (303314235, '3');

INSERT INTO "apiDB"."AccountOffice" ("accountId", "officeId")
VALUES (725433593, '3');

INSERT INTO "apiDB"."AccountQuestion" ("accountId", "questionId")
VALUES (725433593, '49');
