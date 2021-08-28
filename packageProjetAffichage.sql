SET serveroutput ON
SET VERIFY OFF

-- Package pour les affichage des tables ou portion des tables

CREATE OR REPLACE PACKAGE package_affichage AS 

PROCEDURE affichageListeClients;

PROCEDURE affichageListeProduits;

PROCEDURE affichageListeVentes;

PROCEDURE affichageProdSuprime;

PROCEDURE afficherNumClients;

PROCEDURE afficherNumProduits;

END package_affichage;
/

-- Body du package
CREATE OR REPLACE PACKAGE BODY 
package_affichage AS

PROCEDURE affichageListeClients is

    BEGIN

    DBMS_OUTPUT.PUT_LINE('-----------------');
        DBMS_OUTPUT.PUT_LINE('Liste des clients');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(Rpad('# Client',10) || Rpad('Nom',15) || Rpad('Prenom',15) || Rpad('Telephone',15) || Rpad('# de rue',10) 
        || Rpad('Nom de rue',15) || Rpad('Ville',15) || Rpad('Province',15) || Rpad('Code postal',15) || 'lepays');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
        FOR cur_aff_client in(select numClient, nomClient, prenomClient, telephone, noRue, 
                    nomRue, ville, province, codePostal, pays from clients)
            LOOP
            DBMS_OUTPUT.PUT_LINE(Rpad(cur_aff_client.numClient,10) || Rpad(cur_aff_client.nomClient,15) || Rpad(cur_aff_client.prenomClient,15) || 
            Rpad(cur_aff_client.telephone,15) || Rpad(cur_aff_client.noRue,10) || Rpad(cur_aff_client.nomRue,15) || 
            Rpad(cur_aff_client.ville,15) || Rpad(cur_aff_client.province,15) || Rpad(cur_aff_client.codePostal,15) || cur_aff_client.pays );
        END LOOP; 

    END affichageListeClients;


PROCEDURE affichageListeProduits is

    BEGIN

    DBMS_OUTPUT.PUT_LINE('------------------');
        DBMS_OUTPUT.PUT_LINE('Liste des produits');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(Rpad('# Produit',15) || Rpad('Nom',15) || Rpad('Quantite',10) || 'Prix');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
        FOR cur_aff_produit in(select numProd, nom, quantiteStock, prix from produits)
            LOOP
            DBMS_OUTPUT.PUT_LINE(Rpad(cur_aff_produit.numProd,15) || Rpad(cur_aff_produit.nom,15) 
            || Rpad(cur_aff_produit.quantiteStock,10) || cur_aff_produit.prix);
        END LOOP; 

    END affichageListeProduits;


PROCEDURE affichageListeVentes is

    BEGIN

    DBMS_OUTPUT.PUT_LINE('------------------');
        DBMS_OUTPUT.PUT_LINE('Liste des ventes');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(Rpad('Code vente',15) || Rpad('# Client',10) || Rpad('# Produit',15) || Rpad('Date vente',15) || Rpad('Qte Vendu',15) || 'Prix vente');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
        FOR cur_aff_vente in(select codeVente, numClient, numProd, dateVente, quantiteVendue, prixVente from venteClients)
            LOOP
            DBMS_OUTPUT.PUT_LINE(Rpad(cur_aff_vente.codeVente,15) || Rpad(cur_aff_vente.numClient,10) 
            || Rpad(cur_aff_vente.numProd,15) || Rpad(cur_aff_vente.dateVente,15) || 
            Rpad(cur_aff_vente.quantiteVendue,15) || cur_aff_vente.prixVente);
        END LOOP; 

    END affichageListeVentes;  


PROCEDURE affichageProdSuprime is

    BEGIN

    DBMS_OUTPUT.PUT_LINE('------------------');
        DBMS_OUTPUT.PUT_LINE('Liste des ventes produit supprime');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(Rpad('Code vente',15) || Rpad('# Client',10) || Rpad('# Produit',15) || Rpad('Date vente',15) || Rpad('Qte Vendu',15) || 'Prix vente');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
        FOR cur_aff_vente in(select codeVente, numClient, numProd, dateVente, quantiteVendue, prixVente from venteClientsProdSuprime)
            LOOP
            DBMS_OUTPUT.PUT_LINE(Rpad(cur_aff_vente.codeVente,15) || Rpad(cur_aff_vente.numClient,10) 
            || Rpad(cur_aff_vente.numProd,15) || Rpad(cur_aff_vente.dateVente,15) || 
            Rpad(cur_aff_vente.quantiteVendue,15) || cur_aff_vente.prixVente);
        END LOOP; 

    END affichageProdSuprime;   


PROCEDURE afficherNumClients is

    BEGIN

    DBMS_OUTPUT.PUT_LINE('-----------------');
        DBMS_OUTPUT.PUT_LINE('Liste des # clients');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(Rpad('# Client',15) || Rpad('Nom',25) || 'Prenom');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
        FOR cur_num_client in(select numClient, nomClient, prenomClient from clients)
            LOOP
            DBMS_OUTPUT.PUT_LINE(Rpad(cur_num_client.numClient,15) || Rpad(cur_num_client.nomClient,25) || cur_num_client.prenomClient);
        END LOOP; 

    END afficherNumClients;    


PROCEDURE afficherNumProduits is

    BEGIN

    DBMS_OUTPUT.PUT_LINE('------------------');
        DBMS_OUTPUT.PUT_LINE('Liste des # produits');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE(Rpad('# Produit',15) || 'Nom');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------');
        FOR cur_num_produit in(select numProd, nom from produits)
            LOOP
            DBMS_OUTPUT.PUT_LINE(Rpad(cur_num_produit.numProd,15) || cur_num_produit.nom);
        END LOOP; 

    END afficherNumProduits;    

END package_affichage;
/

SET VERIFY ON