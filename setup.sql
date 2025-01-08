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



INSERT INTO "apiDB"."Question" ("id")
VALUES ('56');
INSERT INTO "apiDB"."Question" ("id")
VALUES ('55');

UPDATE "apiDB"."Question" SET "category" = 'Практичний іспит на категорію В (транспортний засіб сервісного центру з механічною коробкою передач)' WHERE "id" = 55;
UPDATE "apiDB"."Question" SET "category" = 'Практичний іспит на категорію В (транспортний засіб автошколи з механічною коробкою передач)' WHERE "id" = 56;


INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (9, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'Луцький р-н, с. Струмівка, вул. Рівненська, 74');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (112, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'Чортківський район, с. Угринь, вул. Обїзна, 1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (118, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м.Старокостянтинів, вул. Чайковського,1А');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (46, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Біла Церква, вул. Сухоярська, 20');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (4, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Гайсин, вул. Південна, 67');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (50, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'с. Софіївська Борщагівка, вул, Толстого, 2');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (98, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Рівне, вул. Київська, 108Б');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (79, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'Одеська обл., м. Ізмаїл, просп. Незалежності, 362');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (72, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Первомайськ, вул. Вознесенська, 73Б');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (61, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Львів, вул. Данила Апостола, 11');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (74, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Вознесенськ, вул. Молодогвардійська, 45');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (151, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.758000', 'м. Вінниця, вул. Ботанічна, 24');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (110, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Кременець, вул. Шевченка 67');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (131, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Чернівці, вул. Руська, 248М');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (142, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Київ, вул.Мрії, 19');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (75, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Новий Буг, площа Свободи, 1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (47, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Бровари, вул. Броварської сотні, 4А');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (34, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Запоріжжя, вул. Олександрівська, 84');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (135, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'смт. Кельменці, вул. О. Паламаря, 9В');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (17, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Покров, вул. Уральська, 1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (43, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'м. Коломия , вул. Симоненка, 2');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (55, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'м. Олександрія, просп. Будівельників, 38');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (66, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'м. Шептицький, Червоноградського р-ну, вул. Корольова, 14А');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (14, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Дніпро, пр. Праці, 16');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (84, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'Одеська обл., м. Подільськ, вул. Соборна, 202 Б');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (78, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'Одеська обл., м. Бiлгород-Днiстровський, вул. Гагаріна, 4');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (126, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Черкаси, вул. Лесі Українки, 21');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (104, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Охтирка, вул. Київська, 164В');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (117, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Кам''янець - Подільський, пр.Грушевського 1/2');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (28, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'Мукачівський р-н, с. Клячаново, вул. Автомобілістів, 28');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (24, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'м. Коростень, вул. Сергія Кемського, 3');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (25, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'м.Звягель, вул. Відродження, 2');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (19, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Павлоград, вул. Дніпровська, 334а');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (54, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Кропивницький, просп. Інженерів, 9/92');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (162, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.757000', 'м. Херсон, вул. Вишнева, 22');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (92, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Лубни, пр. Володимирівський, 178 Б');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (10, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Ковель, вул. Володимирська, 133');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (115, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Хмельницький, вул. Західно- Окружна 11/1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (154, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.757000', 'м. Лозова, Мікрорайон 5, буд.3');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (100, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Сарни, вул. Гагаріна, 100');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (21, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.757000', 'м. Дніпро, пр. Слобожанський, 31Д');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (176, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.757000', 'м. Кременчук, вул. Покровська, 14, (приміщення ЦНАП, вхід з лівої сторони)');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (52, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Переяслав, вул. Ново-Київське шосе, 46');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (137, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Прилуки, вул. Індустріальна, 6');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (180, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.758000', 'м. Конотоп, вул. Вирівська, буд. 19А');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (20, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Кривий Ріг, вул. Стрельникова, 15');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (148, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Київ, вул. Павла Усенка, 8');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (108, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'Тернопільський район, с. Підгородне, вул. Стрийська, 5');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (136, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Чернігів, вул. Шевченко, 162А');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (90, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'Полтавський р-н., с. Розсошенці, вул. Кременчуцька, 2В');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (89, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м.Одеса, вул. Аєропортівська, 27/1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (71, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Миколаїв, пров. Транспортний, 1а/1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (64, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Самбір, вул. Східна, 216');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (22, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'Житомирський район, с. Довжик, вул. Богунська, 1А');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (65, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.758000', 'м. Стрий, вул. Івана Багряного, 4');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (167, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.759000', 'Донецька обл., м. Добропілля, вул. Банкова, 45');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (163, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.759000', 'м. Харків, вул. Шевченка, 26');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (177, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.759000', 'м. Львів, вул. Богданівська, 44');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (41, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Івано-Франківськ, вул. Є Коновальця 229/у');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (35, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Запоріжжя, вул. Козака Бабури, 9а');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (30, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Хуст, Хустського району, вулиця Окружна, 34');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (127, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'Уманський р-н, сільська Рада Родниківська, автодорога Київ-Одеса 203 км + 800м');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (166, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.759000', 'Донецька обл., м. Краматорськ, вул. Героїв небесної сотні, буд. 5');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (27, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.759000', 'м. Ужгород,вул. Кошового, 4');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (182, '2025-01-01 20:19:38.125050', '2025-01-06 16:14:46.755000', 'м. Київ, вул. Перемоги, 20');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (107, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'м.Суми, вул. Білопільський шлях, 18/1');
INSERT INTO "apiDB"."Office" (id, "createdAt", "updatedAt", address) VALUES (120, '2024-12-23 20:17:25.591024', '2025-01-06 16:14:46.756000', 'Станція метро "Київська". При перебуванні на станції Вам необхідно дотримуватись правил користування Харківським метрополітеном');

