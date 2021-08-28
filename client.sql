CLEAR SCREEN

SET serveroutput ON
SET VERIFY OFF

ACCEPT lenom PROMPT "Entrer le nom du client: "
ACCEPT leprenom PROMPT "Entrer le prenom du client: "
ACCEPT letelephone PROMPT "Entrer le telephone du client: "
ACCEPT lenumrue PROMPT "Entrer le numero de rue du client: "
ACCEPT lenomrue PROMPT "Entrer le nom de la rue du client: "
ACCEPT laville PROMPT "Entrer la ville du client: "
ACCEPT laprovince PROMPT "Entrer la province du client: "
ACCEPT lecodepostal PROMPT "Entrer le code postal du client: "
ACCEPT lepays PROMPT "Entrer le pays du client: "

DECLARE
    erreur_telephone EXCEPTION;
    erreur_codePostal EXCEPTION;

BEGIN

        -- Validation du format du numéro de téléphone
    IF regexp_like('&letelephone','^\(\d{3}\)\d{3}-\d{4}$') = FALSE then
        RAISE erreur_telephone;
    END IF; 

        -- Validation du format du code postal
    IF regexp_like(UPPER('&lecodepostal'),'^([A-Z]\d){3}$') = FALSE then
        RAISE erreur_codePostal;
    END IF;  

        -- Si tous est valide insertion dans la table
    INSERT INTO clients (numClient, nomClient, prenomClient, telephone, noRue, 
                nomRue, ville, province, codePostal, pays)
    VALUES (upper(SUBSTR('&lenom',1,3))||upper(SUBSTR('&leprenom',1,2)), '&lenom', '&leprenom', '&letelephone', '&lenumrue', 
            '&lenomrue', '&laville', '&laprovince', upper('&lecodepostal'), '&lepays');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Insertion reussie');

    package_affichage.affichageListeClients;

    EXCEPTION 
        WHEN dup_val_on_index THEN
            DBMS_OUTPUT.PUT_LINE('Ce numero de client existe deja.'); 
        WHEN erreur_telephone THEN
            DBMS_OUTPUT.PUT_LINE('Le format du numero de telephone est non valide.'); 
            DBMS_OUTPUT.PUT_LINE('Format attendu : (###)###-####.');   
        WHEN erreur_codePostal THEN
            DBMS_OUTPUT.PUT_LINE('Le format du code postal est non valide.'); 
            DBMS_OUTPUT.PUT_LINE('Format attendu : H#H #H#.');   
        when others then
            DBMS_OUTPUT.PUT_LINE('Une erreur c''est produite');  
  
END;
/

SET verify ON

PAUSE Appuyer sur une touche pour continuer.
@C:\Users\AlexForget\Documents\PLSQL\Projet\menuProjet.sql