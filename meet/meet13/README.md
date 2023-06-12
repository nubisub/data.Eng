# meet13 - Pemrosesan Semi-Structured and Unstructured Data

## Pemrosesan Data Semi-Structured

1. Cek piggypiggybank.jar di HDFS

   ```bash
   ls /usr/hdp/3.0.1.0-187/pig/lib
   ```

2. Upload meter_reading.xml

   ```bash
   echo " <?xml version ="1.0"?>
   <feed>
   <link href = "/v1/espi_third_party_batch_feed" rel="self"></link>
   <title type ="text">Zip Code 93308-6173</title>
   <IntervalReading>
   <cost>1510</cost>
   <timePeriod>
   <duration>900</duration>
   <start>1301889600</start>
   </timePeriod>
   <value>102</value>
   </IntervalReading>
   <IntervalReading>
   <cost>1510</cost>
   <timePeriod>
   <duration>900</duration>
   <start>1301890500</start>
   </timePeriod>
   <value>102</value>
   </IntervalReading>
   </feed>" > meter_reading.xml
   ```

3. Masuk ke pig

   ```bash
   pig -x local
   ```

4. Load Data

   ```bash
   data = LOAD 'meter_reading.xml' USING org.apache.pig.piggybank.storage.XMLLoader('IntervalReading') as (x:chararray);
   ```

   ```bash
   DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
   ```

   ```bash
   data_extract = FOREACH data GENERATE
    (XPath(x, 'IntervalReading/timePeriod/duration')),
    (XPath(x, 'IntervalReading/timePeriod/start')),
    (XPath(x, 'IntervalReading/value')),(XPath(x,
    'IntervalReading/cost'));
   ```

   ```bash
   dump data_extract;
   ```

5. Save Data

   ```bash
   store data_extract into 'user/root/pig' using PigStorage(',');
   ```

   ```bash
   cat user/root/pig/part-m-00000
   ```

##  

1. Upload file bigdata.jpg
2. Masuk ke scala

   ```bash
   spark-shell
   ```

3. Load data

   ```bash
   import org.apache.spark.ml.image.ImageSchema._
   ```

   ```bash
   import java.nio.file.Paths
   ```

4. Read data

   ```bash
   val images = readImages("bigdata.jpg")
   ```

5. Cek data

   ```bash
   images.show()
   ```

6. Cek file

   ```bash
   images.printSchema()
   ```

## Lakukan analisis ekstraksi gambar yang ada seperti

1. Menghitung tinggi dan lebar gambar

   ```scala
   val imageSizes = images.select("image.height", "image.width")
   imageSizes.show()
   ```

2. Melakukan deteksi apakah gambar tersebut berwarna atau tidak

   ```scala
   val imageColor = images.select("image.nChannels")
   imageColor.show()
   ```
