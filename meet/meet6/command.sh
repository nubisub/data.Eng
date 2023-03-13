# COMMAND PRAKTIKUM

su - hdfs

hdfs dfsadmin -report

hdfs dfsadmin -safemode
hdfs dfsadmin -safemode enter
hdfs dfsadmin -safemode leave

hdfs dfsadmin -finalizeUpgrade

hdfs dfsadmin -refreshNodes

hdfs dfsadmin -printTopology

# MENGAMBIL FILE DARI INTERNET

wget https://stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2021-financial-year-provisional/Download-data/annual-enterprise-survey-2021-financial-year-provisional-csv.csv



# PENGECEKAN FILE

ls

hadoop fs -ls

hadoop fs -mkdir praktikum6

hadoop fs -ls

mv annual-enterprise-survey-2021-financial-year-provisional-csv.csv sample-222011647.csv

ls

hadoop fs -copyFromLocal sample-222011647.csv praktikum6/sample-222011647.csv

ls

hadoop fs -ls

hadoop fs -ls praktikum6

hadoop fs -rm praktikum6/sample-222011647.csv

hadoop fs -ls praktikum6

# credit : ARAM647