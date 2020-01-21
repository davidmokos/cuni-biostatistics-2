#vegan: jak ziskavat informace


library(vegan)

help(vegan)
help("vegan-package")  #viz tez "Index" na konci stranky

vignette("intro-vegan")

browseVignettes("vegan")

vegandocs(doc = c("NEWS", "ONEWS", "ChangeLog", "FAQ-vegan.pdf",
    "intro-vegan.pdf", "diversity-vegan.pdf", "decision-vegan.pdf",
    "partitioning.pdf", "permutations.pdf"))

citation("vegan")



