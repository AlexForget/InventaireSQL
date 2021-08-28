CLEAR SCREEN

SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT ancientNumClient PROMPT "Entrer le numero de client a mettre a jour: "
ACCEPT nouveauNumClient PROMPT "Entrer le nouveau numero de client: "

DECLARE 
    nbre NUMBER := 0;
    erreur_num_client EXCEPTION;

begin

        -- Valide si le numero de client existe
    SELECT COUNT(numClient) INTO nbre
    FROM clients 
    WHERE UPPER(numClient) = UPPER('&ancientNumClient');

    if nbre <= 0 THEN
        RAISE erreur_num_client;
    end if;

        -- Met à jour le numero de client si il est valide
    update clients set numClient = UPPER('&nouveauNumClient') where numClient = UPPER('&ancientNumClient');
    commit;
    package_affichage.affichageListeVentes;

    EXCEPTION 
        WHEN erreur_num_client THEN
            DBMS_OUTPUT.PUT_LINE('Ce numero de client n''existe pas.'); 
            DBMS_OUTPUT.PUT_LINE('Voici la liste des numeros clients.');
            package_affichage.afficherNumClients;
end;
/

SET VERIFY ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql