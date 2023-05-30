# Meet 11 - PIG & KAFKA

## Apache Pig

1. Upload `movies_data.csv`
2. Jalankan Script Pig dengan mode local dengan mekanisme Grunt

   ```bash
   pig -x local
   ```

3. Load data menggunakan PigStorage

   ```bash
   movies = LOAD 'movies_data.csv' USING PigStorage(',') as (id,name,year,rating,duration);
   ```

4. Menampilkan data

   ```bash
   dump movies;
   ```

5. Menampilkan data dengan filter

   ```bash
   movies_greater_than_85 = FILTER movies BY (float)rating > 8.5;
   ```

   ```bash
   dump movies_greater_than_85;
   ```

6. Menyimpan variable ke dalam file

   ```bash
   store movies_greater_than_85 into 'my_movies';
   ```

   ```bash
   cat my_movies/part-m-00000;
   ```

7. Load data dengan mendefinisikan tipe data

   ```bash
   LOAD 'movies_data.csv' USING PigStorage(',') as (id:int,name:chararray,year:int,rating:double,duration:int);
   ```

8. Filter data

   ```bash
   movies_between_9095 = FILTER movies by year > 1990 and year < 1995;
   ```

   ```bash
   movies_starting_with_The = FILTER movies by name matches 'The.*';
   ```

   ```bash
   movies_duration_2hrs = FILTER movies by duration > 7200;
   ```

9. Menampilkan data

   ```bash
   dump movies_between_9095;
   ```

   ```bash
   dump movies_starting_with_The;
   ```

   ```bash
   dump movies_duration_2hrs;
   ```

10. Skema data

    ```bash
    DESCRIBE movies;
    ```

11. Transformasi data

    ```bash
    movie_duration_mnt = FOREACH movies GENERATE name, (double)(duration/60);
    ```

    ```bash
    dump movie_duration_mnt;
    ```

12. Menampilkan data dengan Group By

    ```bash
    grouped_by_year = group movies by year;
    ```

    ```bash
    count_by_year = FOREACH grouped_by_year GENERATE group, COUNT(movies);
    ```

    ```bash
    dump grouped_by_year;
    ```

    ```bash
    dump count_by_year;
    ```

13. Menampilkan data dengan Sort

    ```bash
    desc_movies_by_year = ORDER movies BY year DESC;
    asc_movies_by_year = ORDER movies by year ASC;
    top5_latest_movies = LIMIT desc_movies_by_year 5;
    ```

    ```bash
    dump desc_movies_by_year;
    ```

    ```bash
    dump asc_movies_by_year;
    ```

    ```bash
    dump top5_latest_movies;
    ```

14. Exits

    ```bash
    quit
    ```

    ```bash
    exit
    ```

    ```bash
    ctrl + d
    ```

15. Eksekusi dengan batch mode

    ```bash
    vi script_example.pig
    ```

    ```pig
    movies = LOAD 'movies_data.csv' USING PigStorage(',') as (id,name,year,rating,duration);
    dump movies;
    ```

    ```bash
    pig -x local script_example.pig
    ```

## Apache Kafka

1. Pindah ke direktori kafka

   ```bash
    su kafka
    cd /usr/hdp/3.0.1.0-187/kafka
   ```

2. Buat topic

   ```bash
   bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic tpd_logs
   ```

3. Cek topic

   ```bash
   bin/kafka-topics.sh --list --zookeeper localhost:2181
   ```

4. Lihat detail topic

   ```bash
   bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic tpd_logs
   ```

5. Jalankan producer

   ```bash
   bin/kafka-console-producer.sh --broker-list sandboxhdp.hortonworks.com:6667 --topic tpd_logs
   ```

6. Jalankan consumer

   ```bash
   bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic tpd_logs3 --from-beginning
   ```

7. Pindah dir

   ```bash
   cd /etc/kafka/3.0.1.0-187/0/
   ```

8. Ganti file config

   ```bash
   vi connect-file-source.properties
   ```

   ```text
   name=local-file-source
   connector.class=FileStreamSource
   tasks.max=1
   file=/home/kafka/log_data.txt
   topic=tpd_logs
   ```

   ```bash
   vi connect-standalone.properties
   ```

   ```
   bootstrap.servers=sandbox-hdp.hortonworks.com:6667
   ```

9. Jalankan producer di `/usr/hdp/3.0.1.0-187/kafka`

   ```bash
   bin/connect-standalone.sh config/connectstandalone.properties config/connect-file-source.properties config/connect-file-sink.properties
   ```

10. Jalankan consumer `/usr/hdp/3.0.1.0-187/kafka`

    ```bash
    bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic tpd_logs --from-beginning
    ```

## Penugasan

1. Lakukan pemrosesan data menggunakan Pig script (interactive atau batch) untuk menghitung jumlah tiap kata pada tulisan di bawah ini.

   ```
   Hello students, how are you today?
   I hope you are having a great day.
   Today is a good day to learn Pig Latin.
   Pig Latin is a data flow scripting language used for big data
   processing.
   It is widely used in the Apache Hadoop ecosystem.
   ```

   ```bash
   lines = LOAD 'text_data.txt' AS (line:chararray);
   words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
   grouped = GROUP words BY word ;
   word_count = FOREACH grouped GENERATE group, COUNT(words);
   DUMP word_count;
   ```
