SELECT User.name AS 'nom du client' FROM User JOIN Client ON User.id_user =Client.id_client; 
SELECT User.name AS 'nom du chef', Chef.specialty AS 'spécialité' FROM User JOIN Chef ON User.id_user =Chef.id_chef;
SELECT User.name AS 'nom du livreur',Deliverer.status FROM User JOIN Deliverer ON User.id_user = Deliverer.id_deliverer;


SELECT 
    U.name,
    C.specialty,
    D.name,
    D.type
 
FROM
    DishOfTheDay AS D,
    User AS U,
    Chef AS C
WHERE 
    D.id_chef=C.id_chef
AND
    C.id_chef=U.id_user;


SELECT
    U.name,
    GroupAddress.addresse AS `nombre d'adresse`
FROM
    User AS U,
    (SELECT 
        count(*) addresse,
        Cl.id_client
    FROM 
        Client AS Cl,
        Address AS A
    WHERE 
         A.id_client = Cl.id_client
    GROUP BY Cl.id_client) AS GroupAddress
    
WHERE GroupAddress.id_client=U.id_user;





/* Montre la commande par qui elle a été livré pour qui et à quelle adresse*/
SELECT 
    C.id_command,
    JOIN_deliverer.name AS `nom du livreur`,
    JOIN_client.name AS `nom du client`,
    JOIN_client.number,
    JOIN_client.street,
    JOIN_client.town,
    C.status,
    C.timeOfArrival
FROM 
    Command AS C,
    (
    SELECT
        U.name name,
        A.id_address id_address,
        A.number,
        A.street,
        A.town
    FROM
    Address as A,
    User as U
    WHERE
        U.id_user = A.id_client
    )  JOIN_client,
    (
    SELECT
        U.name name,
        D.id_deliverer id_deliverer
    FROM
        User as U,
        Deliverer as D
    WHERE
        D.id_deliverer=U.id_user
    ) JOIN_deliverer
WHERE
    C.id_address = JOIN_client.id_address
AND 
    JOIN_deliverer.id_deliverer = C.id_deliverer
ORDER BY C.id_command;



/*plat présent dans la commande  avec type et nombre*/
SELECT 
    C.id_command,
    D.name AS 'nom de plat',
    D.type,C.commandDate AS 'Date de Commande',
    Assoc.number AS 'nombre de plat commandé'

FROM 
    DishOfTheDay AS D,
    Command AS C,
    ASSOC_Command_Dish AS Assoc

WHERE
    D.id_dishOfTheDay = Assoc.id_dish 
AND 
    C.id_command = Assoc.id_command 
AND 
    D.day = C.commandDate
ORDER BY C.id_command;



/*pareil qu'avant avec le nom du client*/

SELECT 
    C.id_command,
    JOIN_client.name AS `nom du client`,
    D.name AS 'nom de plat',
    D.type,C.commandDate AS 'Date de Commande',
    Assoc.number AS 'nombre de plat commandé'
      
FROM 
    DishOfTheDay AS D,
    Command AS C,
    ASSOC_Command_Dish AS Assoc,
    (
    SELECT
        U.name name,
        A.id_address id_address
    FROM
    Address as A,
    User as U
    WHERE
        U.id_user = A.id_client
    )  JOIN_client

WHERE
    D.id_dishOfTheDay = Assoc.id_dish 
AND 
    C.id_command = Assoc.id_command 
AND 
    D.day = C.commandDate
AND
    C.id_address = JOIN_client.id_address
ORDER BY C.id_command;






/* this one is a monstruosity BUT it work and show all the dish in all commands with their number,
the name of the deliverer, the name of the chef and the name of the client.
I could easily add the adress but maybe that's enough
*/
SELECT 
    C.id_command AS `numéro de commande`,
    D.name AS 'nom de plat',
    D.type,C.commandDate AS 'Date de Commande',
    Assoc.number AS `nombre de plat commandé`,
    JOIN_chef.name AS `nom du chef`,
    JOIN_deliverer.name AS `nom du livreur`,
    JOIN_client.name AS `nom du client`  
FROM 
    DishOfTheDay AS D,
    Command AS C,
    ASSOC_Command_Dish AS Assoc,
    (
    SELECT
        U.name name,
        A.id_address id_address
    FROM
    Address as A,
    User as U
    WHERE
        U.id_user = A.id_client
    )  JOIN_client,
    (
    SELECT
        U.name name,
        D.id_deliverer id_deliverer
    FROM
        User as U,
        Deliverer as D
    WHERE
        D.id_deliverer=U.id_user
    ) JOIN_deliverer,
    (
    SELECT
        U.name name,
        C.id_chef id_chef
    FROM
        User as U,
        Chef as C
    WHERE
        C.id_chef=U.id_user
    ) JOIN_chef
WHERE
    D.id_dishOfTheDay = Assoc.id_dish 
AND 
    C.id_command = Assoc.id_command 
AND 
    D.day = C.commandDate
AND
    C.id_address = JOIN_client.id_address
AND 
    JOIN_deliverer.id_deliverer = C.id_deliverer
AND 
    JOIN_chef.id_chef = D.id_chef
ORDER BY C.id_command;



/*FINAL FORM WITH THE ADRESS*/
SELECT 
    C.id_command,
    C.commandDate AS 'Date de Commande',
    JOIN_client.name AS `nom du client`,
    D.name AS 'nom de plat', 
    Assoc.number AS `nombre de plat commandé`,
    JOIN_chef.name AS `nom du chef`,
    D.type AS `type de plat`,
    JOIN_deliverer.name AS `nom du livreur`,
    JOIN_client.number AS `numéro de rue`,
    JOIN_client.street AS `rue`,
    JOIN_client.town  AS `Ville`
    
FROM 
    DishOfTheDay AS D,
    Command AS C,
    ASSOC_Command_Dish AS Assoc,
    (
    SELECT
        U.name name,
        A.id_address id_address,
        A.number,
        A.street,
        A.town
    FROM
    Address as A,
    User as U
    WHERE
        U.id_user = A.id_client
    )  JOIN_client,
    (
    SELECT
        U.name name,
        D.id_deliverer id_deliverer
    FROM
        User as U,
        Deliverer as D
    WHERE
        D.id_deliverer=U.id_user
    ) JOIN_deliverer,
    (
    SELECT
        U.name name,
        C.id_chef id_chef
    FROM
        User as U,
        Chef as C
    WHERE
        C.id_chef=U.id_user
    ) JOIN_chef
WHERE
    D.id_dishOfTheDay = Assoc.id_dish 
AND 
    C.id_command = Assoc.id_command 
AND 
    D.day = C.commandDate
AND
    C.id_address = JOIN_client.id_address
AND 
    JOIN_deliverer.id_deliverer = C.id_deliverer
AND 
    JOIN_chef.id_chef = D.id_chef
ORDER BY C.id_command;
