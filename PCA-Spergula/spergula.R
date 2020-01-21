#jednoducha analyza hlavnich komponent (PCA) na prikladu biometrickych dat o Spergula morrisonii


#priradit knihovnu vegan
library(vegan)



#*****************************************************
#prace s daty
#nacist a prohlednout si data
spergula<-read.table("spergula.txt",header=T)
head(spergula)
dim(spergula)
summary(spergula)

#standardizovat data (jde o biometricke promenne, kazda je v jinych jednotkach, takze standardizace po promennych je nezbytna
#vic o standardizacich pozdeji (data Petra Petrika)

astand = decostand(spergula,method="stand") 

#poznamka: decostand pusobi jak na objektech typu matice, tak typu data.frame 
#dulezite je, ze objekty nesmi obsahovat chybejici hodnoty - takove radky je treba pred analyzou vyloucit (viz oddil na konci tohoto skriptu)

#prohledneme si, jsme dostali
astand
summary(astand)



#*****************************************************
#vlastni vypocet PCA

rda(astand)  #PCA se spocita pomoci funkce rda

rdout=rda(astand)  #identicke, ale vysledky se ulozi do objektu rdout
summary(rdout)

#podil vysvetlene variability jednotlivymi osami
eigenvals(rdout)

#normalizovany (tj. se souctem vsech eigenvalues rovnym jedne) podil vysvetlene variability
eigenvals(rdout) / sum(eigenvals(rdout))

#graficke znazorneni podilu vysvetlene variability
barplot(as.numeric(eigenvals(rdout) / sum(eigenvals(rdout))),names.arg=paste("Axis",1:4))

#kumulativni podil vysvetlene variability jednotlivymi osami
cumsum(eigenvals(rdout)) / sum(eigenvals(rdout))
barplot(as.numeric(cumsum(eigenvals(rdout)) / sum(eigenvals(rdout))),names.arg=paste("Axis",1:4))

#vsechno tohle je hezky dostupne jako prvek v summary(rdout):
summary(rdout)$cont$imp
#treba
barplot(summary(rdout)$cont$imp[2:3,],beside=T)
legend("topleft",fill=c("grey20","grey75"),legend=c("proportion explained","cumulative"))



#*****************************************************
#znazorneni vlastniho vysledku ordinace

plot(rdout)
biplot(rdout,scaling=-1)

#dalsi graficke funkce v samostatnem souboru

#dalsi vystupy v numericke forme pro pristi analyzy nebo vlastni kresleni obrazku

scores(rdout)
scores(rdout)$species #promenne (vegan pouziva konvenci Canoca: promenne = species, objekty = sites)
scores(rdout)$sites  #objekty (v nasem pripade merene promenne)


#blizsi pohled na vystup funkce scores

str(scores) #funkce str ukaze strukturu nejakeho objektu
            #scores vraci seznam (list) o dvou polozkach (sites a scores) k nimz se pristupuje napriklad pomoci operatoru $

#dulezite parametry funkce scores 
#display: species or sp for species scores, sites or wa for site scores
#choices: pro ktere osy

scores(rdout,display="sp") #alternativni zpusob ziskani skoru promennych



#************************************************************
#vylouceni radku s chybejicimi hodnotami

spergula
summary(spergula)
dim(spergula)

spergula[3,3] = NA                                #vytvorime chybejici hodnotu
summary(spergula)                                 #ukaze vzniklou chybejici hodnotu
decostand(spergula, method="stand")               #hlasi chybu

#je treba tedy vyloucit radky s chybejici hodnotou napr. takto
rowSums(spergula)                                 #soucet cisel je NA, pokud alespon jedno z nich je NA
spergula1 = spergula[!is.na(rowSums(spergula)),]  #vyradime vsechny radky, jejich soucet je NA (a zachovame vsechny sloupce, proto za carkou neni nic)
dim(spergula1)                                    #vsimnete si vyrazeneho radku 
spergula1                                         #vsimnete si, ze radek 3 schazi
decostand(spergula1, method="stand")              #uz nehlasi chybu





#************************************************************
#anatomie objektu cca.object (pro pokrocilejsi)

#cca.object (v nasem pripade pojmenovany rdout) je slozity objekt, k jehoz slozkam je mozno pristupovat primo, 
#  nebo pomoci specializovanych funkci

str(rdout)           #struktura objektu
help("cca.object")   #popis objektu reci (relativne) lidskou
#tam je taky prehled funkci (jako napr scores nebo eigenvals) pomoci nichz se pristupuje k jednotlivym castem objektu 

# Z klicovych prvku objektu je nenulovy jen rdout$CA, ktery obsahuje vysledky neprime ordinace (jako napr. PCA)

#priklad pristupu pomoci funkci (doporuceno)
scores(rdout)$species
eigenvals(rdout) 

#priklad primeho pristupu (clovek musi vedet, co dela)
rdout$CA$eig / sum(rdout$CA$eig)
rdout$CA$eig 

#pozor: scores v objektu cca.object (rdout$CA$u a rdout$CA$v) jsou neskalovane - to za nas udela funkce scores
#  o skalovani skoru je hojne pojednano v souboru decision-vegan.pdf 
#  (dostupne na strance veganu na CRAN nebo pomoci browseVignettes("vegan") )



