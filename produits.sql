CLEAR SCREEN

SET serveroutput ON
SET VERIFY OFF

ACCEPT lenom PROMPT "Entrer le nom du produit: "
ACCEPT laquantite PROMPT "Entrer la quantite du produit: "
ACCEPT leprix PROMPT "Entrer le prix du produit: "

BEGIN

        -- Insertion d'un produit dans la table produits
    INSERT INTO produits (numProd, nom, quantiteStock, prix)
    VALUES ('P' || seq_prod.nextval, '&lenom', '&laquantite', '&leprix');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Insertion reussie');

        --affichage de la liste livre mise à jour
    package_affichage.affichageListeProduits;

    EXCEPTION 
        WHEN dup_val_on_index THEN
        DBMS_OUTPUT.PUT_LINE('Ce numero de produit existe deja.'); 
    when others then
        DBMS_OUTPUT.PUT_LINE('Une erreur c''est produite');
  
END;
/

SET verify ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql