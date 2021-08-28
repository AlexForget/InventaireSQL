CLEAR SCREEN

SET SERVEROUTPUT ON
SET VERIFY OFF

-- Script qui sert à la suppression d'une produit et qui actionnerra les trigger

ACCEPT numProdDelete PROMPT "Entrer le numero de produit a supprimer : "

DECLARE 
    nbre NUMBER := 0;
    erreur_num_produit EXCEPTION;

begin

        -- Vérification si le numero de produit existe
    SELECT COUNT(numProd) INTO nbre
    FROM produits 
    WHERE UPPER(numProd) = UPPER('&numProdDelete');

    if nbre <= 0 THEN
        RAISE erreur_num_produit;
    end if;

        -- Si le numero de produit est valide le supprime de la table produit
    DELETE FROM produits WHERE UPPER(numProd) = UPPER('&numProdDelete');
    commit;
    DBMS_OUTPUT.PUT_LINE('Liste de la table archive.');
    package_affichage.affichageProdSuprime;

    EXCEPTION 
        WHEN erreur_num_produit THEN
            DBMS_OUTPUT.PUT_LINE('Ce numero de produit n''existe pas.'); 
            DBMS_OUTPUT.PUT_LINE('Voici la liste des numeros de produits.');
            package_affichage.afficherNumProduits;
end;
/

SET VERIFY ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql