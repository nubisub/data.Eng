# Praktikum - Count Word

javac -classpath /usr/hdp/3.0.1.0-187/hadoop/hadoop-common-3.1.1.3.0.1.0-187.jar:/usr/hdp/3.0.1.0-187/hadoop-mapreduce/hadoop-mapreduce-client-core-3.1.1.3.0.1.0-187.jar:/usr/hdp/3.0.1.0-187/hadoop-mapreduce/hadoop-mapreduce-client-common-3.1.1.3.0.1.0-187.jar WordCount.java

vi WordCount.java

jar -cvf wordcount.jar *.class

hdfs dfs -mkdir input/

hdfs dfs -copyFromLocal booth.txt input/

hadoop jar wordcount.jar WordCount input/booth.txt output

hdfs dfs -cat output/part-00000


# Penugasan - Maximum Salary

javac -classpath /usr/hdp/3.0.1.0-187/hadoop/hadoop-common-3.1.1.3.0.1.0-187.jar:/usr/hdp/3.0.1.0-187/hadoop-mapreduce/hadoop-mapreduce-client-core-3.1.1.3.0.1.0-187.jar:/usr/hdp/3.0.1.0-187/hadoop-mapreduce/hadoop-mapreduce-client-common-3.1.1.3.0.1.0-187.jar MaxSalary.java

jar -cvf maxsalary.jar *.class

hdfs dfs -copyFromLocal salaryinfo.txt input/

hadoop jar maxsalary.jar MaxSalary input/salaryinfo.txt output

hdfs dfs -cat output/part-00000