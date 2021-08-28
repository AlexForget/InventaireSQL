SET SERVEROUTPUT ON
SET VERIFY OFF

-- Triiger pour mettre à jour en cascade un numero de clients de la table client vers la table venteClients

CREATE OR REPLACE TRIGGER trigger_update_numClient
AFTER UPDATE OF numClient ON clients
FOR EACH ROW

BEGIN
    DBMS_OUTPUT.PUT_LINE('Modification en cascade du numero de client : ' ||:NEW.numClient || ' ,dans la table venteClients.');
    update venteClients set numClient=:NEW.numClient where numClient=:OLD.numClient;
END;
/

SET VERIFY ON
