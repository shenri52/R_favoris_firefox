# Script R : favoris_firefox

Ce script a pour objectif de récupérer les favoris firefox sous la forme d'un tableau.

## Descriptif du contenu

* Racine : emplacement du projet R --> "FAVORIS_FIREFOX.Rproj"
* Un dossier "data" pour le stockage du fichier "places.sqlite"
* Un dossier "result" pour le stockage du résultat
* Un dosssier script qui contient :
  * prog_favoris.R --> script principal
  * librairie.R --> script contenant les librairies utiles au programme
  * favoris.R --> script de mise en forme des favoris firefox
  * suppression_gitkeep.R --> script de suppression des .gitkeep

## Fonctionnement

1. Copier le fichier "places.sqlite" dans le dossier "data"
   Ce fichier se trouve dans le dossier : C:\Users\NOM_UTILISATEUR\AppData\Roaming\Mozilla\Firefox\Profiles\zjy4l49k.default
2. Lancer le script intitulé "prog_favoris" qui se trouve dans le dossier "script"

## Résultat

Le tableau contenant les favoris se trouve dans le dossier "result" et se nomme "favoris.csv".
