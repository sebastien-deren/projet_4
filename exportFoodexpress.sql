--
-- Fichier généré par SQLiteStudio v3.4.1 sur mar. déc. 20 08:37:44 2022
--
-- Encodage texte utilisé : UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table : Address
CREATE TABLE IF NOT EXISTS Address(
    `id_address` INTEGER,
    `id_client` INTEGER,
    `number` INTEGER,
    `modNumber` TEXT,
    `street` TEXT,
    `town` TEXT,
    `zipCode` TEXt,
    `longitude` FLOAT,
    `lattitude` FLOAT,
    PRIMARY KEY (`id_address`),
    /*we should have like 5 or 6 primary key, so we create an artificial primary key
    canditates key are :(id_user,number,modNumber,street,town,zipcode)
    */
    CONSTRAINT `FK_id_client` FOREIGN KEY (`id_client`) REFERENCES `Client`(`id_client`)
);
INSERT INTO Address (id_address, id_client, number, modNumber, street, town, zipCode, longitude, lattitude) VALUES (1, 1, 12, NULL, 'rue de la roquette', 'Paris', '75003', NULL, NULL);
INSERT INTO Address (id_address, id_client, number, modNumber, street, town, zipCode, longitude, lattitude) VALUES (2, 1, 23, NULL, 'boulevard saint germain', 'Paris', '75006', NULL, NULL);
INSERT INTO Address (id_address, id_client, number, modNumber, street, town, zipCode, longitude, lattitude) VALUES (3, 1, 6, NULL, 'rue du terne', 'auteil', '92008', NULL, NULL);
INSERT INTO Address (id_address, id_client, number, modNumber, street, town, zipCode, longitude, lattitude) VALUES (4, 2, 25, NULL, 'rue du petit manège', 'chatillon', '92500', NULL, NULL);
INSERT INTO Address (id_address, id_client, number, modNumber, street, town, zipCode, longitude, lattitude) VALUES (5, 3, 13, NULL, 'avenue des champs élizée', 'Paris', '75007', NULL, NULL);

-- Table : ASSOC_Command_Dish
CREATE TABLE IF NOT EXISTS ASSOC_Command_Dish(
    `id_dish` INTEGER,
    `id_command` INTEGER,
    `number` INTEGER,
    PRIMARY KEY (`id_dish`, `id_command`),
    CONSTRAINT `FK_PK_id_dish` FOREIGN KEY (`id_dish`) REFERENCES `DishOfTheDay`(`id_dishOfTheDay`),
    CONSTRAINT `FK_PK_id_command` FOREIGN KEY (`id_command`) REFERENCES `Command`(`id_command`)
);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (1, 1, 3);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (2, 1, 1);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (3, 1, 4);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (1, 2, 1);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (4, 2, 1);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (2, 3, 3);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (3, 3, 1);
INSERT INTO ASSOC_Command_Dish (id_dish, id_command, number) VALUES (4, 3, 2);

-- Table : Chef
CREATE TABLE IF NOT EXISTS Chef(
    `id_chef` INTEGER,
    `specialty` TEXT,
    PRIMARY KEY (`id_chef`),
    CONSTRAINT `FK_id_user` FOREIGN KEY (`id_chef`) REFERENCES `User` (`id_user`)
);
INSERT INTO Chef (id_chef, specialty) VALUES (6, 'plat français');
INSERT INTO Chef (id_chef, specialty) VALUES (7, 'dessert fusion');

-- Table : Client
CREATE TABLE IF NOT EXISTS Client(
    `id_client` INTEGER,
    `bankinfo` INTEGER,
    PRIMARY KEY (`id_client`),
    CONSTRAINT `FK_id_user`  FOREIGN KEY (`id_client`) REFERENCES `User`(`id_user`)
);
INSERT INTO Client (id_client, bankinfo) VALUES (1, NULL);
INSERT INTO Client (id_client, bankinfo) VALUES (2, NULL);
INSERT INTO Client (id_client, bankinfo) VALUES (3, NULL);

