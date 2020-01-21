#prace s daty o druhovem slozeni na prikladu dat Petra Petrika
#data obsahuji pokryvnosti 254 druhu v souboru 134 vegetacnich zapisu
#navazujici datovy soubor obsahuje udaje o environmentalnich promennych pro 134 zapisu

library(vegan)

#**********************************************
#prace s daty
#nacteme data o druzich
a<-read.table(file="PP-druhy2.txt", encoding="latin1",sep="\t",header=T)
dim(a)
summary(a)
head(a) #prvni a posledni sloupec obsahuji neco jineho
        #vsechny absence druhu jsou znaceny jako NA (missing values)
 
specdata = a[,2:(ncol(a)-1)]  #vyloucit prvni a posledni sloupec
specdata[is.na(specdata)] = 0 #nahradit missing values nulami
#summary(specdata)


envidata<-read.table(file="PpetrikF.txt", encoding="latin1",sep="\t",header=T)
attach(envidata)
geoname = as.factor(c("svor","rula","zula","erlan"))[geologie]



#**********************************************
#prima ordinace s kovariatami: kanonicka korespondencni analyza
#obycejna cca pro vliv nadmorske vysky pro srovnani

ccout=cca(specdata ~ nadmv) 
ccout #variabilita dana testovanou promennou

#variabilita vysvetlena jednotlivymi osami (Pozor: prvni je kanonicka)
eigenvals(ccout) / sum(eigenvals(ccout))
barplot(as.numeric(eigenvals(ccout)[1:10] / sum(eigenvals(ccout))))

RsquareAdj(ccout)

#zobrazit bezne druhy
freq = colSums(specdata>0)  #vypocitat frekvence druhu
limitfreq = 30              #zvolena hladina frekvence
plot(ccout,display=c("bp","sp"),type="none")
points(ccout,display="sp",pch="+",select=freq>limitfreq)
points(ccout,display="bp",col="blue",lwd=2)
text(ccout,display="sp",cex=0.5,pos=ifelse(scores(ccout)$species[,1] > 0, 4,2),select=freq>limitfreq )
text(ccout,display="bp")



#analyza nadmorske vysky s geologii jako kovariatou

ccout=cca(specdata ~ nadmv + Condition(as.factor(geologie))) 
ccout #rozklad variability mezi kovariaty (=nezajimave) a testovane (=zajimave) promenne

#variabilita vysvetlena jednotlivymi osami (Prvni je kanonicka) - lisi se od pripadu bez kovariaty
eigenvals(ccout) / sum(eigenvals(ccout))
barplot(as.numeric(eigenvals(ccout)[1:10] / sum(eigenvals(ccout))))

#zobrazit bezne druhy - obrazek se lisi
freq = colSums(specdata>0)  #vypocitat frekvence druhu
limitfreq = 30              #zvolena hladina frekvence
plot(ccout,display=c("bp","sp"),type="none",xlim=c(-2,2),ylim=c(-1,1))
points(ccout,display="sp",pch="+",select=freq>limitfreq)
points(ccout,display="bp",col="blue",lwd=2)
text(ccout,display="sp",cex=0.5,pos=ifelse(scores(ccout)$species[,1] > 0, 4,2),select=freq>limitfreq )
text(ccout,display="bp")

RsquareAdj(ccout)
#adjusted R2 pro cca neni definovan, ale R2 ano

anova(ccout)
anova(ccout,strata = geoname)  #randomizace v ramci hladin danych kovariatami


#**********************************************
#rozklad variability mezi nekolik (lze i korelovanych) promennych

varpart(specdata,~nadmv,~as.factor(geologie),chisquare = T)  
#slouzi pro cca i pro rda
#transfo = "chi.square" pro cca, pro rda prislusna transformace pouzita v decostand

xx = varpart(specdata,~nadmv,~geologie,chisquare = T)  

xx$part$fract$Adj.R.squared      #obsahuje hrube slozky
xx$part$indfract$Adj.R.squared   #obsahuje ciste slozky

#kolacovy graf
pie(xx$part$indfract$Adj.R.squared,labels=c("NM|G","NM+G","G|NM","resid"))
pie(xx$part$indfract$Adj.R.squared[1:3],labels=c("NM|G","NM+G","G|NM")) #bez residualni variability


#analogicky lze zobrazit do sloupcoveho grafu

#funkce pro interpretaci (ne zobrazeni vlastnich dat) vystupu z varpart
#argument udava mezi kolik zdroju se variabilita rozklada (max 4)
showvarparts(2) 

#zobrazeni vlastnich dat
plot(xx,digits=4)


#jiny priklad s vice promennymi (v ramci formuli lze zadavat i interakce, ale tady u korelovanych promennych to neni nejvhodnejsi)
xx = varpart(specdata,~strom+humus,~nadmv+geoname,transfo="chi.square")  



#**********************************************
#srovnani vysvetlene variability s maximalni moznou vysvetlenou variabilitou
#vyjadrit jako podil variability pro stejny pocet os z ca (pozor jde o "ne-adjusted" hodnoty)
ccout = cca(specdata)
ccout1 =  cca(specdata~nadmv)
eigenvals(ccout1)[1] / eigenvals(ccout)[1]
  
#nebo 
ccout2 =  cca(specdata~nadmv+humus+strom)
eigenvals(ccout2)[1] / eigenvals(ccout)[1]



#**********************************************
#postupny vyber promennych

uze = !is.na(stari)
ccout=cca(specdata ~ nadmv + geoname + stari + strom,subset=uze) 

ordistep(ccout,permutations = how(nperm = 499))  #zvetsit pocet permuntaci (default = 199)
#vsechny jsou dulezite :-(

ordistep(ccout,Pout = 0.01,permutations = how(nperm = 499))  #zprisnit kriterium pro vyber



#**********************************************
#poznamka o objektu cca.object v primych ordinacich s kovariatami

str(ccout)           #struktura objektu
# Z klicovych prvku objektu je nenulovy rdout$CCA, ktery obsahuje kanonicke osy a 
#                                       rdout$CA, ktery obsahuje nekanonicke osy 
#                                       rdout$pCCA, ktery obsahuje informace o kovariatach 
#  dale tam jsou prvky analogicke objektum lm (napr. terms)

# funkce typu scores, eigenvals, RsquareAdj funguji stejne jako pro prime ordinace 
#  viz tez
help("cca.object")   #popis objektu reci (relativne) lidskou, vcetne funkci







