CLEAR SCREEN

        -- Scripte pour la création des tables

SET serveroutput ON
SET VERIFY OFF

DECLARE
    erreur_table EXCEPTION;
    PRAGMA exception_INIT(erreur_table,-955);

BEGIN

    BEGIN

        EXECUTE IMMEDIATE   'create table produits(
                            numProd varchar2(15) primary key,
                            nom varchar2(15),
                            quantiteStock number(10),
                            prix number(10,2))';
        DBMS_OUTPUT.PUT_LINE('La table produits a ete cree');
    
        EXCEPTION
            WHEN erreur_table THEN
            DBMS_OUTPUT.PUT_LINE('La table produits existe deja');

    END;

    BEGIN

        EXECUTE IMMEDIATE   'create table clients(
                            numClient varchar2(10) primary key,
                            nomClient varchar2(15),
                            prenomClient varchar2(15),
                            telephone varchar2(15) NOT NULL,
                            noRue varchar2(10),
                            nomRue varchar2(10),
                            ville varchar2(15),
                            province varchar2(10),
                            codePostal varchar2(8),
                            pays varchar2(10))';
        DBMS_OUTPUT.PUT_LINE('La table clients a ete cree');
    
        EXCEPTION
            WHEN erreur_table THEN
            DBMS_OUTPUT.PUT_LINE('La table clients existe deja');

    END;

    BEGIN
    
        EXECUTE IMMEDIATE   'create table venteClients(
                            codeVente number(20) primary key,
                            numClient varchar2(10),
                            numProd varchar2(15),
                            dateVente date,
                            quantiteVendue number(10),
                            prixVente number(10,2),
                            constraint fk_numClient foreign key(numClient) references clients(numClient),
                            constraint fk_numProd foreign key(numProd) references produits(numProd))';
        DBMS_OUTPUT.PUT_LINE('La table venteClients a ete cree');

    
    EXCEPTION
        WHEN erreur_table THEN
        DBMS_OUTPUT.PUT_LINE('La table venteClients existe deja');

    END;

    BEGIN
    
        EXECUTE IMMEDIATE   'create table venteClientsProdSuprime(
                            codeVente number(20) primary key,
                            numClient varchar2(10),
                            numProd varchar2(15),
                            dateVente date,
                            quantiteVendue number(10),
                            prixVente number(10,2))';
        DBMS_OUTPUT.PUT_LINE('La table venteClientsProdSuprime a ete cree');

    
    EXCEPTION
        WHEN erreur_table THEN
        DBMS_OUTPUT.PUT_LINE('La table venteClientsProdSuprime existe deja');

    END;

END;
/

SET verify ON

SET TERM ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql