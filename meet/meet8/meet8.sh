# mysql from xampp

# import table
sqoop import --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table emp --target-dir tmp --m 1

# import incremental
sqoop import --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table emp --target-dir tmp --m 1 --incremental append --check-column id --last-value 3

# Export
sqoop export --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table emp2 --export-dir tmp --m 1


# Sqoop Job
sqoop job --create sqoopjob -- import --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table emp --target-dir sqoopjob --m 1

sqoop job --list

sqoop job –-exec sqoopjob

# Command Sqoop lainnya

sqoop list-tables --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P

sqoop eval --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --query "select* from emp2"

sqoop eval --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --query "insert into emp2 values ('5','Novi','10000','IT','Analyst')"





# PENUGASAN

sqoop import --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table employee_sample_data --target-dir penugasan --m 1

sqoop import --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table employee_sample_data --target-dir penugasanincr --m 1 --incremental append --check-column EmployeeID --last-value 3

sqoop export --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --table employee_sample_data_2 --export-dir penugasan --m 1

sqoop eval --connect "jdbc:mysql://10.0.2.2:3306/moduldelapan" --username root -P --query "INSERT INTO employee_sample_data VALUES ('1004','Pamela Beasley','Receptionist','Temp','Sales','Female','NGGA','32','3/5/2022','$212','3%','West Virginia','Virginia','3/3/2023')"

