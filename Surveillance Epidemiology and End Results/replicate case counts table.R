# analyze survey data for free (http://asdfree.com) with the r language
# surveillance epidemiology and end results
# 1973 through 2011

# # # # # # # # # # # # # # # # #
# # block of code to run this # #
# # # # # # # # # # # # # # # # #
# library(downloader)
# source_url( "https://raw.githubusercontent.com/ajdamico/asdfree/master/Surveillance%20Epidemiology%20and%20End%20Results/replicate%20case%20counts%20table.R" , prompt = FALSE , echo = TRUE )
# # # # # # # # # # # # # # #
# # end of auto-run block # #
# # # # # # # # # # # # # # #

# contact me directly for free help or for paid consulting work

# anthony joseph damico
# ajdamico@gmail.com


###################################################
# replicate nci-seer case counts pdf with monetdb #
###################################################


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#########################################################################################################################################################
# prior to running this replication script, the seer text files must be loaded into monetdb and stacked into a table called `x` in that database.       #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# https://raw.githubusercontent.com/ajdamico/asdfree/master/Surveillance%20Epidemiology%20and%20End%20Results/import%20individual-level%20tables%20into%20monetdb.R  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# that script will create a 'MonetDB' directory in C:/My Directory/SEER (or wherever the current working directory had been set) that will be accessed. #
#########################################################################################################################################################
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


library(DBI)			# load the DBI package (implements the R-database coding)
library(MonetDB.R)		# load the MonetDB.R package (connects r to a monet database)
library(MonetDBLite)	# load MonetDBLite package (creates database files in R)


# uncomment this line by removing the `#` at the front..
# setwd( "C:/My Directory/SEER/" )
# ..in order to set your current working directory


# name the database files in the "MonetDB" folder of the current working directory
dbfolder <- paste0( getwd() , "/MonetDB" )


# open the connection to the monetdblite database
db <- dbConnect( MonetDBLite() , dbfolder )


# # # # # # # # # # # # #
# analysis start point  #

# look at all available tables in monetdb
dbListTables( db )


# look at all available columns in the `x` table in monetdb
dbListFields( db , 'x' )
# dbListFields is just like the names() function, but for database-stored tables


# precisely match the record counts table available on the nci-seer website
# http://seer.cancer.gov/manuals/TextData.cd1973-2011counts.pdf
dbGetQuery( db , 'select tablename , count(*) from x group by tablename' )

# note that 
# 'select tablename , count(*) from x group by tablename'
# in the above `dbGetQuery` function is just a sql command.
# if you don't know sql, you should beeline to the nearest sql tutorial website
# and get learnin' because it's terribly powerful and blazingly fast
# w3schools has a good intro.  http://www.w3schools.com/sql/default.asp


# instead of printing results to the screen, you might want to
# store everything into a new `counts.by.table` object..
counts.by.table <- dbGetQuery( db , 'select tablename , count(*) from x group by tablename' )
# ..which is a data.frame object
class( counts.by.table )


# that you can print..
counts.by.table

# or save as an r object
# save( counts.by.table , file = "C:/My Directory/counts by table.rda" )

# or export to a comma separated value (.csv) file
# write.csv( counts.by.table , file = "C:/My Directory/counts by table.csv" )

# ..or really do just about whatever you like with.  hey, it's just another table
# maybe check out http://twotorials.com/ to see what other
# exciting things you can do with data.frame objects in the r language


# analysis end point  #
# # # # # # # # # # # #

# disconnect from the current monet database
dbDisconnect( db , shutdown = TRUE )

