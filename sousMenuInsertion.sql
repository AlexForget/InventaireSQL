CLEAR SCREEN
PROMPT MENU PRINCIPAL
PROMPT 1: Ajout d'un client
PROMPT 2: Ajout d'un produit
PROMPT 3: Ajout d'une vente
PROMPT 4: Quitter le proramme
ACCEPT selection PROMPT "Entrer option 1-4: "

SET TERM OFF

COLUMN script NEW_VALUE v_script
SELECT CASE '&selection'
WHEN '1' THEN 'client.sql'
WHEN '2' THEN 'produits.sql'
WHEN '3' THEN 'venteClient.sql'
WHEN '4' THEN 'quitter.sql'
ELSE 'menuProjet.sql.sql'
END AS script
FROM dual;

SET TERM ON
@C:\Users\AlexForget\Documents\PLSQL\Projet\&v_script