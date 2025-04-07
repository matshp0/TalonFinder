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

INSERT INTO "apiDB"."Cookie" ("id", "value")
VALUES (1, 'cookie');

INSERT INTO "apiDB"."Account" ("id", "role")
VALUES (725433593, 'admin');

INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (1, 'ТСЦ МВС № 3241, м. Баришівка, вул. Польова, вул. Польова 3 ', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (2, 'ТСЦ МВС № 3242, м. Біла Церква,  вул. Сухоярська,  вул. Сухоярська 20', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (3, 'ТСЦ МВС № 3243, м. Бровари, вул. Броварської Сотні, вул. Броварської Сотні 4А', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (4, 'ТСЦ МВС № 3244 , м. Обухів, вул. Каштанова, вул. Каштанова 23 ', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (5, 'ТСЦ МВС № 3245, м. Вишгород, Кургузова, Кургузова 7-А', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (6, 'ТСЦ МВС № 3246, с. Софіївська Борщагівка, вул. Малишко, вул. Малишко 2', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (7, 'ТСЦ МВС № 3247 , м. Буча, вул. Депутатська, вул. Депутатська 1 в', '2025-04-04 18:34:12.277000', '2025-04-04 18:34:12.277000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (8, 'ТСЦ МВС № 3248 , м. Переяслав, вул. Ново-Київське шосе, вул. Ново-Київське шосе 46 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (9, 'ТСЦ МВС № 3249, с. Білоцерківський район, с. Винарівка, вул. Лісова, вул. Лісова 39 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (11, 'ТСЦ МВС № 0541, м. Вінниця, вул. Ботанічна, вул. Ботанічна 24 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (12, 'ТСЦ МВС № 0542, м. Гайсин, вул. Південна, вул. Південна 67 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (14, 'ТСЦ МВС № 0544, м. Тульчин, вул. Леонтовича, вул. Леонтовича 55 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (13, 'ТСЦ МВС № 0543, м. Шаргород, вул. Героїв Майдану, вул. Героїв Майдану 224 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (15, 'ТСЦ МВС № 0545, с. Великий Митник, вул. 57км+1000, вул. 57км+1000 урочище буд. 2', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (16, 'ТСЦ МВС № 0546, м. Вінниця, вул. Брацлавська, вул. Брацлавська 85 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (18, 'ТСЦ МВС № 0742, м. Ковель, вул. Володимирська, вул. Володимирська 133 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (17, 'ТСЦ МВС № 0741, с. Луцький р-н, с. Струмівка, вул. Рівненська, вул. Рівненська 74 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (21, 'ТСЦ МВС № 1241, м. Дніпро, вул. Сонячна Набережна, вул. Сонячна Набережна 130 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (19, 'ТСЦ МВС № 0743, м. Камінь-Каширський, вул. Магдебурзького права, вул. Магдебурзького права 42 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (20, 'ТСЦ МВС № 0744, м. Нововолинськ, вул. Сокальська, вул. Сокальська 1 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (22, 'ТСЦ МВС №1242, м. Дніпро, пр. Праці, пр. Праці 16 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (23, 'ТСЦ МВС № 1243, м. Кривий Ріг, вул. Вільної Ічкерії, вул. Вільної Ічкерії 45333 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (24, 'ТСЦ МВС № 1244, м. Кам''янське, вул. Фіалкова, вул. Фіалкова 79 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (25, 'ТСЦ МВС № 1245, м. Покров, вул. Уральська, вул. Уральська 1 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (26, 'ТСЦ МВС № 1246, м. Самар, вул. Спаська, вул. Спаська 7', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (27, 'ТСЦ МВС № 1247, м. Павлоград, вул. Дніпровська, вул. Дніпровська 334 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (28, 'ТСЦ МВС № 1248, м. Кривий Ріг, вул. Стрельнікова, вул. Стрельнікова 15 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (29, 'ТСЦ МВС № 1249, м. Дніпро, пр-т. Слобожанський, пр-т. Слобожанський 31 д', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (31, 'ТСЦ МВС № 1452, м. Краматорськ, вул. Героїв Небесної Сотні, вул. Героїв Небесної Сотні 5 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (30, 'ТСЦ МВС № 1451, м. Добропілля, вул. Банкова, вул. Банкова 45 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (34, 'ТСЦ МВС № 1843, м. Коростень, вул. Сергія Кемського, вул. Сергія Кемського 3 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (33, 'ТСЦ МВС № 1842, м. Бердичів, вул. Шкіряників, вул. Шкіряників 14 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (32, 'ТСЦ МВС № 1841, с. Довжик, вул. Богунська, вул. Богунська 1 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (35, 'ТСЦ МВС № 1844, м. Звягель, вул. Відродження, вул. Відродження 2 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (36, 'ТСЦ МВС № 1845, м. Радомишль, вул. Міськради, вул. Міськради 12 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (37, 'ТСЦ МВС № 2141, м. Ужгород, вул. О. Кошового, вул. О. Кошового 4 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (40, 'ТСЦ МВС № 2144, м. Хуст, вул. Окружна, вул. Окружна 34 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (38, 'ТСЦ МВС № 2142, с. Мукачівський р-н., с. Клячаново, вул. Автомобілістів, вул. Автомобілістів 28 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (39, 'ТСЦ МВС № 2143, м. Тячів, вул. Промислова, вул. Промислова 6 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (41, 'ТСЦ МВС № 2146, с. Берегівський р-н., с. Камянське, вул. Українська, вул. Українська 1', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (42, 'ТСЦ МВС № 2341, м. Запоріжжя, вул. Олександрівська, вул. Олександрівська 84 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (43, 'ТСЦ МВС № 2342, м. Запоріжжя, вул. Бабури козака, вул. Бабури козака 9 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (45, 'ТСЦ МВС № 2348, с. Сонячне, вул. Сонячне шосе, вул. Сонячне шосе 2 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (44, 'ТСЦ МВС № 2343, м. Запоріжжя, вул. Бабури козака, вул. Бабури козака 9 а', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (46, 'ТСЦ МВС № 2641, м. Івано-Франківськ, вул. Коновальця, вул. Коновальця 229 у', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (49, 'ТСЦ МВС № 2644, м. Снятин, вул. Воєводи Коснятина, вул. Воєводи Коснятина 60 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (47, 'ТСЦ МВС № 2642, м. Калуш, вул. Грушевського, вул. Грушевського 104 ', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (48, 'ТСЦ МВС № 2643, м. Коломия, вул. Симоненка, вул. Симоненка 2 в', '2025-04-04 18:34:12.278000', '2025-04-04 18:34:12.278000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (64, 'ТСЦ МВС № 3545, м. Благовіщенське, вул. Ореста Гуменюка, вул. Ореста Гуменюка 11 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (68, 'ТСЦ МВС № 4644, м. Самбір, вул. Східна, вул. Східна 216 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (74, 'ТСЦ МВС № 4651, м. Львів, вул. Богданівська, вул. Богданівська 44 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (79, 'ТСЦ МВС № 4845, м. Новий Буг, вул. Площа Свободи, вул. Площа Свободи 1 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (84, 'ТСЦ МВС № 5146, м. Роздільна, вул. Кишинівська, вул. Кишинівська 2 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (89, 'ТСЦ МВС № 5151, м. Болград, вул. Лісна, вул. Лісна 2 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (94, 'ТСЦ МВС № 5343, м. Лубни, пр-т. Володимирський, пр-т. Володимирський 178 б', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (99, 'ТСЦ МВС № 5348, м. Горішні Плавні, вул. Строна, вул. Строна 11-А', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (105, 'ТСЦ МВС № 5942 (крім практичного іспиту), м. Конотоп, вул. Садова, вул. Садова 39', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (111, 'ТСЦ МВС № 6142, м. Підгайці, вул. Замкова, вул. Замкова 18 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (118, 'ТСЦ МВС № 6344, м. Ізюм, вул. Весняна, вул. Весняна 45 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (122, 'ТСЦ МВС № 6348, м. Лозова, вул. мр-н 1, вул. мр-н 1 21', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (128, 'ТСЦ МВС № 6842, м. Дунаївці, вул. Франца Лендера, вул. Франца Лендера 41 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (133, 'ТСЦ МВС № 7142, с. Уманський р-н., с/рада Родниківська, вул. автодорога Київ-Одеса  203 км 800 м, вул. автодорога Київ-Одеса  203 км 800 м б/н ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (138, 'ТСЦ МВС № 7342, м. Кіцмань, вул. Незалежності, вул. Незалежності 1 б', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (143, 'ТСЦ МВС № 7442, м. Прилуки, вул. Індустріальна, вул. Індустріальна 6', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (149, 'ТСЦ МВС № 8044, м. Київ, вул. Братиславська, вул. Братиславська 52 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (50, 'ТСЦ МВС № 2645, м. Надвірна, вул. Визволення, вул. Визволення 2 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (62, 'ТСЦ МВС № 3543, м. Бобринець, вул. Миколаївська, вул. Миколаївська 172 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (70, 'ТСЦ МВС № 4646, м. Шептицький, вул. Корольова, вул. Корольова 14 а', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (73, 'ТСЦ МВС № 4650, м. Жовква, вул. Вокзальна, вул. Вокзальна 10 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (78, 'ТСЦ МВС № 4844, м. Вознесенськ, вул. Молодогвардійська, вул. Молодогвардійська 45 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (82, 'ТСЦ МВС № 5143, м. Білгород-Дністровський, вул. Ігоря Іванова, вул. Ігоря Іванова 4 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (87, 'ТСЦ МВС № 5149, м. Подільськ, вул. Соборна, вул. Соборна 202 б', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (92, 'ТСЦ МВС № 5341, с. Розсошенці, вул. Кременчуцька, вул. Кременчуцька 2 в', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (97, 'ТСЦ МВС № 5346, с. Бутенки, вул. Зоріна, вул. Зоріна 7 а', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (102, 'ТСЦ МВС № 5643, м. Сарни, вул. Костопільська, вул. Костопільська 100 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (107, 'ТСЦ МВС № 5944, м. Ромни, вул. Полтавська, вул. Полтавська 4 а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (112, 'ТСЦ МВС № 6143, м. Кременець, вул. Шевченка, вул. Шевченка 67 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (116, 'ТСЦ МВС № 6342, м. Харків, вул. Станція метро «Київська» вестибюль №1, вул. Станція метро «Київська» вестибюль №1  ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (124, 'ТСЦ МВС № 6350, смт. Пісочин, вул. Транспортна, вул. Транспортна 116', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (127, 'ТСЦ МВС № 6841, м. Хмельницький, вул. Західно-Окружна,, вул. Західно-Окружна, 11/1', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (132, 'ТСЦ МВС № 7141, м. Черкаси, вул. Лесі Українки, вул. Лесі Українки 21 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (136, 'ТСЦ МВС № 7145, м. Золотоноша, вул. Відродження, вул. Відродження 16 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (141, 'ТСЦ МВС № 7345, с. Кельменці, вул. О.Паламаря, вул. О.Паламаря 9 в', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (146, 'ТСЦ МВС № 8041, м. Київ, вул. Перемоги, вул. Перемоги 20 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (150, 'ТСЦ МВС № 8045, м. Київ, вул. Павла Усенка, вул. Павла Усенка 8 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (153, 'ТСЦ МВС № 8048, м. Київ, вул. Миколи Грінченка, вул. Миколи Грінченка 18 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (60, 'ТСЦ МВС № 3541, м. Кропивницький, пр-т. Інженерів, пр-т. Інженерів 9/92 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (65, 'ТСЦ МВС № 4641, м. Львів, вул. Д. Апостола, вул. Д. Апостола 11 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (67, 'ТСЦ МВС № 4643, с. Галицьке, вул. Л. Українки, вул. Л. Українки 1 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (72, 'ТСЦ МВС № 4649, с. Зимна Вода, вул. Городоцька, вул. Городоцька 16 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (76, 'ТСЦ МВС № 4842, м. Первомайськ, вул. Вознесенська, вул. Вознесенська 73 б', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (81, 'ТСЦ МВС № 5142, с. Лиманський р-н., с. Крижанівка, вул. Ак. Сахарова, вул. Ак. Сахарова 1 г', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (85, 'ТСЦ МВС № 5147, смт. Доброслав, вул. Промислова, вул. Промислова 29 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (91, 'ТСЦ МВС № 5154, м. Одеса, вул. Аеропортівська, вул. Аеропортівська 27/1', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (95, 'ТСЦ МВС № 5344, м. Миргород, вул. Анатолія Карбана, вул. Анатолія Карбана 14 а', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (100, 'ТСЦ МВС № 5641, м. Рівне, вул. Київська, вул. Київська 108 б', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (103, 'ТСЦ МВС № 5644, с. Володимирець, вул. Соборна, вул. Соборна 49 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (108, 'ТСЦ МВС № 5945, м. Шостка, вул. Героїв Шосткинщини, вул. Героїв Шосткинщини 24-А', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (113, 'ТСЦ МВС № 6144, м. Теребовля, вул. Січових Стрельців, вул. Січових Стрельців 64-А', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (117, 'ТСЦ МВС № 6343, м. Богодухів, вул. Миколи Моргунова, вул. Миколи Моргунова 7 а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (123, 'ТСЦ МВС № 6349, м. Мерефа, вул. Дніпровська, вул. Дніпровська 133 а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (126, 'ТСЦ МВС № 6542, с. Велика Олександрівка, вул. Закарпатська, вул. Закарпатська 32 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (131, 'ТСЦ МВС № 6845, м. Шепетівка, вул. Володимира Українця, вул. Володимира Українця 13 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (137, 'ТСЦ МВС № 7341, м. Чернівці, вул. Руська, вул. Руська 248 м', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (142, 'ТСЦ МВС № 7441, м. Чернігів, Шевченка, Шевченка 162а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (148, 'ТСЦ МВС № 8043, м. Київ, пр. Європейського Союзу, пр. Європейського Союзу 47 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (154, 'ТСЦ МВС № 8049, м. Київ, вул. Павла Усенка, вул. Павла Усенка 8 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (61, 'ТСЦ МВС № 3542, м. Олександрія, пр-т. Будівельників, пр-т. Будівельників 38 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (66, 'ТСЦ МВС № 4642, м. Дрогобич, вул. Трускавецька, вул. Трускавецька 64 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (71, 'ТСЦ МВС № 4647, м. Новояворівськ, вул. Зелена, вул. Зелена 2 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (77, 'ТСЦ МВС № 4843, м. Нова Одеса, вул. Сеславинського, вул. Сеславинського 12 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (83, 'ТСЦ МВС № 5144, м. Ізмаїл, пр-т. Незалежності, пр-т. Незалежності 362 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (88, 'ТСЦ МВС № 5150, м. Чорноморськ, вул. Хантадзе, вул. Хантадзе 19 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (93, 'ТСЦ МВС № 5342, м. Кременчук, вул. Покровська, вул. Покровська 14', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (98, 'ТСЦ МВС № 5347, смт. Семенівка, вул. Шевченка, вул. Шевченка 43 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (104, 'ТСЦ МВС № 5941, м. Глухів, вул. Індустріальна, вул. Індустріальна 19 а', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (109, 'ТСЦ МВС № 5946, м. Суми, вул. Білопільський шлях, вул. Білопільський шлях 18/1', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (114, 'ТСЦ МВС № 6145, с. Угринь, вул. Об''їзна, вул. Об''їзна 1 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (119, 'ТСЦ МВС № 6345, м. Берестин, вул. Полтавська, вул. Полтавська 92 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (121, 'ТСЦ МВС № 6347, м. Чугуїв, вул. Гвардійська, вул. Гвардійська 20 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (129, 'ТСЦ МВС № 6843, м. Кам''янець-Подільський, пр-т. Грушевського, пр-т. Грушевського 45323 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (135, 'ТСЦ МВС № 7144, м. Корсунь-Шевченківський, вул. Василя Сергієнка, вул. Василя Сергієнка 4 а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (140, 'ТСЦ МВС № 7344, с. Глибока, вул. Героїв Небесної Сотні, вул. Героїв Небесної Сотні 88 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (145, 'ТСЦ МВС № 7444, м. Мена, вул. Чернігівський шлях, вул. Чернігівський шлях 85-В', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (151, 'ТСЦ МВС № 8046, м. Київ, вул. Столичне шосе, вул. Столичне шосе 104 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (63, 'ТСЦ МВС № 3544, м. Мала Виска, вул. Мічуріна, вул. Мічуріна 2 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (69, 'ТСЦ МВС № 4645 , м. Стрий, вул. Багряного, вул. Багряного 4 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (75, 'ТСЦ МВС № 4841 , м. Миколаїв, провулок. Транспортний, провулок. Транспортний 1а/1', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (80, 'ТСЦ МВС № 5141, м. Одеса, вул. Інглезі, вул. Інглезі 15 а', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (86, 'ТСЦ МВС № 5148, м. Березівка, вул. Героїв України, вул. Героїв України 27 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (90, 'ТСЦ МВС № 5152, с. Біляївський р-н., с. Усатове, вул. Ленінградське шосе, вул. Ленінградське шосе 27 а', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (96, 'ТСЦ МВС № 5345, м. Гадяч, вул. Героїв Майдану, вул. Героїв Майдану 75-В', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (101, 'ТСЦ МВС № 5642, м. Дубно, вул. Грушевського, вул. Грушевського 184 ', '2025-04-04 18:34:12.279000', '2025-04-04 18:34:12.279000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (106, 'ТСЦ МВС № 5943, м. Охтирка, вул. Київська, вул. Київська 164 в', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (110, 'ТСЦ МВС № 6141, с. Підгородне, вул. Стрийська, вул. Стрийська 5 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (115, 'ТСЦ МВС № 6341, м. Харків, вул. Шевченка, вул. Шевченка 26 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (120, 'ТСЦ МВС № 6346, м. Балаклія, пл. Тараса Шевченка, пл. Тараса Шевченка 11 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (125, 'ТСЦ МВС № 6541, м. Херсон, вул. Вишнева, вул. Вишнева 22 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (130, 'ТСЦ МВС № 6844, м. Старокостянтинів, вул. Чайковського, вул. Чайковського 1 а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (134, 'ТСЦ МВС № 7143, м. Звенигородка, вул. Богдана Хмельницького, вул. Богдана Хмельницького 15/1', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (139, 'ТСЦ МВС № 7343, м. Новоселиця, вул. Кремльова, вул. Кремльова 20 ', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (144, 'ТСЦ МВС № 7443, м. Ніжин, вул. С. Прощенка, вул. С. Прощенка 78 б', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (147, 'ТСЦ МВС № 8042, м. Київ, вул. Перемоги, вул. Перемоги 20', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (152, 'ТСЦ МВС № 8047, с. Софіївська Борщагівка, вул. Велика Кільцева, вул. Велика Кільцева 110 а', '2025-04-04 18:34:12.280000', '2025-04-04 18:34:12.280000');
INSERT INTO "apiDB"."Office" (id, address, "createdAt", "updatedAt") VALUES (155, 'ТСЦ МВС № 5942 (лише практичний іспит), м. Конотоп, Вирівська 19 А', '2025-04-07 13:27:57.000000', '2025-04-07 13:28:03.000000');

INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (17, 'Реєстраційні дії з транспортними засобами (Фізичні особи)', '2025-04-06 15:39:02.251000', '2025-04-06 15:39:02.251000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (60, 'Реєстраційні дії з транспортними засобами (Юридичні особи)', '2025-04-06 15:39:02.253000', '2025-04-06 15:39:02.253000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (46, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія А1', '2025-04-06 15:39:02.253000', '2025-04-06 15:39:02.253000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (47, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія А', '2025-04-06 15:39:02.254000', '2025-04-06 15:39:02.254000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (49, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія В (механічна КПП)', '2025-04-06 15:39:02.254000', '2025-04-06 15:39:02.254000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (50, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія В (автоматична КПП)', '2025-04-06 15:39:02.254000', '2025-04-06 15:39:02.254000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (51, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія С1', '2025-04-06 15:39:02.255000', '2025-04-06 15:39:02.255000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (52, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія С', '2025-04-06 15:39:02.256000', '2025-04-06 15:39:02.256000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (53, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія D1', '2025-04-06 15:39:02.257000', '2025-04-06 15:39:02.257000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (54, 'Практичний іспит на транспортному засобі Сервісного центру МВС, категорія D', '2025-04-06 15:39:02.257000', '2025-04-06 15:39:02.257000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (43, 'Практичний іспит на транспортному засобі навчального закладу, категорія В', '2025-04-06 15:39:02.257000', '2025-04-06 15:39:02.257000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (42, 'Практичний іспит на транспортному засобі навчального закладу, категорія А1, А, В1', '2025-04-06 15:39:02.257000', '2025-04-06 15:39:02.257000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (44, 'Практичний іспит на транспортному засобі навчального закладу, категорії С1, С, D1, D', '2025-04-06 15:39:02.258000', '2025-04-06 15:39:02.258000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (45, 'Практичний іспит на транспортному засобі навчального закладу, категорії ВЕ, С1Е, СЕ, D1E, DE', '2025-04-06 15:39:02.258000', '2025-04-06 15:39:02.258000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (7, 'Обмін посвідчення водія/міжнародне посвідчення водія ', '2025-04-06 15:39:02.258000', '2025-04-06 15:39:02.258000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (8, 'Теоретичний іспит ', '2025-04-06 15:39:02.258000', '2025-04-06 15:39:02.258000');
INSERT INTO "apiDB"."Question" (id, category, "createdAt", "updatedAt") VALUES (37, 'Експертне дослідження транспортного засобу', '2025-04-06 15:39:02.258000', '2025-04-06 15:39:02.258000');
