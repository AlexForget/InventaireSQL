CLEAR SCREEN

PROMPT MENU PRINCIPAL
PROMPT 1: Mise a jour d'un numero de client
PROMPT 2: Supprimer un produit
PROMPT 3: Quitter le proramme
ACCEPT selection PROMPT "Entrer option 1-3: "

SET TERM OFF

COLUMN script NEW_VALUE v_script
SELECT CASE '&selection'
WHEN '1' THEN 'updateNumClient.sql'
WHEN '2' THEN 'deleteProduitScript.sql'
WHEN '3' THEN 'quitter.sql'
ELSE 'menuProjet.sql'
END AS script
FROM dual;

SET TERM ON
@C:\Users\AlexForget\Documents\PLSQL\Projet\&v_script