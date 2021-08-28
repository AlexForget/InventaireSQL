CLEAR SCREEN

SET serveroutput ON
SET VERIFY OFF

ACCEPT lenumclient PROMPT "Choisir le numero de client : "
ACCEPT ladate PROMPT "Choisir la date : "

CLEAR SCREEN

DECLARE
    CURSOR cur_client IS
    SELECT vc.numClient, vc.dateVente, vc.numProd, vc.prixVente, vc.quantiteVendue, cl.nomClient, cl.prenomClient
    FROM venteClients vc INNER JOIN clients cl
    ON vc.numClient = cl.numClient
    WHERE vc.numClient = UPPER('&lenumclient')
    AND vc.dateVente = '&ladate';
    mon_curseur_client cur_client%ROWTYPE;

    erreur_num_client EXCEPTION;
    sous_total NUMBER(10,2);
    total_avant_txs NUMBER(10,2) := 0;
    taxes NUMBER(10,2);
    total NUMBER(10,2);
    var_num_client VARCHAR2(10);
    var_nom_client VARCHAR2(10);
    var_prenom_client VARCHAR2(10);

BEGIN

    OPEN cur_client;
    FETCH cur_client INTO mon_curseur_client;

        -- Vérifi si le numero de client existe
    if cur_client%ROWCOUNT <= 0 then
        RAISE erreur_num_client;
    end if;

        -- Permet d'assigner le numero de client a une variable
    WHILE cur_client%FOUND LOOP

        var_num_client := mon_curseur_client.numClient;
        var_nom_client := mon_curseur_client.nomClient;
        var_prenom_client := mon_curseur_client.prenomClient;

        FETCH cur_client INTO mon_curseur_client;

    END LOOP;

    CLOSE cur_client;

    OPEN cur_client;
    FETCH cur_client INTO mon_curseur_client;

        -- Affichage de l'en tête de la facture

    DBMS_OUTPUT.PUT_LINE('Numero de client : ' || var_num_client);
    DBMS_OUTPUT.PUT_LINE('Nom du client : ' || var_nom_client);
    DBMS_OUTPUT.PUT_LINE('Prenom du client : ' || var_prenom_client);

    DBMS_OUTPUT.PUT_LINE('---------      ----    --------  ----------');
    DBMS_OUTPUT.PUT_LINE(RPAD('# Produit',15) || RPAD('Prix',8) || RPAD('Quantite',10) || RPAD('Sous-total',10));
    DBMS_OUTPUT.PUT_LINE('---------      ----    --------  ----------');

        -- Boucle pour afficher les détails de la facture
    WHILE cur_client%FOUND LOOP

        sous_total := package_taxe.coutVente(mon_curseur_client.prixVente, mon_curseur_client.quantiteVendue);
        total_avant_txs := total_avant_txs + sous_total;

        DBMS_OUTPUT.PUT_LINE(RPAD(mon_curseur_client.numProd,15) ||
        ' ' || RPAD(mon_curseur_client.prixVente,8) ||
        ' ' || RPAD(mon_curseur_client.quantiteVendue,10) ||
        ' ' || sous_total || '$');

        FETCH cur_client INTO mon_curseur_client;

    END LOOP;

    CLOSE cur_client;

        -- Calcul et affichage des totaus de la facture
    taxes := package_taxe.calculTaxes(total_avant_txs);
    total := total_avant_txs + taxes;

    DBMS_OUTPUT.PUT_LINE('-                                  --------');
    DBMS_OUTPUT.PUT_LINE('-                      Sous-total : ' || total_avant_txs || '$');
    DBMS_OUTPUT.PUT_LINE('-                     Taxes (15%) : ' || taxes || '$');
    DBMS_OUTPUT.PUT_LINE('-                                  --------');
    DBMS_OUTPUT.PUT_LINE('-                           Total : ' || total || '$');

    EXCEPTION 
        WHEN erreur_num_client THEN
            DBMS_OUTPUT.PUT_LINE('Ce numero de client n''existe pas ou la date est invalide.'); 
            DBMS_OUTPUT.PUT_LINE('Voici la liste des ventes clients.');
            package_affichage.affichageListeVentes;
        when others then
            DBMS_OUTPUT.PUT_LINE('Une erreur c''est produite'); 

END;
/

SET verify ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql