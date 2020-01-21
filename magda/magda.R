#jednoducha analyza hlavnich komponent (PCA) na prikladu biometrickych dat o Spergula morrisonii

magda<-read.table("magda.txt",header=T)
head(magda)

mstand = decostand(magda,method="stand") 

#poznamka: decostand pusobi jak na objektech typu matice, tak typu data.frame 
#dulezite je, ze objekty nesmi obsahovat chybejici hodnoty - takove radky je treba pred analyzou vyloucit (viz oddil na konci tohoto skriptu)

#prohledneme si, jsme dostali
mstand
summary(mstand)

towork = mstand[,5:13]


#*****************************************************
#vlastni vypocet PCA

rda(towork)  #PCA se spocita pomoci funkce rda

rdout=rda(towork)  #identicke, ale vysledky se ulozi do objektu rdout
summary(rdout)

#podil vysvetlene variability jednotlivymi osami
eigenvals(rdout)

#normalizovany (tj. se souctem vsech eigenvalues rovnym jedne) podil vysvetlene variability
eigenvals(rdout) / sum(eigenvals(rdout))

#graficke znazorneni podilu vysvetlene variability
barplot(as.numeric(eigenvals(rdout) / sum(eigenvals(rdout))),names.arg=paste("Axis",1:9))



#*****************************************************
#znazorneni vlastniho vysledku ordinace

plot(rdout)
biplot(rdout,scaling=-1)


#obecny
xval = scores(rdout)$species[,1] 
yval = scores(rdout)$species[,2] 
xl = c(min(scores(rdout)$sites[,1],scores(rdout)$species[,1]),max(scores(rdout)$sites[,1],scores(rdout)$species[,1])+0.2)
yl = c(min(scores(rdout)$sites[,2],scores(rdout)$species[,2]),max(scores(rdout)$sites[,2],scores(rdout)$species[,2])+0.2)
plot(xval,yval,xlim = xl,ylim=yl,type="p",col="white", 
   xlab=paste("Axis 1, Explvar = ",formatC(summary(rdout)$cont$imp[2,1],format="f",digits=3)), 
   ylab=paste("Axis 2, Explvar = ",formatC(summary(rdout)$cont$imp[2,2],format="f",digits=3))) 
arrows(0,0,xval,yval,lwd=2,length=0.1)
lines(c(xl[1]-0.5,xl[2]+0.5),c(0,0),lty=2) 
lines(c(0,0),c(yl[1]-0.5,yl[2]+0.5),lty=2)
text(xval,yval,names(towork),pos=ifelse(scores(rdout)$species[,1] > 0, 4,2)) 
#points(scores(rdout)$sites[,1],scores(rdout)$sites[,2],pch="+",col="red")
points(scores(rdout)$sites[,1],scores(rdout)$sites[,2],pch=c(19,21)[magda$mrav+1],col="red")
legend("topleft",pch=c(19,21),col="red",legend=c("Louka","Mraveniste"))



#znazornit graficky hodnoty nektere vstupni promenne

plot(rdout, disp="sites", type="n")
points(rdout, disp="sites",pch=c(19,21)[magda$mrav+1]) #velikost bodu odpovida poctu kvetu 
#  je treba sikovne delit/nasobit, aby to vytvorilo smysluplne hodnoty cex tak v rozsahu 0.3-5 
legend("topright",pch=c(19,21),legend=c("Louka","Mraveniste"))

ordispider(rdout,magda$mrav)

mrav= as.factor(magda$mrav)
for (i in 1:nlevels(mrav))
  ordihull(rdout,mrav,show.groups=levels(mrav)[i],col=rainbow(nlevels(mrav))[i])


plot(rdout, disp="sites", type="n")
points(rdout, disp="sites",pch=c(19,21)[magda$mrav+1],cex=(magda$hloubka+3)/6) 
legend("topright",pch=c(19,21),legend=c("Louka","Mraveniste"))

ordispider(rdout,magda$mrav)

mrav= as.factor(magda$mrav)
hl = as.factor(magda$hloubka)
for (i in 1:nlevels(hl))
  ordihull(rdout,hl,show.groups=levels(hl)[i],col=rainbow(nlevels(hl))[i])


rdout = rda(towork~magda$hloubka+mrav)
RsquareAdj(rdout)
plot(rdout,display=c("sp","cn"))

barplot(as.numeric(eigenvals(rdout)))

anova(rdout,by="terms")
anova(rdout,by="margin") #vysledky stejne protoze faktory jsou ortogonalni

xx=varpart(towork,~hloubka,~mrav,data=magda, transfo="stand")
xx
plot(xx)
showvarparts(2)

rdout = rda(towork~magda$hloubka*magda$mrav) #test s interakci
plot(rdout,display=c("sp","cn"))
anova(rdout,by="terms")