-- Table : Command
CREATE TABLE IF NOT EXISTS Command(
    `id_command` INTEGER,
    `id_deliverer` INTEGER,
    `id_address` INTEGER,
    `commandDate` DATE,
    `status` TEXT,
    `timeOfArrival` HOUR,
    PRIMARY KEY (`id_command`),
    /* Our natural primary key here is id_deliverer,id_address,commandDate
    (with the date in YYYY:MM:DD:HH:MM:SS) but for clarity we will take an artificial key*/
    CONSTRAINT `FK_id_deliverer` FOREIGN KEY (`id_deliverer`) REFERENCES `Deliverer` (`id_deliverer`),
    CONSTRAINT `FK_id_address` FOREIGN KEY (`id_address`) REFERENCES `Address`(`id_address`)
);
INSERT INTO Command (id_command, id_deliverer, id_address, commandDate, status, timeOfArrival) VALUES (1, 4, 3, '12/12/2022', 'livré', NULL);
INSERT INTO Command (id_command, id_deliverer, id_address, commandDate, status, timeOfArrival) VALUES (2, 5, 4, '12/12/2022', 'en cours', 4);
INSERT INTO Command (id_command, id_deliverer, id_address, commandDate, status, timeOfArrival) VALUES (3, 5, 5, '12/12/2022', 'livré', NULL);

-- Table : Deliverer
CREATE TABLE IF NOT EXISTS Deliverer(
    `id_deliverer` INTEGER,
    `status` TEXT,
    `longitude` FLOAT,
    `lattitude` FLOAT,
    PRIMARY KEY (`id_deliverer`),
    CONSTRAINT `FK_id_user` FOREIGN KEY (`id_deliverer`) REFERENCES `User` (`id_user`)
);
INSERT INTO Deliverer (id_deliverer, status, longitude, lattitude) VALUES (4, 'libre', NULL, NULL);
INSERT INTO Deliverer (id_deliverer, status, longitude, lattitude) VALUES (5, 'occupé', NULL, NULL);

-- Table : DishOfTheDay
CREATE TABLE IF NOT EXISTS DishOfTheDay(
    `id_dishOfTheDay` INTEGER,
    `id_chef` INTEGER,
    `name` TEXT,
    `type` TEXT, -- salted dish, or dessert we might add other dishes later
    `day` DATE, --here we will need a format Of YYYY:MM:DD the precision will be sufficient
    `price` INTEGER,
    PRIMARY KEY (`id_dishOfTheDay`),
    /* here our natural primary key could have been (name,day) but for clarity we will use an artificial key*/
    CONSTRAINT `FK_id_chef` FOREIGN KEY (`id_chef`) REFERENCES `Chef`(`id_chef`)
);
INSERT INTO DishOfTheDay (id_dishOfTheDay, id_chef, name, type, day, price) VALUES (1, 6, 'boeuf bourguignon', 'plat', '12/12/2022', NULL);
INSERT INTO DishOfTheDay (id_dishOfTheDay, id_chef, name, type, day, price) VALUES (2, 6, 'gratin dauphinois', 'plat', '12/12/2022', NULL);
INSERT INTO DishOfTheDay (id_dishOfTheDay, id_chef, name, type, day, price) VALUES (3, 7, 'tarte yuzu meringué', 'dessert', '12/12/2022', NULL);
INSERT INTO DishOfTheDay (id_dishOfTheDay, id_chef, name, type, day, price) VALUES (4, 7, 'paris-tokyo', 'dessert', '12/12/2022', NULL);

-- Table : User
CREATE TABLE IF NOT EXISTS User (
    `id_user` INTEGER NOT NULL,
    `password` TEXT,
    `username` TEXT,
    `name` TEXT,
    PRIMARY KEY (`id_user`)
);
INSERT INTO User (id_user, password, username, name) VALUES (1, 'coucou', 'francis', 'francis');
INSERT INTO User (id_user, password, username, name) VALUES (2, '12345', 'jeanDup', 'jean');
INSERT INTO User (id_user, password, username, name) VALUES (3, 'mdp', 'jenniferLawrence', 'JL');
INSERT INTO User (id_user, password, username, name) VALUES (4, 'exemple', 'titi_le_livreur', 'etienne');
INSERT INTO User (id_user, password, username, name) VALUES (5, 'root', 'franck_le_livreur', 'franck');
INSERT INTO User (id_user, password, username, name) VALUES (6, 'root', 'jean_le_chef', 'jean');
INSERT INTO User (id_user, password, username, name) VALUES (7, 'root', 'guillaume_le_chef', 'guillaume');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
