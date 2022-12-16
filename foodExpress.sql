CREATE TABLE User (
    `id_user` INTEGER,
    `password` TEXT,
    `username` TEXT,
    `name` TEXT
    PRIMARY KEY (`id_user`)
)

CREATE TABLE Client(
    `id_user` INTEGER,
    `bankinfo` INTEGER,
    PRIMARY KEY (`id_user`),
    CONSTRAINT `FK_id_user`  FOREIGN KEY (`id_user`) REFERENCES `User` (`id_user`)
)

CREATE TABLE Deliverer(
    `id_user` INTEGER,
    `status` TEXT,
    `longitude` FLOAT,
    `lattitude` FLOAT,
    PRIMARY KEY (`id_user`),
    CONSTRAINT `FK_id_user` FOREIGN KEY (`id_user`) REFERENCES `User` (`id_user`)
)

CREATE TABLE Chef(
    `id_user` INTEGER,
    `specialty` TEXT,
    PRIMARY KEY (`id_user`),
    CONSTRAINT `FK_id_user` FOREIGN KEY (`id_user`) REFERENCES `User` (`id_user`)
)

CREATE TABLE Address(
    `id_address` INTEGER,
    `id_user` INTEGER,
    `number` INTEGER,
    `modNumber` TEXT,
    `street` TEXT,
    `town` TEXT,
    `zipCode` TEXt,
    `longitude` FLOAT,
    `lattitude` FLOAT,
    PRIMARY KEY (`id_address`,`id_user`),
    /*we should have like 5 or 6 primary key, so we create an artificial primary key
    canditates key are :(id_user,number,modNumber,street,town,zipcode)
    */
    CONSTRAINT `FK_id_user` FOREIGN KEY (`id_user`) REFERENCES`User` (`id_user`)
)