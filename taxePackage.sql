CREATE OR REPLACE PACKAGE package_taxe AS 

FUNCTION coutVente(qte IN NUMBER, prix IN NUMBER)
RETURN NUMBER;

FUNCTION calculTaxes(sous_total IN NUMBER)
RETURN NUMBER;

END package_taxe;
/

CREATE OR REPLACE PACKAGE BODY 
package_taxe AS

    -- Fonction pour calculer le pric selon le nombre de produits
FUNCTION
coutVente(qte IN NUMBER, prix IN NUMBER)
RETURN NUMBER IS

    BEGIN
        RETURN (qte * prix);
    END;

    -- Fonction pour calculer les taxes
FUNCTION
calculTaxes(sous_total IN NUMBER)
RETURN NUMBER IS

    BEGIN
        RETURN (sous_total * 0.15);
    END;

END package_taxe;
/