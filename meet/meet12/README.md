# Meet 12 - Spark

1. Spark Shell

   ```bash
   spark-shell
   ```

   ```bash
   spark.version
   ```

2. Spark (SparkSession) and SparkContext

   ```scala
   spark
   ```

   ```scala
   sc
   ```

3. Cek current spark session

   ```scala
   import org.apache.spark.sql.SparkSession
   ```

   ```scala
   val spark2 = SparkSession.builder().getOrCreate()
   ```

   ```scala
   print(spark2)
   ```

4. Create RDD

   - Import

     ```scala
     import org.apache.spark.sql.SparkSession
     ```

   - Input denga seq

     ```scala
     val dataSeq = Seq(("Java", 20000), ("Python", 100000), ("Scala", 3000))
     ```

     ```scala
     val rdd = spark.sparkContext.parallelize(dataSeq)
     ```

   - Read dataSeq

     ```scala
     val data = rdd.collect()
     ```

     ```
     data.foreach(println)
     ```

     ```
     data.foreach(f => println(f._1)+" "+println(f._2))
     ```

5. RDD Operation (Transformation)

   ```scala
   val filter = dataSeq.filter(a => a._1.startsWith("J"))
   ```

   ```scala
   val filter = dataSeq.filter(a => a._1.startsWith("P"))
   ```

   ```scala
   val filter = dataSeq.filter(a => a._1.contains("P"))
   ```

   ```scala
   val filter = dataSeq.filter(a => a._1.contains("a"))
   ```

   ```scala
   val filter = dataSeq.filter(a => a._1.matches("a"))
   ```

   ```scala
   val filter = dataSeq.filter(a => a._1.matches(".*a.*"))
   ```

   ```scala
   val filter = dataSeq.filter(a => a._1.length > 5)
   ```

   ```scala
   val filter = dataSeq.filter(a => a._2 > 3000)
   ```

   ```scala
   val sort = dataSeq.sortBy(a => a._2)
   ```

6. Create Dataframe

   - Buat schema

     ```scala
     val columns = Seq("programming_language", "total_user")
     ```

     ```scala
     val df  spark.createDataFrame(dataSeq).toDF(columns:_*)
     ```

   - Menampilkan

     ```scala
     df.show()
     ```

     ```scala
     df.printSchema()
     ```

7. Dataframe Operation

   ```scala
   df.select("programming_language").show()
   ```

   ```scala
   val df2 = df.withColumn("total_user", df("total_user") + 100)
   df2.show()
   ```

   ```scala
   df.groupBy("programming_language").count.show()
   ```

8. Save to table

   - Akses data yang sudah tersimpan

     ```scala
     val data_hdfs = spark.read.csv("/user/superdms/UserLatihan/Import2/")
     ```

   - Membuat schema

     ```scala
     data_hdfs.show()
     ```

   - Simpan ke table

     ```scala
     data_hdfs.createOrReplaceTempView("sample_table")
     ```

     ```scala
     val data_hdfs2 = spark.sql("select * from sample_table")
     ```

     ```scala
     data_hdfs2.show()
     ```

     ```scala
     val salary_more_than_5000 = spark.sql("select * from sample_table where salary > 5000")
     ```

     ```scala
     salary_more_than_5000.show()
     ```

     ```scala
     spark.table("sample_table").write.saveAsTable("sample_hive_table")
     ```

     ```scala
     val read_salary2 = spark.sql("SELECT * FROM sample_hive_table")
     ```

     ```scala
     read_salary2.show()
     ```

9. Simpan ke format data lain (orc)

   ```scala
   salary_more_than_5000.write.orc.save("/user/superdms/UserLatihan/salary_more_than_5000/")
   ```

   ```scala
   salary_more_than_5000.write().format("orc").save("/user/root/salary_more_than_5000/")
   ```

   ````scala

   ```scala
   val read_salary_orc = spark.read.orc("/user/superdms/UserLatihan/salary_more_than_5000/")
   ````

   ```scala
   read_salary_orc.show()
   ```

## Penugasan

1. Lakukan input data dalam bentuk RDD.

   ```scala
   val tpd12_rdd = Seq(("James","","Smith","1991-04-01","M",3000),("Michael","Rose","","2000-05-19","M",4000),("Robert","","Williams","1978-09-05","M",4000),("Maria","Anne","Jones","1967-12-01","F",4000),("Jen","Mary","Brown","1980-02-17","F",10000))
   tpd12_rdd.foreach(println)
   ```

2. Mapping dengan skema yang telah disiapkan dan simpan dalam bentuk dataframe.

   ```scala
   val tpd12_col = Seq("firstname","middlename","lastname","dob","gender","salary")
   val tpd12_df = spark.createDataFrame(tpd12_rdd).toDF(tpd12_col:_*)
   tpd12_df.show()
   tpd12_df.printSchema()
   ```

3. Lakukan operasi terhadap dataframe yaitu:

   - Filter record dengan tahun lahir < 2000

     ```scala
     tpd12_df.filter(substring($"dob",0,4) < 2000).show()
     ```

   - Group by Gender

     ```scala
     tpd12_df.groupBy("gender").count().show()
     tpd12_df.filter($"gender"==="F").show()
     tpd12_df.filter($"gender"==="M").show()
     ```

   - Bentuk kolom baru yang berisi gabungan antara first name, middle name, dan last name

     ```scala
     val tpd12_new = tpd12_df.withColumn("fullname",concat($"firstname",lit(" "),$"middlename",lit(" "),$"lastname"))
     tpd12_new.show()
     val tpd12_hive = tpd12_new.select($"fullname",$"dob",$"gender",$"salary")
     tpd12_hive.show()
     ```

4. Penggunaan SQL spark

   - Simpan kolom baru yang berisi gabungan antara first name, middle name, dan last name, dob, gender, dan salary ke dalam tabel hive.

     ```scala
     tpd12_hive.createOrReplaceTempView("tpd12_internal")
     val tpd12_internal = spark.sql("SELECT * FROM tpd12_internal")
     tpd12_internal.show()
     spark.table("tpd12_internal").write.saveAsTable("tpd12_external")
     val tpd12_external = spark.sql("SELECT * FROM tpd12_external")
     ```

   - Lakukan transformasi dengan menambah kolom umur yang berisi hasil pengurangan tahun 2023 dengan tahun lahir

     ```scala
     val tpd12_transform = spark.sql("SELECT *, int(2023-substring(dob,0,4)) as age FROM tpd12_external")
     tpd12_transform.show()
     ```

   - Tampilkan hasil transformasi

     ```scala
     tpd12_external.show()
     ```

5. Simpan hasil transformasi pada nomor 4 dalam format orc di hdfs

   ```scala
   tpd12_transform.write.orc("/user/root/tpd12/transform_result/")
   val tpd12_read_orc = spark.read.orc("/user/root/tpd12/transform_result/")
   tpd12_read_orc.show()
   ```

<hr>

```bash
credit penugasan : ARAM647
```
