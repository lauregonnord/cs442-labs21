Fichiers pour le TP Lustre de MIF25, juin 2016.

Partie Arduino : cette fois on utilise la lib arduino haut niveau
--> modifier dans le makefile le chemin vers Arduino.h

pour tester make ; make upload

Partie Lustre : pour cette partie il faut installer Lustre:
http://www-verimag.imag.fr/wordpress/raymond/?p=148 et mettre comme il
faut les variables dans le PATH (le script fourni doit faire tout
cela).

pour tester :
    * make demo doit ouvrir une fenetre graphique luciole pour tester
    le fichier
    * make demostd doit compiler un binaire
    interaction avec l'utilisateur
    * make auto compile un .atg qui peut s'ouvrir avec atg :-)
    * make check utile le model checker lesar.
