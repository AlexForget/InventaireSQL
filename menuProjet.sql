CLEAR SCREEN

PROMPT MENU PRINCIPAL
PROMPT 1: Creation des tables
PROMPT 2: Affichage des tables
PROMPT 3: Insertion dans les tables
PROMPT 4: Afficher la facturation
PROMPT 5: Faire un rabais
PROMPT 6: Faire une mise a jour ou une suppression
PROMPT 7: Quitter le proramme
ACCEPT selection PROMPT "Entrer option 1-7: "

SET TERM OFF

COLUMN script NEW_VALUE v_script
SELECT CASE '&selection'
WHEN '1' THEN 'venteLibre.sql'
WHEN '2' THEN 'sousMenuProjetAffichage.sql'
WHEN '3' THEN 'sousMenuInsertion.sql'
WHEN '4' THEN 'facture.sql'
WHEN '5' THEN 'rabais.sql'
WHEN '6' THEN 'sousMenuMiseAJourSupp.sql'
WHEN '7' THEN 'quitter.sql'
ELSE 'menuProjet.sql'
END AS script
FROM dual;

SET TERM ON
@C:\Users\AlexForget\Documents\PLSQL\Projet\&v_script