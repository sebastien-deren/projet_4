INSERT INTO User(`id_user`,`password`, `username`, `name`)
VALUES (1,'coucou', 'francis', 'franck'),
(2,'12345', 'jeanDup', 'jean'),
(3,'mdp', 'jenniferLawrence', 'JL'),
(4,'exemple','titi_le_livreur','etienne'),
(5,'root','franck_le_livreur','franck'),
(6,'root','jean_le_chef', 'jean'),
(7,'root','guillaume_le_chef','guillaume');

INSERT INTO Client(`id_client`,`bankinfo`)
VALUES (1,NULL),
(2,NULL);

INSERT INTO Deliverer(`id_deliverer`,`status`)
VALUES
(4,'libre'),
(5,'occupé');
INSERT INTO Chef(`id_chef`,`specialty`)
VALUES
(6,'plat français'),
(7,'dessert fusion');

INSERT INTO Address(`id_address`,`id_client`,`number`,`street`,`town`,`zipcode`)
VALUES
(1,1,12,'rue de la roquette','Paris','75003'),
(2,1,23,'boulevard saint germain','Paris','75006'),
(3,1,6,'rue du terne','auteil','92008'),
(4,2,25,'rue du petit manège','chatillon','92500'),
(5,3,13,'avenue des champs élizée','Paris','75007');

INSERT INTO DishOfTheDay(`id_dishOfTheDay`,`id_chef`,`name`,`type`,`day`)
VALUES
(1,6,'boeuf bourguignon','plat','12/12/2022'),
(2,6,'gratin dauphinois','plat','12/12/2022'),
(3,7,'tarte yuzu meringué','dessert','12/12/2022'),
(4,7,'paris-tokyo','dessert','12/12/2022');

INSERT INTO Command (`id_command`,`id_deliverer`,`id_address`,`commandDate`,`status`,`timeOfArrival`)
VALUES
(1,4,3,'12/12/2022','livré',NULL),
(2,5,4,'12/12/2022','en cours',4),
(3,5,5,'12/12/2022','livré',NULL);

INSERT INTO ASSOC_Command_Dish (`id_command`,`id_dish`,`number`)
VALUES
(1,1,3),
(1,2,1),
(1,3,4),
(2,1,1),
(2,4,1),
(3,2,3),
(3,3,1),
(3,4,2);