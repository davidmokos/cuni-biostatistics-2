#uvod do grafiky mnohorozmernych analyz na prikladu PCA o Spergula morrisonii



#*****************************************************
#vypocet
library(vegan)
spergula<-read.table("spergula.txt",header=T)
astand = decostand(spergula,method="stand") 
rdout=rda(astand)
summary(rdout)



#*****************************************************
#funkce plot.cca
plot(rdout)  #pouziva funkci plot.cca
help("plot.cca")

#dulezite parametry:
#choices: ktere osy kreslit
#display: species or sp for species scores, sites or wa for site scores (dalsi varianty probereme u primych ordinaci)

plot(rdout,display="wa")
plot(rdout,display="sp")

ifarrow = T  # T pokud clovek chce sipky, jinak F
plot(rdout,type="none")                      #vytvori prazdny graf
points(rdout,display="si",pch=20,col="red")
if (ifarrow)
  arrows(0,0,scores(rdout)$species[,1],scores(rdout)$species[,2],lwd=2,length=0.1) else
  points(rdout,display="sp",pch=20)
text(rdout,display="sp",pos=4)

#funkce biplot
biplot(rdout) 


#*****************************************************
#manualni kresleni obrazku
#je slozitejsi (o trosku), ale poskytuje uzivateli plnou flexibilitu grafickych funkci prostredi R


#prvni nahled objektu
plot(scores(rdout)$sites[,1],scores(rdout)$sites[,2],pch="+") 

#prvni nahled promennych
xval = scores(rdout)$species[,1] 
yval = scores(rdout)$species[,2] 
plot(xval,yval) 

#lepsi
plot(xval,yval,xlim = c(-0.2,2),pch=19,type="p")
text(xval,yval,names(spergula),pos=4)

#lepsi se sipkami
plot(xval,yval,xlim = c(-0.2,2),pch=19,type="p")
arrows(0,0,xval,yval,lwd=2,length=0.1)
text(xval,yval,names(spergula),pos=4) 

#jeste lepsi se sipkami, bez puntiku a s osovym krizem
plot(xval,yval,xlim = c(-0.2,2),pch=19,type="p",col="white")
arrows(0,0,xval,yval,lwd=2,length=0.15)
lines(c(-0.5,2.5),c(0,0),lty=2) #je mozne pretahnout, par("xpd") ma preddefinovanou hodnotu FALSE, cili osy cary oriznou
lines(c(0,0),c(-0.8,1.5),lty=2)
text(xval,yval,names(spergula),pos=4) 

#dokreslit body pro objekty
points(scores(rdout)$sites[,1],scores(rdout)$sites[,2],pch="+",col="red") #pozor rozsah os vymezen skory druhu, mozna nektere objekty schazi


#obecny
xl = c(min(scores(rdout)$sites[,1],scores(rdout)$species[,1]),max(scores(rdout)$sites[,1],scores(rdout)$species[,1])+0.2)
yl = c(min(scores(rdout)$sites[,2],scores(rdout)$species[,2]),max(scores(rdout)$sites[,2],scores(rdout)$species[,2])+0.2)
plot(xval,yval,xlim = xl,ylim=yl,type="p",col="white", 
   xlab=paste("Axis 1, Explvar = ",formatC(summary(rdout)$cont$imp[2,1],format="f",digits=3)), 
   ylab=paste("Axis 2, Explvar = ",formatC(summary(rdout)$cont$imp[2,2],format="f",digits=3))) 
arrows(0,0,xval,yval,lwd=2,length=0.15)
lines(c(xl[1]-0.5,xl[2]+0.5),c(0,0),lty=2) 
lines(c(0,0),c(yl[1]-0.5,yl[2]+0.5),lty=2)
text(xval,yval,names(spergula),pos=ifelse(scores(rdout)$species[,1] > 0, 4,2)) 
points(scores(rdout)$sites[,1],scores(rdout)$sites[,2],pch="+",col="red")


#znazornit graficky hodnoty nektere vstupni promenne

plot(rdout, disp="sites", type="n")
points(rdout, disp="sites",pch=20,cex=spergula$kvety/3) #velikost bodu odpovida poctu kvetu 
#  je treba sikovne delit/nasobit, aby to vytvorilo smysluplne hodnoty cex tak v rozsahu 0.3-5 
legend("bottomright",pch=20,pt.cex=c(1,4,7,10)/3,title="Flower number",legend=c("1","4","7","10"))




