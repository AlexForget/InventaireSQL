SET SERVEROUTPUT ON
SET VERIFY OFF

-- Trigger qui ajoute les éléments supprimés de la table venteClients à une table d'archive

CREATE OR REPLACE TRIGGER triggerdeleteProduit
BEFORE DELETE ON venteClients
FOR EACH ROW

BEGIN

    INSERT INTO venteClientsProdSuprime(codeVente, numClient, numProd, dateVente, quantiteVendue, prixVente)
    VALUES(:OLD.codeVente, :OLD.numClient, :OLD.numProd, :OLD.dateVente, :OLD.quantiteVendue, :OLD.prixVente);

END;
/

SET VERIFY ON