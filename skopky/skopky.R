#jednoducha analyza hlavnich komponent (PCA) na prikladu biometrickych dat o Spergula morrisonii

skopkyS<-read.table("skopkyS.txt",header=T,sep="\t")
skopkyE<-read.table("skopkyE.txt",header=T)

summary(skopkyS)
summary(sqrt(skopkyS))

colSums(skopkyS>0)
hist(skopkyS[,2])

min(skopkyS[skopkyS>0])

pdf(file="hist.pdf")

for (i in 1:ncol(skopkyS)) {
  hist(skopkySlog[,i],main=colnames(skopkyS)[i])
}  
dev.off()

colSums(skopkyS)

skopkySBN = skopkyS[,-which(colSums(skopkyS)==0)]


skopkySBNsq = sqrt(skopkyS)
skopkySBNlog = log(skopkySBN+min(skopkyS[skopkyS>0]))

skopkySBNlogst = decostand(skopkySBNlog,method="norm") 
skopkySBNsqst = decostand(skopkySBNsq,method="norm")

#*****************************************************
#vypocet PCA - zkoumani standardizaci a transformaci

pdf(file="pca.pdf")

rdout=rda(skopkySBN)  #PCA se spocita pomoci funkce rda
plot(rdout,main="nestand")

rdout=rda(skopkySBNlog)  #PCA se spocita pomoci funkce rda
plot(rdout,main="log")

rdout=rda(skopkySBNsq)  #PCA se spocita pomoci funkce rda
plot(rdout,main="sqrt")

rdout=rda(skopkySBNlogst)  #PCA se spocita pomoci funkce rda
plot(rdout,main="log-norm")

rdout=rda(skopkySBNsqst)  #PCA se spocita pomoci funkce rda
plot(rdout,main="sqrt-norm")

dev.off()


#znazornit graficky hodnoty nektere vstupni promenne

rdout=rda(skopkySBNlogst)
rdout=rda(skopkySBNsqst)
plot(rdout, disp="sites", type="n")
points(rdout, disp="sites",pch=c(19,21)[skopkyE$Rich+1]) #velikost bodu odpovida poctu kvetu 
#  je treba sikovne delit/nasobit, aby to vytvorilo smysluplne hodnoty cex tak v rozsahu 0.3-5 
legend("topright",pch=c(19,21),legend=c("Poor","Rich"))


#RDA

rdout = rda(skopkySBNlogst~as.factor(skopkyE$Rich)+skopkyE$Densita)
RsquareAdj(rdout)
plot(rdout,display=c("sp","cn"))

barplot(as.numeric(eigenvals(rdout)))

anova(rdout,by="terms")
anova(rdout,by="margin") #vysledky stejne protoze faktory jsou ortogonalni

xx=varpart(skopkySBNlogst,~as.factor(skopkyE$Rich),~skopkyE$Densita,data=skopkyE)
xx
plot(xx)
showvarparts(2)

rdout = rda(skopkySBNlogst~as.factor(skopkyE$Rich)*skopkyE$Densita) #test s interakci
plot(rdout,display=c("sp","cn"))
anova(rdout,by="terms")



