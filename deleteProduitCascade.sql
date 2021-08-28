SET SERVEROUTPUT ON

-- Trigger qui supprime en cascade dans la table venteClients les produits supprimé de la table produits

CREATE OR REPLACE TRIGGER triggerdeleteCascade
AFTER DELETE ON produits
FOR EACH ROW

BEGIN
    DBMS_OUTPUT.PUT_LINE('Suppression en cascade du produit numero : ' ||:OLD.numProd || ' sur la table venteClients');

    --Suppresion en cascade
    delete from venteClients where numProd = :old.numProd;
END;
/