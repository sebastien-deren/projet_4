START TRANSACTION;
CREATE TABLE User (
    `id_user` INTEGER NOT NULL,
    `password` TEXT,
    `username` TEXT,
    `name` TEXT,
    PRIMARY KEY (`id_user`)
);

CREATE TABLE Client(
    `id_client` INTEGER NOT NULL,
    `bankinfo` INTEGER,
    PRIMARY KEY (`id_client`),
    CONSTRAINT `FK_id_user_client`  FOREIGN KEY (`id_client`) REFERENCES `User`(`id_user`)
);

CREATE TABLE Deliverer(
    `id_deliverer` INTEGER NOT NULL,
    `status` TEXT,
    `longitude` FLOAT,
    `lattitude` FLOAT,
    PRIMARY KEY (`id_deliverer`),
    CONSTRAINT `FK_id_user_deliverer` FOREIGN KEY (`id_deliverer`) REFERENCES `User` (`id_user`)
);

CREATE TABLE Chef(
    `id_chef` INTEGER NOT NULL,
    `specialty` TEXT,
    PRIMARY KEY (`id_chef`),
    CONSTRAINT `FK_id_user_chef` FOREIGN KEY (`id_chef`) REFERENCES `User` (`id_user`)
);

CREATE TABLE Address(
    `id_address` INTEGER NOT NULL,
    `id_client` INTEGER NOT NULL,
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
    CONSTRAINT `FK_id_client_adress` FOREIGN KEY (`id_client`) REFERENCES `Client`(`id_client`)
);
CREATE TABLE Command(
    `id_command` INTEGER NOT NULL,
    `id_deliverer` INTEGER NOT NULL,
    `id_address` INTEGER NOT NULL,
    `commandDate` DATE,
    `status` TEXT,
    `timeOfArrival` TEXT,
    PRIMARY KEY (`id_command`),
    /* Our natural primary key here is id_deliverer,id_address,commandDate
    (with the date in YYYY:MM:DD:HH:MM:SS) but for clarity we will take an artificial key*/
    CONSTRAINT `FK_id_deliverer_command` FOREIGN KEY (`id_deliverer`) REFERENCES `Deliverer` (`id_deliverer`),
    CONSTRAINT `FK_id_address_command` FOREIGN KEY (`id_address`) REFERENCES `Address`(`id_address`)
);
CREATE TABLE DishOfTheDay(
    `id_dishOfTheDay` INTEGER NOT NULL,
    `id_chef` INTEGER NOT NULL,
    `name` TEXT,
    `type` TEXT,
    `day` DATE, 
    `price` INTEGER,
    PRIMARY KEY (`id_dishOfTheDay`),
    /* here our natural primary key could have been (name,day) but for clarity we will use an artificial key*/
    CONSTRAINT `FK_id_chef_dishoftheday` FOREIGN KEY (`id_chef`) REFERENCES `Chef`(`id_chef`)
);

CREATE TABLE ASSOC_Command_Dish(
    `id_dish` INTEGER NOT NULL,
    `id_command` INTEGER NOT NULL,
    `number` INTEGER,
    PRIMARY KEY (`id_dish`, `id_command`),
    CONSTRAINT `FK_PK_id_dish` FOREIGN KEY (`id_dish`) REFERENCES `DishOfTheDay`(`id_dishOfTheDay`),
    CONSTRAINT `FK_PK_id_command` FOREIGN KEY (`id_command`) REFERENCES `Command`(`id_command`)
);
COMMIT;