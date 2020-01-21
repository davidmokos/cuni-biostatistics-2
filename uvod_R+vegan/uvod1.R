
## Základy zacházení s R (autor velke casti Zdenek Janovsky)

## Základní poznámky k fungování jazyka R

# R je tzv. objektovì orientovaný jazyk, t.j. má objekty obsahující nìjaká data
# a funkce, které s objekty pracují. Podstatnou vlastností objektù a tím, co z R
# èiní objektovì orientovaný jazyk pak je, že objekty patøí do rùzných tøíd
# (object classes), které napomáhají funkcím s nimi správnì pracovat.


## Typy objektù

# Bìhem analysy dat se budeme zpoèátku setkávat se dvìma typy objektù: 
# 1) vektory (vector - není tøídou objektu ve smyslu výše popsaném - viz níže) 
# a 2) datovými maticemi (data.frame - pøedstavuje samostatnou tøídu). Vektor
# pøedstavuje øadu nìjakých prvkù stejného typu, nejèastìji èísel (viz níže),
# která mohou pøedstavovat nìjakou promìnnou. Datová matice pak pøedstavuje více
# takovýchto stejnì dlouhých vektorù svázaných do matice.


## Typy promìnných - tøídy vektorù

# Samostatné vektory, tak i vektory v rámci datové matice mají svoji tøídu podle typu dat, která obsahují.

# Numeric - pøedstavuje základní tøídu pro práci s èísly, mùže obsahovat jakákoliv èísla a chybìjící hodnoty (NA); nìkteré funkce pracují s tøídou integer, která obsahuje pouze celá èísla, pro naše potøeby se však tyto tøídy chovají stejnì.
# Character - tato tøída nijak blíže nespecfikuje obsah jednotlivých prvkù a zachází s nimi jako s textem (i když tam jsou èísla), tuto tøídu nebudeme pøíliš aktivnì využívat, setkáme se s ní pouze pøi redukci hladin faktorù (viz níže) a narazili byste nìkdy na ni, pokud byste dostali špatnì zakódované èíselné promìnné, které byste potøebovali pøevést na èísla.
# Factor - je pro statistické analysy nejužiteènìjší tøídou pro práci s kategoriálními promìnnými (napø. barva oèí - zelená/modrá/hnìdá). Narozdíl od textu (character) rozeznává jednotlivé hladiny, t.j. všechny hodnoty "modrá" jsou považovány za stejnou hodnotu. Pojmenování tìchto hladin je arbitrární a lze ho mìnit (ukážeme si), protože jednotlivé hladiny faktoru jsou ve skuteènosti zakódovány èíslem (pozdìji využijeme pøi kreslení grafù).

# Užiteèné pro pøevádìní mezi tìmito tøídami vektorù jsou funkce "as.", t.j. as.factor, as.numeric, as.character atd. My je sice obvykle používat nebudeme, protože budeme pøevážnì používat již vyèištìné datové soubory, ale v praxi je budete potøebovat pravidelnì.


## Vytváøení objektù - pojmenovávací konvence

# R vychází z logiky unixových programù, což konkrétnì z hlediska pojmenovávání
# znamená, že se rozlišují malá a velká písmena v názvu objektu "Data" se
# nerovná "data". Názvy rovnìž nesmí obsahovat vyhrazené znaky operátorù -
# konkrétnì pøedevším: !,=,<,>,*,/,|,",?,(,),[,],{,},@,$. Názvy objektù sice smí
# obsahovat èíslo, ale nesmí jím zaèínat. Volba názvu objektu by mìla sledovat
# dva cíle - název by nemìl by pøíliš dlouhý, protože objekty budeme èasto a
# opakovanì volat; název by ovšem mìl být dostateènì výstižný, abychom i za
# týden poznali, co daný objekt obsahuje. Názvy objektù v rámci jedné analysy
# (t.j. pracovního prostoru, viz níže) musí být unikátní. Dùraznì nedoporuèuji
# používat pro promìnné delšího trvání názvy na jedno písmeno, popø. názvy
# kryjící se s názvem nìjaké funkce (napø. sum). Zatímco v prvním pøípadì danou
# promìnnou nedokážete zpìtnì najít ve skriptu (zkuste hledat tøeba "i") ve
# druhém pøípadì bude kromì tohoto i èelit problému, že Vám nepùjde pøímoèaøe
# zavolat daná funkce. R sice od jisté doby už ovládá písmenka s diakritikou,
# spíše bych Vás pøed nimi varoval, protože ne všechny funkce s nimi mohou
# pracovat dobøe, i když ve versi 3.0 a vyšší vypadají, že už možná pracují
# dobøe všude.


