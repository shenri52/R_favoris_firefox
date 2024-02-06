##############################################################################################
# Ce programme a pour objectif de récupérer les favoris firefox sous la forme d'un tableau   #
##############################################################################################
# Fonctionnement :                                                                           #
#     1 - Copier le fichier "places.sqlite" dans le dossier "data"                           #
#         Ce fichier se trouve dans le dossier :                                             #
#         C:\Users\NOM_UTILISATEUR\AppData\Roaming\Mozilla\Firefox\Profiles\zjy4l49k.default #
#     2 - Lancer le script                                                                   #
#                                                                                            #
# Résultat :                                                                                 #
# Le tableau contenant les favoris se trouve dans le dossier "result" et se nomme            #
# "favoris.csv"                                                                              #
##############################################################################################


#################### Chargement des librairies

source("script/librairie.R")

#################### Suppression des fichiers gitkeep

source("script/suppression_gitkeep.R")

#################### Récupération et mise en forme des favoris

source("script/bookmarks.R")
