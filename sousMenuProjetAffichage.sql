CLEAR SCREEN
PROMPT MENU PRINCIPAL
PROMPT 1: Affichage des clients
PROMPT 2: Affichage des produits
PROMPT 3: Affichage des ventes
PROMPT 4: Affichage des ventes de produits supprime
PROMPT 5: Quitter le proramme
ACCEPT selection PROMPT "Entrer option 1-5: "

SET TERM OFF

COLUMN script NEW_VALUE v_script
SELECT CASE '&selection'
WHEN '1' THEN 'affichageClients'
WHEN '2' THEN 'affichageProduits.sql'
WHEN '3' THEN 'affichageVenteClients.sql'
WHEN '4' THEN 'affichageVentesClientsSuprime.sql'
WHEN '5' THEN 'quitter.sql'
ELSE 'sousMenuProjetAffichage.sql'
END AS script
FROM dual;

SET TERM ON
@C:\Users\AlexForget\Documents\PLSQL\Projet\&v_script