## Vytváøení objektù - pøiøazovací operátory

# R rozeznává dva typy základní pøiøazovací operátory, které jsou ale zámìnné:
# "<-" Pøiøazovací operátor šipka pøiøazuje objektu nalevo od sebe objekt, funkci nebo data napravo od sebe (pøípadnì funguje operátor i v opaèné podobì, ale s tím se normálnì nesetkáte). 
# Operátor "=" (pozor pouze jedno, narozdíl od operátoru "==") provádí stejnou operaci jako operátor šipka (v základní versi)
# Existuje však pomìrnì široký usus, že operátor "<-" se používá pro pøiøazování obsahu objektùm, zatímco operátor "=" se používá pro pøiøazování hodnot argumentùm v rámci funkce.

## Praktická zkouška tvorby objektù:

sestka<-6
ctyrka<-4

# Obsah objektù se vyvolá napsáním jména
sestka
ctyrka

# Když chci vytvoøit vektor o více než jednom prvku, musím prvky vektoru uzavøít do vektorové funkce c()
rada<-c(1,2,3,4,5,6)
rada

# Objektu mohu pøiøadit i jiný objekt
sestka2<-sestka
sestka2
sestka


## Nahrávání datových matic - pracovní adresáøe

# R pøi každém spuštìní používá nìjaký adresáø jako pracovní (defaultnì svùj vlastní). Pokud chceme do nìho nahrávat nìjaké soubory nebo je naopak chceme z R exportovat, nejjednodušší je to pøes tento pracovní adresáø.
# Rovnìž je užiteèná zásada, co analysa (nebo v našem pøípadì co praktikum) to jeden adresáø. Do nìho si nakopírujeme všechny vstupní soubory a do nìho si potom exportujeme všechny výstupy.
# Pracovní složka se nastavuje v Menu>File>Change dir... pøípadnì funkcí set.wd()
# Datové matice typicky nezadáváme do R pomocí klávesnice èi pomocí vestavìného editoru (viz níže), nýbrž pomocí nìkteré funkce, naèítající soubory z pracovního adresáøe (všechny zaèínají na read.).

# Nahrávání datových matic v RStudiu
# Pracovní složka se nastavuje v záložce Session>Set working directory.
# Datovou matici lze importovat pøes nabídku Import Dataset v oknì Environment.


## Anatomie funkcí

# Funkce se od objektù rozeznají tak, že za jejich jménem vždy následují kulaté závorky uzavírající argumenty funkce (jsou-li nìjaké, nìkteré funkce nemají argumenty, viz níže)
# Argumenty funkcí jsou mezi sebou vždy oddìleny ",". (R používá desetinnou teèku, kterou je vhodné si i nastavit jako oddìlovaè desetinných míst v Excelu).
# Každý argument ve funkci má svùj název, který lze zjistit v nápovìdì, pokud uvádíme argumenty v poøadí, v jakém jsou uvedeny ve funkci, nemusíme používat jejich název a staèí je oddìlovat, v opaèném pøípadì (nebo tøeba když nìkteré argumenty nevyplòujeme) musíme vždy napsat jméno argumentu a pøiøadit mu hodnotu.
# Pøíkaz pak vypadá nìjak takto: objekt<-funkce(arg1=hodnota1,arg2=hodnota2)

#Zakladni poucka pri zachazeni s funkcemi zni: (i) koukej se na helpy. Druha zakaldni poucka zni (ii) hledej kdes to udelal driv a jak to fungovalo
#Pokud nevime, jaka funkce kona to, co clovek potrebuje, lze obvykle snadno vyhledat vyhledavacem na netu, nebo v prostredi R


## Vlastní nahrání datové matice

# Nejèastìji používaným formátem souboru pro import dat do R je textový dokument s buòkami oddìlenými tabulátory (popø. èárkami, zejména v americkém prostøedí).
# Takové soubory se nejlépe naèítají funkci read.table s pøíslušnými argumenty.

spergula<-read.table("spergula.txt",header=T)
# První argument je název souboru - všimnìte si, že je v úvozovkách - všechny textové øetìzce, které nejsou ani názvem objektu ani názvem funkce musí být uvozovkách.)
# Argument header, dostal od nás hodnotu T, T a F, popø. TRUE a FALSE, kódují logické hodnoty výrokové logiky v R. Nìkteré argumenty fungují jako pøepínaèe, které hodnotami T nebo F zapínáme nebo vypínáme.
# Konkrétnì, jak už jeho název naznaèuje, argument header øíká dané funkci, že v daném souboru je pøítomna na první øádce hlavièka obsahující názvy promìnných.
# Pokud nespecifikujeme jinak, všechny promìnné obsahující textové øetìzce (t.j. ty, které obsahují cokoliv jiného než èísla a chybìjící hodnoty) jsou automaticky pøevedeny na faktory.

#vysledkem funkce read.table je vzdy objekt typu data.frame, tj. soubor ("list") promennych (ty mohou byt ruznych typu, napr. numeric, factor, character, atd.) o stejne delce

class(spergula) #zjistit jakeho typu je nejaky objekt

spergula
head(spergula) # Touto funkcí (zobrazi prvnich pet radek datove matice) si mùžeme zkontrolovat, jak se nám data nahrála.
nrow(spergula) # Kolik datová matice obsahuje pozorování.
names(spergula) # Zjistíme, jaké promìnné se v datové matici nacházejí.
names(spergula)[1]<-"kod" # Tímto zpùsobem se pøejmenovává promìnná
names(spergula)[1]<-"cela" # Tímto zpùsobem se pøejmenovává promìnná
dim(spergula)


## Vyvolání konkrétního promìnné (vektoru) z datové matice (data.frame)

# K tomuto úèelu slouží tzv. dolarová konvence, pokud nìjaký objekt obsahuje pojmenovaný seznam svých podpoložek, pak konkrétní položku volám objekt$položka.
spergula$cela
length(spergula$cela) #delka datoveho vektoru (slozky objektu - data.frame "spergula")

# Z takto zavolanou promìnnou mùžeme dále pracovat, napø. spoèíst její prùmìr:
mean(spergula$kvety)

# Pøi rozsáhlejší práci s danou datovou maticí by bylo užívání dolarové konvence únavné, a proto se èasto používá tzv. pøipojení datové matice. U pøipojené matice mùžeme volat promìnné pøímo bez jejího jména a dolaru.
# V takovem pripade je treba dat pozor na to, aby jmeno promenne v datove matici nebylo identicke se jmenem promenne v pracovnim prostoru - to casto vede k chybam
attach(spergula)
mean(cela)


## Aritmetické operace v R

# R v zásadì funguje jako plnohodnotná kalkulaèka, kdy základní operace jsou øešeny operátory a na složitìjší existují funkce
ctyrka+sestka
ctyrka*sestka
sestka/ctyrka
sestka-ctyrka

# To samé lze provádìt i s èísly a kombinacemi èísel a objektù, pokud provádíme aritmetickou operaci na jedné stranì s vektorem a na druhé stranì s jedním èíslem (skalárem), R provede danou operaci se všemi prvky vektoru
13*6
sestka/5
rada*3

# Mocniny a odmocniny se tvoøí podle stejného usu jako v Excelu - odmocniny jsou vyjádøeny zlomkem - povšimnìte si nutnosti závorky z dùvodu pøednosti jednotlivých operací (stejná jako v matematice - jsou tu ale nìkteré nadstavby, jako napø. že obsah podmínek se vyhodnotí pøed provádìním matematických operací vnì jich)
3^2
3^(1/4)
3^(1/3)

# Užiteèné jsou funkce sqrt() - odmocnina, log() - pøirozený logaritmus, exp() - exponenciela
sqrt(rada)
log(cela)
exp(2)
log(5)

## Když bychom chtìli spoèítat jiný logaritmus  než pøirozený, musíme se podívat do nápovìdy, jak se jmenuje argument funkce log, který nám zmìní její základ.
?log # Tímto vyvoláme nápovìdu k funkci log, tato funkce, popø. její ekvivalent help(log), potøebuje znát pøesný název funkce, na niž se ptáme.
??logarithm # Pokud bychom neznali pøesný název funkce, necháme hledat anglický výraz pro logaritmus a z nabídky funkcí, které toto slovo obsahují si vybereme tu, kterou potøebujeme. V pøípadì víceslovných pojmù musíme hledání zadat pùvodní funkcí help.search("logarithm").



#Pripadne muzeme pridat novou promennou do datoveho souboru

spergula[5] = log(spergula$cela) #nicmene tato promenna bude dostupna jen jako spergula$logcela. K jejimu zpristupneni bez dolaroveho odkazu je treba pripojit ("attach") soubor spergula znovu
names(spergula)[5] = "logcela"

## Pøehled pracovního prostoru, t.j. seznamu objektù, jež jsme vytvoøili, a dìlání poøádku v nìm

ls() # Seznam vytvoøených objektù
rm(sestka2) # Mazání objektù
ls()  


## Exploratorní analysa - Základní popis promìnných

attach(spergula)

# Nástroje k charakterisaci promìnné
hist(cela)
hist(cela,breaks=40) # Povšimnìte si, že podoba histogramu se výraznì zmìní s poètem sloupcù, na nìž ho dìlíme
mean(cela)
median(cela)
mean(logcela)
median(logcela)
quantile(cela)
quantile(cela,probs=seq(0,1,by=0.1)) # Funkce seq má více použití (vizte nápovìdu), ale v našem použití vygeneruje aritmetickou posloupnost èísel, první dva argumenty urèují její koncový a poèáteèní bod a argument by urèuje krok mezi jednotlivými èísly
sd(cela)
var(cela)
summary(cela)

summary(spergula) # Použití této funkce nám výraznì zjednodušuje život a je dobrým zvykem podobný pøíkaz zavolat po nahrání jakékoliv nové datové matice
# Všimnìte si, že funkce summary provádí jiné operace podle toho, jaká je tøída daného vektoru. (rika se tomu genericka funkce. V R-ku je jich spousta - treba taky funkce plot)


# Podvýbìry z datových matic - tzv. subskripty (u datových matic ve formátu objekt[øádky,sloupce])

# Subskripty mají vždy tolik rozmìrù, kolik má objekt, z nìhož vybíráme, t.j. vektory 1 (délku), datové matice 2 (øádky, sloupce - v tomto poøadí).
# Subskript mùže obsahovat: 1) výèet prvkù, které se mají vybrat (indexy øádek/sloupcù, nebo jmenným seznamem - v úvozovkách a funkci c()); 2) podmínku, kdy jsou zobrazeny jen ty øádky/sloupce, které ji splòují; 3) negativní výèet, t.j. které øádky/sloupce mají být z celku vylouèeny
spergula[,2]
spergula[,2:4]
spergula[1:10,c(1,3)]
spergula[spergula$cela>5,]
spergula[spergula$horni>5,]
spergula[1:10,-1] # zobrazi vsechny sloupce bez sloupce 1 
spergula[1:10,-c(1,3)] # zobrazi vsechny sloupce bez sloupce 1 a 3


# Výpoèet korelaèní matice
cor(spergula)


# Pøepoèet korelaèního koeficientu na koeficient determinace, t.j. vysvìtlenou variabilitu
cor(spergula)^2




## Jak pracovat s faktory?

# U faktoru nemáme žádné vlastnosti analogické prùmìru apod. Zajímá nás ale poèet hladin faktoru a jejich èetnost

# vytvorim faktor druh
spergula[5]<-data.frame(druh=rep(c("A","B","C"),c(10,10,18)))

detach(spergula)
attach(spergula)

levels(druh)
table(druh)

spergula$druh2<-spergula$druh # Sluèování hladin faktoru je nevratný krok, proto si nejprve vytvoøíme kopii v rámci stejné datové matice.
levels(spergula$druh2)<- c("A", "A", "B")
levels(spergula$druh2)





