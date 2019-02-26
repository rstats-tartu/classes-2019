
library(readr)
library(stringr)

tumor_viruses <- read_csv("Tuumorviirus, Viirusperekond,  Genoomi suurus (kb)\n
B-hepatiidi viirus (HBV),hepadna,3\n
Merkeli rakkude polüoomi viirus (MCPyV), polyomaviridae, 5\n
inimese papilloomiviirus 16 (HPV),papova,8\n
inimese adenoviirus 5,adenoviirus,35\n
inimese herpesviirus 8 (HSV-8; KSHV),herpesviirused,165\n
Shope fibroomiviirus,poxviirused,160\n
Rousi sarkoomiviirus (RSV),retroviirused,9\n
inimese T-raku leukeemia viirus (HTLV-I),retroviirus,9")
tumor_viruses


viruses <- mutate_if(viruses, is.character, str_to_lower) 
hbv <- viruses %>% 
  filter(str_detect(organism_name, "hepatitis b"), str_detect(host, "human"))

merkel <- viruses %>% 
  filter(str_detect(organism_name, "merkel"), str_detect(host, "human"))

hpv16 <- viruses %>% 
  filter(str_detect(organism_name, "papilloma.+16"), str_detect(host, "human"))

hadv <- viruses %>% 
  filter(str_detect(organism_name, "adenov.+ 5$"), str_detect(host, "human")) %>% 
  select(organism_name)
