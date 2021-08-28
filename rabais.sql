CLEAR SCREEN

SET serveroutput ON
SET VERIFY OFF

ACCEPT lenumclient PROMPT "Choisir le numero de client : "
ACCEPT ladate PROMPT "Choisir la date : "

DECLARE

    CURSOR Cur_rabais IS 
    SELECT codeVente, numClient, numProd, dateVente, quantiteVendue, prixVente FROM venteClients 
    WHERE numClient = UPPER('&lenumclient') 
    AND dateVente = '&ladate'
    FOR UPDATE OF prixVente;
    Le_curseur_rabais Cur_rabais%ROWTYPE;

    taux NUMBER(4,2) := 0;
    sous_total NUMBER(10,2) := 0;
    taxes NUMBER(10,2) := 0;
    total NUMBER(10,2) := 0;

BEGIN

    --2. Ouverture du curseur
    OPEN Cur_rabais;
    FETCH Cur_rabais INTO Le_curseur_rabais;
    
    -- Validation si le numero de clients existe
    IF Cur_rabais%ROWCOUNT <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Donnees invalide. Voici la liste des ventes clients.');
        package_affichage.affichageListeVentes;
    ELSE  
    -- Si le numero est valide, cette boucle sert à calculer le rabais
        WHILE Cur_rabais%FOUND LOOP
            CASE 
                WHEN Le_curseur_rabais.prixVente * Le_curseur_rabais.quantiteVendue > 5000 THEN 
                    taux := 0.85;
                WHEN Le_curseur_rabais.prixVente * Le_curseur_rabais.quantiteVendue > 1000 THEN 
                    taux := 0.90;
                ELSE 
                    taux := 0.95;
            END CASE;

            sous_total := sous_total + Le_curseur_rabais.prixVente * taux;

            -- Ajuste les pris selon le rabais
            UPDATE venteClients 
            SET prixVente = Le_curseur_rabais.prixVente * taux
            WHERE CURRENT OF Cur_rabais;
            FETCH Cur_rabais INTO Le_curseur_rabais;
        END LOOP;
    END IF; 

    COMMIT;

    taxes := package_taxe.calculTaxes(sous_total);
    total := sous_total + taxes;

    DBMS_OUTPUT.PUT_LINE('Affichage de la liste des ventes mise a jour');
    package_affichage.affichageListeVentes;

    CLOSE Cur_rabais;
END;
/

SET verify ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql