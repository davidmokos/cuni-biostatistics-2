
## Z�klady zach�zen� s R (autor velke casti Zdenek Janovsky)

## Z�kladn� pozn�mky k fungov�n� jazyka R

# R je tzv. objektov� orientovan� jazyk, t.j. m� objekty obsahuj�c� n�jak� data
# a funkce, kter� s objekty pracuj�. Podstatnou vlastnost� objekt� a t�m, co z R
# �in� objektov� orientovan� jazyk pak je, �e objekty pat�� do r�zn�ch t��d
# (object classes), kter� napom�haj� funkc�m s nimi spr�vn� pracovat.


## Typy objekt�

# B�hem analysy dat se budeme zpo��tku setk�vat se dv�ma typy objekt�: 
# 1) vektory (vector - nen� t��dou objektu ve smyslu v��e popsan�m - viz n�e) 
# a 2) datov�mi maticemi (data.frame - p�edstavuje samostatnou t��du). Vektor
# p�edstavuje �adu n�jak�ch prvk� stejn�ho typu, nej�ast�ji ��sel (viz n�e),
# kter� mohou p�edstavovat n�jakou prom�nnou. Datov� matice pak p�edstavuje v�ce
# takov�chto stejn� dlouh�ch vektor� sv�zan�ch do matice.


## Typy prom�nn�ch - t��dy vektor�

# Samostatn� vektory, tak i vektory v r�mci datov� matice maj� svoji t��du podle typu dat, kter� obsahuj�.

# Numeric - p�edstavuje z�kladn� t��du pro pr�ci s ��sly, m��e obsahovat jak�koliv ��sla a chyb�j�c� hodnoty (NA); n�kter� funkce pracuj� s t��dou integer, kter� obsahuje pouze cel� ��sla, pro na�e pot�eby se v�ak tyto t��dy chovaj� stejn�.
# Character - tato t��da nijak bl�e nespecfikuje obsah jednotliv�ch prvk� a zach�z� s nimi jako s textem (i kdy� tam jsou ��sla), tuto t��du nebudeme p��li� aktivn� vyu��vat, setk�me se s n� pouze p�i redukci hladin faktor� (viz n�e) a narazili byste n�kdy na ni, pokud byste dostali �patn� zak�dovan� ��seln� prom�nn�, kter� byste pot�ebovali p�ev�st na ��sla.
# Factor - je pro statistick� analysy neju�ite�n�j�� t��dou pro pr�ci s kategori�ln�mi prom�nn�mi (nap�. barva o�� - zelen�/modr�/hn�d�). Narozd�l od textu (character) rozezn�v� jednotliv� hladiny, t.j. v�echny hodnoty "modr�" jsou pova�ov�ny za stejnou hodnotu. Pojmenov�n� t�chto hladin je arbitr�rn� a lze ho m�nit (uk�eme si), proto�e jednotliv� hladiny faktoru jsou ve skute�nosti zak�dov�ny ��slem (pozd�ji vyu�ijeme p�i kreslen� graf�).

# U�ite�n� pro p�ev�d�n� mezi t�mito t��dami vektor� jsou funkce "as.", t.j. as.factor, as.numeric, as.character atd. My je sice obvykle pou��vat nebudeme, proto�e budeme p�ev�n� pou��vat ji� vy�i�t�n� datov� soubory, ale v praxi je budete pot�ebovat pravideln�.


## Vytv��en� objekt� - pojmenov�vac� konvence

# R vych�z� z logiky unixov�ch program�, co� konkr�tn� z hlediska pojmenov�v�n�
# znamen�, �e se rozli�uj� mal� a velk� p�smena v n�zvu objektu "Data" se
# nerovn� "data". N�zvy rovn� nesm� obsahovat vyhrazen� znaky oper�tor� -
# konkr�tn� p�edev��m: !,=,<,>,*,/,|,",?,(,),[,],{,},@,$. N�zvy objekt� sice sm�
# obsahovat ��slo, ale nesm� j�m za��nat. Volba n�zvu objektu by m�la sledovat
# dva c�le - n�zev by nem�l by p��li� dlouh�, proto�e objekty budeme �asto a
# opakovan� volat; n�zev by ov�em m�l b�t dostate�n� v�sti�n�, abychom i za
# t�den poznali, co dan� objekt obsahuje. N�zvy objekt� v r�mci jedn� analysy
# (t.j. pracovn�ho prostoru, viz n�e) mus� b�t unik�tn�. D�razn� nedoporu�uji
# pou��vat pro prom�nn� del��ho trv�n� n�zvy na jedno p�smeno, pop�. n�zvy
# kryj�c� se s n�zvem n�jak� funkce (nap�. sum). Zat�mco v prvn�m p��pad� danou
# prom�nnou nedok�ete zp�tn� naj�t ve skriptu (zkuste hledat t�eba "i") ve
# druh�m p��pad� bude krom� tohoto i �elit probl�mu, �e V�m nep�jde p��mo�a�e
# zavolat dan� funkce. R sice od jist� doby u� ovl�d� p�smenka s diakritikou,
# sp�e bych V�s p�ed nimi varoval, proto�e ne v�echny funkce s nimi mohou
# pracovat dob�e, i kdy� ve versi 3.0 a vy��� vypadaj�, �e u� mo�n� pracuj�
# dob�e v�ude.


## Vytv��en� objekt� - p�i�azovac� oper�tory

# R rozezn�v� dva typy z�kladn� p�i�azovac� oper�tory, kter� jsou ale z�m�nn�:
# "<-" P�i�azovac� oper�tor �ipka p�i�azuje objektu nalevo od sebe objekt, funkci nebo data napravo od sebe (p��padn� funguje oper�tor i v opa�n� podob�, ale s t�m se norm�ln� nesetk�te). 
# Oper�tor "=" (pozor pouze jedno, narozd�l od oper�toru "==") prov�d� stejnou operaci jako oper�tor �ipka (v z�kladn� versi)
# Existuje v�ak pom�rn� �irok� usus, �e oper�tor "<-" se pou��v� pro p�i�azov�n� obsahu objekt�m, zat�mco oper�tor "=" se pou��v� pro p�i�azov�n� hodnot argument�m v r�mci funkce.

## Praktick� zkou�ka tvorby objekt�:

sestka<-6
ctyrka<-4

# Obsah objekt� se vyvol� naps�n�m jm�na
sestka
ctyrka

# Kdy� chci vytvo�it vektor o v�ce ne� jednom prvku, mus�m prvky vektoru uzav��t do vektorov� funkce c()
rada<-c(1,2,3,4,5,6)
rada

# Objektu mohu p�i�adit i jin� objekt
sestka2<-sestka
sestka2
sestka


## Nahr�v�n� datov�ch matic - pracovn� adres��e

# R p�i ka�d�m spu�t�n� pou��v� n�jak� adres�� jako pracovn� (defaultn� sv�j vlastn�). Pokud chceme do n�ho nahr�vat n�jak� soubory nebo je naopak chceme z R exportovat, nejjednodu��� je to p�es tento pracovn� adres��.
# Rovn� je u�ite�n� z�sada, co analysa (nebo v na�em p��pad� co praktikum) to jeden adres��. Do n�ho si nakop�rujeme v�echny vstupn� soubory a do n�ho si potom exportujeme v�echny v�stupy.
# Pracovn� slo�ka se nastavuje v Menu>File>Change dir... p��padn� funkc� set.wd()
# Datov� matice typicky nezad�v�me do R pomoc� kl�vesnice �i pomoc� vestav�n�ho editoru (viz n�e), n�br� pomoc� n�kter� funkce, na��taj�c� soubory z pracovn�ho adres��e (v�echny za��naj� na read.).

# Nahr�v�n� datov�ch matic v RStudiu
# Pracovn� slo�ka se nastavuje v z�lo�ce Session>Set working directory.
# Datovou matici lze importovat p�es nab�dku Import Dataset v okn� Environment.


## Anatomie funkc�

# Funkce se od objekt� rozeznaj� tak, �e za jejich jm�nem v�dy n�sleduj� kulat� z�vorky uzav�raj�c� argumenty funkce (jsou-li n�jak�, n�kter� funkce nemaj� argumenty, viz n�e)
# Argumenty funkc� jsou mezi sebou v�dy odd�leny ",". (R pou��v� desetinnou te�ku, kterou je vhodn� si i nastavit jako odd�lova� desetinn�ch m�st v Excelu).
# Ka�d� argument ve funkci m� sv�j n�zev, kter� lze zjistit v n�pov�d�, pokud uv�d�me argumenty v po�ad�, v jak�m jsou uvedeny ve funkci, nemus�me pou��vat jejich n�zev a sta�� je odd�lovat, v opa�n�m p��pad� (nebo t�eba kdy� n�kter� argumenty nevypl�ujeme) mus�me v�dy napsat jm�no argumentu a p�i�adit mu hodnotu.
# P��kaz pak vypad� n�jak takto: objekt<-funkce(arg1=hodnota1,arg2=hodnota2)

#Zakladni poucka pri zachazeni s funkcemi zni: (i) koukej se na helpy. Druha zakaldni poucka zni (ii) hledej kdes to udelal driv a jak to fungovalo
#Pokud nevime, jaka funkce kona to, co clovek potrebuje, lze obvykle snadno vyhledat vyhledavacem na netu, nebo v prostredi R


## Vlastn� nahr�n� datov� matice

# Nej�ast�ji pou��van�m form�tem souboru pro import dat do R je textov� dokument s bu�kami odd�len�mi tabul�tory (pop�. ��rkami, zejm�na v americk�m prost�ed�).
# Takov� soubory se nejl�pe na��taj� funkci read.table s p��slu�n�mi argumenty.

spergula<-read.table("spergula.txt",header=T)
# Prvn� argument je n�zev souboru - v�imn�te si, �e je v �vozovk�ch - v�echny textov� �et�zce, kter� nejsou ani n�zvem objektu ani n�zvem funkce mus� b�t uvozovk�ch.)
# Argument header, dostal od n�s hodnotu T, T a F, pop�. TRUE a FALSE, k�duj� logick� hodnoty v�rokov� logiky v R. N�kter� argumenty funguj� jako p�ep�na�e, kter� hodnotami T nebo F zap�n�me nebo vyp�n�me.
# Konkr�tn�, jak u� jeho n�zev nazna�uje, argument header ��k� dan� funkci, �e v dan�m souboru je p��tomna na prvn� ��dce hlavi�ka obsahuj�c� n�zvy prom�nn�ch.
# Pokud nespecifikujeme jinak, v�echny prom�nn� obsahuj�c� textov� �et�zce (t.j. ty, kter� obsahuj� cokoliv jin�ho ne� ��sla a chyb�j�c� hodnoty) jsou automaticky p�evedeny na faktory.

#vysledkem funkce read.table je vzdy objekt typu data.frame, tj. soubor ("list") promennych (ty mohou byt ruznych typu, napr. numeric, factor, character, atd.) o stejne delce

class(spergula) #zjistit jakeho typu je nejaky objekt

spergula
head(spergula) # Touto funkc� (zobrazi prvnich pet radek datove matice) si m��eme zkontrolovat, jak se n�m data nahr�la.
nrow(spergula) # Kolik datov� matice obsahuje pozorov�n�.
names(spergula) # Zjist�me, jak� prom�nn� se v datov� matici nach�zej�.
names(spergula)[1]<-"kod" # T�mto zp�sobem se p�ejmenov�v� prom�nn�
names(spergula)[1]<-"cela" # T�mto zp�sobem se p�ejmenov�v� prom�nn�
dim(spergula)


## Vyvol�n� konkr�tn�ho prom�nn� (vektoru) z datov� matice (data.frame)

# K tomuto ��elu slou�� tzv. dolarov� konvence, pokud n�jak� objekt obsahuje pojmenovan� seznam sv�ch podpolo�ek, pak konkr�tn� polo�ku vol�m objekt$polo�ka.
spergula$cela
length(spergula$cela) #delka datoveho vektoru (slozky objektu - data.frame "spergula")

# Z takto zavolanou prom�nnou m��eme d�le pracovat, nap�. spo��st jej� pr�m�r:
mean(spergula$kvety)

# P�i rozs�hlej�� pr�ci s danou datovou matic� by bylo u��v�n� dolarov� konvence �navn�, a proto se �asto pou��v� tzv. p�ipojen� datov� matice. U p�ipojen� matice m��eme volat prom�nn� p��mo bez jej�ho jm�na a dolaru.
# V takovem pripade je treba dat pozor na to, aby jmeno promenne v datove matici nebylo identicke se jmenem promenne v pracovnim prostoru - to casto vede k chybam
attach(spergula)
mean(cela)


## Aritmetick� operace v R

# R v z�sad� funguje jako plnohodnotn� kalkula�ka, kdy z�kladn� operace jsou �e�eny oper�tory a na slo�it�j�� existuj� funkce
ctyrka+sestka
ctyrka*sestka
sestka/ctyrka
sestka-ctyrka

# To sam� lze prov�d�t i s ��sly a kombinacemi ��sel a objekt�, pokud prov�d�me aritmetickou operaci na jedn� stran� s vektorem a na druh� stran� s jedn�m ��slem (skal�rem), R provede danou operaci se v�emi prvky vektoru
13*6
sestka/5
rada*3

# Mocniny a odmocniny se tvo�� podle stejn�ho usu jako v Excelu - odmocniny jsou vyj�d�eny zlomkem - pov�imn�te si nutnosti z�vorky z d�vodu p�ednosti jednotliv�ch operac� (stejn� jako v matematice - jsou tu ale n�kter� nadstavby, jako nap�. �e obsah podm�nek se vyhodnot� p�ed prov�d�n�m matematick�ch operac� vn� jich)
3^2
3^(1/4)
3^(1/3)

# U�ite�n� jsou funkce sqrt() - odmocnina, log() - p�irozen� logaritmus, exp() - exponenciela
sqrt(rada)
log(cela)
exp(2)
log(5)

## Kdy� bychom cht�li spo��tat jin� logaritmus  ne� p�irozen�, mus�me se pod�vat do n�pov�dy, jak se jmenuje argument funkce log, kter� n�m zm�n� jej� z�klad.
?log # T�mto vyvol�me n�pov�du k funkci log, tato funkce, pop�. jej� ekvivalent help(log), pot�ebuje zn�t p�esn� n�zev funkce, na ni� se pt�me.
??logarithm # Pokud bychom neznali p�esn� n�zev funkce, nech�me hledat anglick� v�raz pro logaritmus a z nab�dky funkc�, kter� toto slovo obsahuj� si vybereme tu, kterou pot�ebujeme. V p��pad� v�ceslovn�ch pojm� mus�me hled�n� zadat p�vodn� funkc� help.search("logarithm").



#Pripadne muzeme pridat novou promennou do datoveho souboru

spergula[5] = log(spergula$cela) #nicmene tato promenna bude dostupna jen jako spergula$logcela. K jejimu zpristupneni bez dolaroveho odkazu je treba pripojit ("attach") soubor spergula znovu
names(spergula)[5] = "logcela"

## P�ehled pracovn�ho prostoru, t.j. seznamu objekt�, je� jsme vytvo�ili, a d�l�n� po��dku v n�m

ls() # Seznam vytvo�en�ch objekt�
rm(sestka2) # Maz�n� objekt�
ls()  


## Exploratorn� analysa - Z�kladn� popis prom�nn�ch

attach(spergula)

# N�stroje k charakterisaci prom�nn�
hist(cela)
hist(cela,breaks=40) # Pov�imn�te si, �e podoba histogramu se v�razn� zm�n� s po�tem sloupc�, na n� ho d�l�me
mean(cela)
median(cela)
mean(logcela)
median(logcela)
quantile(cela)
quantile(cela,probs=seq(0,1,by=0.1)) # Funkce seq m� v�ce pou�it� (vizte n�pov�du), ale v na�em pou�it� vygeneruje aritmetickou posloupnost ��sel, prvn� dva argumenty ur�uj� jej� koncov� a po��te�n� bod a argument by ur�uje krok mezi jednotliv�mi ��sly
sd(cela)
var(cela)
summary(cela)

summary(spergula) # Pou�it� t�to funkce n�m v�razn� zjednodu�uje �ivot a je dobr�m zvykem podobn� p��kaz zavolat po nahr�n� jak�koliv nov� datov� matice
# V�imn�te si, �e funkce summary prov�d� jin� operace podle toho, jak� je t��da dan�ho vektoru. (rika se tomu genericka funkce. V R-ku je jich spousta - treba taky funkce plot)


# Podv�b�ry z datov�ch matic - tzv. subskripty (u datov�ch matic ve form�tu objekt[��dky,sloupce])

# Subskripty maj� v�dy tolik rozm�r�, kolik m� objekt, z n�ho� vyb�r�me, t.j. vektory 1 (d�lku), datov� matice 2 (��dky, sloupce - v tomto po�ad�).
# Subskript m��e obsahovat: 1) v��et prvk�, kter� se maj� vybrat (indexy ��dek/sloupc�, nebo jmenn�m seznamem - v �vozovk�ch a funkci c()); 2) podm�nku, kdy jsou zobrazeny jen ty ��dky/sloupce, kter� ji spl�uj�; 3) negativn� v��et, t.j. kter� ��dky/sloupce maj� b�t z celku vylou�eny
spergula[,2]
spergula[,2:4]
spergula[1:10,c(1,3)]
spergula[spergula$cela>5,]
spergula[spergula$horni>5,]
spergula[1:10,-1] # zobrazi vsechny sloupce bez sloupce 1 
spergula[1:10,-c(1,3)] # zobrazi vsechny sloupce bez sloupce 1 a 3


# V�po�et korela�n� matice
cor(spergula)


# P�epo�et korela�n�ho koeficientu na koeficient determinace, t.j. vysv�tlenou variabilitu
cor(spergula)^2




## Jak pracovat s faktory?

# U faktoru nem�me ��dn� vlastnosti analogick� pr�m�ru apod. Zaj�m� n�s ale po�et hladin faktoru a jejich �etnost

# vytvorim faktor druh
spergula[5]<-data.frame(druh=rep(c("A","B","C"),c(10,10,18)))

detach(spergula)
attach(spergula)

levels(druh)
table(druh)

spergula$druh2<-spergula$druh # Slu�ov�n� hladin faktoru je nevratn� krok, proto si nejprve vytvo��me kopii v r�mci stejn� datov� matice.
levels(spergula$druh2)<- c("A", "A", "B")
levels(spergula$druh2)





