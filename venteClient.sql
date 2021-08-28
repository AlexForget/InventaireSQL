CLEAR SCREEN

SET serveroutput ON
SET VERIFY OFF

ACCEPT lenumclient PROMPT "Entrer le numero du client: "
ACCEPT lenumprod PROMPT "Entrer le numero du produit: "
ACCEPT ladate PROMPT "Entrer la date de la vente: "
ACCEPT laquantite PROMPT "Entrer la quantite vendu du produit: "
ACCEPT leprix PROMPT "Entrer le prix de vente du produit: "

DECLARE
    erreur_integrite EXCEPTION;
    PRAGMA exception_INIT(erreur_integrite,-2291);
    erreur_date EXCEPTION;
    PRAGMA exception_INIT(erreur_date,-1861);
    erreur_quantite EXCEPTION;
    erreur_prix EXCEPTION;
    ancienne_qte NUMBER(10);
    nouvelle_qte NUMBER(10);
    prix_achat NUMBER(10,2);
    prix_vente NUMBER(10,2) := '&leprix';

BEGIN

        -- Recherche de la quantite restante de l'article a vendu
    SELECT quantiteStock INTO ancienne_qte
    FROM produits
    WHERE UPPER(numProd) = UPPER('&lenumprod');
    
        -- Verifie si il y a assez du produit en stock. 
        -- Si non, arrete l'exécution du script avec une erreur
    IF ancienne_qte < '&laquantite' THEN
        RAISE erreur_quantite;
    END IF;
    
        -- Recherche le prix du produit
    SELECT prix INTO prix_achat
    FROM produits
    WHERE UPPER(numProd) = UPPER('&lenumprod');

        -- Verifie si le prix de vente est supérieur ou égal au prix du produit. 
        -- Si non, arrete l'exécution du script avec une erreur
    IF prix_achat > prix_vente THEN
        RAISE erreur_prix;
    END IF;

        -- Si l'utilisateur n'entre pas de prix va lui assigner le prix 
        -- de la liste produits
    IF prix_vente is NULL THEN
        prix_vente := prix_achat ;
    END IF;

        -- Validation de la date
    IF regexp_like('&ladate','^(\d{2}-){2}\d{2}$') = FALSE then
        RAISE erreur_date;
    END IF;

        -- Si tous est bon fait l'insertion dans la table
    INSERT INTO venteClients (codeVente, numClient, numProd, dateVente, quantiteVendue, prixVente)
    VALUES (seq_codevente.nextval, UPPER('&lenumclient'), upper('&lenumprod'), '&ladate', '&laquantite', prix_vente);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Insertion reussie');

        -- Mise a jour de la quantite du produit dans la table produits
    nouvelle_qte := ancienne_qte - '&laquantite';
    UPDATE produits
    SET quantiteStock = nouvelle_qte
    WHERE numProd = UPPER('&lenumprod');


        --affichage de la liste des ventes clients
    DBMS_OUTPUT.PUT_LINE('Liste des ventes clients mise a jour');
    package_affichage.affichageListeVentes;


    EXCEPTION 
        WHEN dup_val_on_index THEN
            DBMS_OUTPUT.PUT_LINE('Ce code de vente existe deja.'); 
        WHEN erreur_integrite THEN
            DBMS_OUTPUT.PUT_LINE('# de client ou de produit non valide');
            package_affichage.afficherNumClients;
            package_affichage.afficherNumProduits;
        WHEN erreur_date THEN
            DBMS_OUTPUT.PUT_LINE('Le format de la date n''est non valide.'); 
            DBMS_OUTPUT.PUT_LINE('Format attendu : ##-##-##.');
        WHEN erreur_quantite THEN
            DBMS_OUTPUT.PUT_LINE('Quantite en stock insufisante. Voici la liste des produits.');
            package_affichage.affichageListeProduits;
        WHEN erreur_prix THEN
            DBMS_OUTPUT.PUT_LINE('Prix de vente inferieur au prix du produit. Voici la liste des produits.');
            package_affichage.affichageListeProduits;
        WHEN others THEN
            DBMS_OUTPUT.PUT_LINE('Une erreur c''est produite');
  
END;
/

SET verify ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql