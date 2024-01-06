BiocManager::install("rWikiPathways")
library(rWikiPathways)
BiocManager::install("RCy3")
library(RCy3)

# Download uchardet package from here: https://cran.r-project.org/src/contrib/Archive/uchardet/uchardet_1.1.1.tar.gz
# Then install it 
install.packages("~/Downloads/uchardet_1.1.1.tar.gz", repos = NULL, type = "source")

cytoscapePing()
cytoscapeVersionInfo()

installApp('WikiPathways')

#### View the help page of RCy3 #### 
help(package=RCy3)
browseVignettes("RCy3")

####
gbm.pathways <- findPathwaysByText('Glioblastoma')

human.filter <- gbm.pathways$species == "Homo sapiens"
human.gbm.pathways <- gbm.pathways[unlist(human.filter)] # just the human BRCA2 pathways

human.gbm.wpids <- unique(human.gbm.pathways$id)
commandsRun(paste0('wikipathways import-as-pathway id=',human.gbm.wpids[1])) 


####### New Session #######
openSession()
net.data <- getTableColumns(columns=c('name','degree.layout','COMMON'))
max.gene <- net.data[which.max(unlist(net.data['degree.layout'])),]
max.gene

TNF.pathways <-findPathwayIdsByXref('ENSG00000232810','En') # TNF
length(TNF.pathways)
commandsRun(paste0('wikipathways import-as-pathway id=', TNF.pathways[1]))
commandsRun(paste0('wikipathways import-as-pathway id=', TNF.pathways[2]))
commandsRun(paste0('wikipathways import-as-pathway id=', TNF.pathways[3]))


# Find out the right systemCode
# Download the file https://github.com/bridgedb/datasources/blob/main/datasources.tsv
# Read the file
x = read.csv("~/Downloads/datasources.tsv", sep = "\t")
for(mi in unique(x$X)){
  mcm1.pathways <-unique(findPathwayIdsByXref('YMR043W', systemCode = mi))
  if(!is.null(mcm1.pathways)){
    print(mi);print(mcm1.pathways)
    break
  }
}
commandsRun(paste0('wikipathways import-as-pathway id=', mcm1.pathways[1]))