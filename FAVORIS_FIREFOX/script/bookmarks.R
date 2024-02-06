#################### Récupération et mise en forme des favoris

# Connexion à la base
con <- dbConnect(drv = SQLite(), 
                 dbname = "data/places.sqlite",
                 bigint="character")

# Obtenir toutes les tables
tables <- dbListTables(con)

# Supprimer les tables internes
tables <- tables[tables != "sqlite_sequence"]

# Créer une liste de dataframe des tables de la base
list_of_df <- map(tables, ~{
                  dbGetQuery(conn = con, statement=paste0("SELECT * FROM '", .x, "'"))
                           })

# Obtenir la liste des dataframes
names(list_of_df) <- tables

# Récupération de l'arborescence des favoris (dossier et nom des raccourcis)
favoris <- list_of_df[["moz_bookmarks"]]  %>%
           select(-type, -syncChangeCounter, -syncStatus, -guid, -lastModified, -dateAdded, -folder_type, -keyword_id, -position)

# Conversion de variables en facteur
favoris$id <- as.factor(favoris$id)
favoris$parent <- as.factor(favoris$parent)

# Récupération des adresses htpp
urls <- list_of_df[["moz_places"]] %>%
        select(id, url)

df_favoris <- favoris #%>%
# Filtrer la table des favoris pour ne récupérer que le contenu d'un dossier
# Exemple : dossier DONNEES
#               filter(title == "DONNEES")

# Initialisation de variables
test_na <- count(df_favoris)
i <- 1

# Boucle de reconstitution de l'arborescence des favoris
while(test_na$n != 0)
{  
  # Sélection des données correspondant au sous-dossier
  test<- favoris %>%
         filter(parent %in% c(df_favoris$id)) %>%
         select (id, fk, parent, title)
  
  # Test de la présence de sous-dossiers    
  test_na <- count(test)
      
  if(test_na$n != 0)
  {
    # Préparation de la table des favoris pour jointure des sous-dossiers
    df_favoris <- df_favoris %>%
                  rename.variable("title", paste("D",i, sep="")) %>%
                  rename.variable("fk", "fk1") %>%
                  select( -parent)
    
    # Jointure des sous-dossiers      
    df_favoris <- full_join(test, df_favoris, by = c("parent" = "id"))
    
    # Conservation de l'identifiant url situé dans la variable fk   
    df_favoris <- df_favoris %>%
                  mutate(fk = ifelse(is.na(fk), fk1, fk)) %>%
                  select(-fk1)
      
    i <- i+1
    }
}

# Jointure des URL
df_favoris <- df_favoris %>%
              select(-id, -parent) %>%
              left_join(urls, by = c("fk" = "id")) %>%
              select(-fk)

# Export des données
write.table(df_favoris,
            file = paste("result/favoris.csv"),
            fileEncoding = "UTF-8",
            sep =";",
            row.names = FALSE)