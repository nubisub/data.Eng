# HBase

## Kelola Data dalam HBase

1. Masuk ke HBase shell

   ```bash
   hbase shell
   ```

   ```bash
   exit
   ```

2. Melakukan perintah umum

   ```bash
   list
   ```

   ```bash
   status
   ```

   ```bash
   whoami
   ```

3. Membuat namespace

   ```bash
   create_namespace 'tpd_ns'
   ```

4. Membuat table

   ```bash
   create 'tpd_ns:employee','personal data','professional data'
   ```

5. Mengapus atau mengubah skema

   ```bash
   disable 'tpd_ns:employee'
   ```

   ```bash
   is_disabled 'tpd_ns:employee'
   ```

   ```bash
   enable 'tpd_ns:employee'
   ```

6. Mengisi Data

   ```bash
   put 'tpd_ns:employee','1','personal data:name','andi'
   put 'tpd_ns:employee','1','personal data:city','jakarta'
   put 'tpd_ns:employee','1','professional data:designation','manager'
   put 'tpd_ns:employee','1','professional data:salary','50000'
   ```

7. Melihat data di table

   ```bash
   scan 'tpd_ns:employee'
   ```

8. Mengisi data dengan skema berbeda

   ```bash
   put 'tpd_ns:employee','2','personal data:name','desi'
   put 'tpd_ns:employee','2','professional data:salary','15000'
   ```

9. Update data

   ```bash
   put 'tpd_ns:employee','1','personal data:city','bandung'
   ```

10. Query data

    ```bash
    get 'tpd_ns:employee','1'
    ```

    ```bash
    get 'tpd_ns:employee','1', {COLUMN => 'professional data:salary'}
    ```

    ```bash
    scan 'tpd_ns:employee',{COLUMN => 'professional data:designation'}
    ```

    ```bash
    scan 'tpd_ns:employee',{COLUMN => ['personal data:name','professional data:designation'],STARTROW=>'1'}
    scan 'tpd_ns:employee',{COLUMN => ['personal data:name','professional data:designation'],STARTROW=>'1',STOPROW=>'2'}
    ```

11. Fiter (kalo di rdbm pake WHERE)

    ```bash
    import org.apache.hadoop.hbase.filter.SingleColumnValueFilter
    import org.apache.hadoop.hbase.filter.CompareFilter
    import org.apache.hadoop.hbase.filter.BinaryComparator
    ```

    ```bash
    scan 'tpd_ns:employee', {FILTER => SingleColumnValueFilter.new(Bytes.toBytes('personal data'), Bytes.toBytes('name'), CompareFilter::CompareOp.valueOf('EQUAL'),BinaryComparator.new(Bytes.toBytes('desi')))}
    ```

    ```bash
    scan 'tpd_ns:employee', {FILTER => "ValueFilter(=,'binaryprefix:andi')"}
    scan 'tpd_ns:employee', {FILTER => "ValueFilter(=,'binaryprefix:15000')"}
    ```

12. Menghapus Data

    ```bash
    delete 'tpd_ns:employee','1','personal data:city',1684079532813
    ```

    ```bash
    deleteall 'tpd_ns:employee','2'
    ```

13. Meta table

    ```bash
    scan 'hbase:meta'
    ```

    ```bash
    scan 'hbase:meta', {FILTER=>"PrefixFilter('tpd_ns:employee')"}
    ```

## Snapshots dalam HBase

1. Membuat snapshot

   ```bash
   snapshot 'tpd_ns:employee', 'pegawaiData-15052023'
   ```

2. Menampilkan semua snapshots

   ```bash
   list_snapshots
   ```

3. Membuat table dari snapshot

   ```bash
   clone_snapshot 'pegawaiData-15052023', 'tpd_ns:new_employee'
   ```

4. Menghapus row

   ```bash
   disable 'tpd_ns:employee'
   restore_snapshot 'pegawaiData-15052023'
   ```

5. Menghapus snapshot

   ```bash
   delete_snapshot 'pegawaiData-15052023'
   ```

## Penugasan

1. Bandingkan performa read/write dengan Hive di praktikum modul sebelumnya, manakah yang relative lebih cepat?
   ||Hive (seconds)|HBase (seconds)|
   |---|---|---|
   |Write `Insert 3 Row`|8.417|0.192|
   |Read `SELECT *`|1.846|0.706|

2. Buat table baru dengan nama `tpd_ns:UserProfiles` dengan 2 column family `details : Location, Name, Age` dan `activity : Last Login, Posts, Followers`

   | Rowkey    | Location    | Name             | Age | Last Login | Posts | Followers |
   | --------- | ----------- | ---------------- | --- | ---------- | ----- | --------- |
   | UserID001 |             | John Smith       | 32  |            | 25    | 500       |
   | UserID002 | New York    | Sarah Johnson    | 28  | 2023-05-12 | 50    | 1000      |
   | UserID003 | Los Angeles | Michael Anderson | 45  | 2023-05-13 | 10    | 250       |

3. Buat Query

   - Query

     ```bash
     create 'tpd_ns:UserProfiles','details','activity'
     put 'tpd_ns:UserProfiles','1','details:location',''
     put 'tpd_ns:UserProfiles','1','details:name','john smith'
     put 'tpd_ns:UserProfiles','1','details:age','32'
     put 'tpd_ns:UserProfiles','1','activity:lastlogin',''
     put 'tpd_ns:UserProfiles','1','activity:posts','25'
     put 'tpd_ns:UserProfiles','1','activity:follower','500'

     put 'tpd_ns:UserProfiles','2','details:location','new york'
     put 'tpd_ns:UserProfiles','2','details:name','sarah johnson'
     put 'tpd_ns:UserProfiles','2','details:age','28'
     put 'tpd_ns:UserProfiles','2','activity:lastlogin','2023-05-12'
     put 'tpd_ns:UserProfiles','2','activity:posts','50'
     put 'tpd_ns:UserProfiles','2','activity:follower','1000'

     put 'tpd_ns:UserProfiles','3','details:location','los angeles'
     put 'tpd_ns:UserProfiles','3','details:name','michael anderson'
     put 'tpd_ns:UserProfiles','3','details:age','45'
     put 'tpd_ns:UserProfiles','3','activity:lastlogin','2023-05-13'
     put 'tpd_ns:UserProfiles','3','activity:posts','10'
     put 'tpd_ns:UserProfiles','3','activity:follower','250'
     ```

4. Buat Query

   - Nama user yang berlokasi di New York

     ```bash
     scan 'tpd_ns:UserProfiles', {
        COLUMNS => ["details:name", "details:location"],
        FILTER => SingleColumnValueFilter.new(Bytes.toBytes('details'), Bytes.toBytes('location'), CompareFilter::CompareOp.valueOf('EQUAL'),BinaryComparator.new(Bytes.toBytes('new york')))
     }
     ```

   - Nama dan last login user yang melakukan posting lebih dari 20 kali

     ```bash
     scan 'tpd_ns:UserProfiles', {
        COLUMNS => ["details:name", "activity:lastlogin", "activity:posts"],
        FILTER => SingleColumnValueFilter.new(Bytes.toBytes('activity'), Bytes.toBytes('posts'), CompareFilter::CompareOp.valueOf('GREATER'),BinaryComparator.new(Bytes.toBytes('20')))
        }
     ```
