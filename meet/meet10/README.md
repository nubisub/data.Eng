# HBase

## Kelola Data dalam HBase
1.	Masuk ke HBase shell
    ```bash
    hbase shell
    ```
    ```bash
    exit
    ```
2.	Melakukan perintah umum
    ```bash
    list
    ```
    ```bash
    status
    ```
    ```bash
    whoami
    ```
3.	Membuat namespace
    ```bash
    create_namespace 'tpd_ns'
    ```

4.	Membuat table
    ```bash
    create 'tpd_ns:employee','personal data','professional data'
    ```
5.	Mengapus atau mengubah skema
    ```bash
    disable 'tpd_ns:employee'
    ```
    ```bash
    is_disabled 'tpd_ns:employee'
    ```
    ```bash
    enable 'tpd_ns:employee'
    ```
6.	Mengisi Data
    ```bash
    put 'tpd_ns:employee','1','personal data:name','andi'
    put 'tpd_ns:employee','1','personal data:city','jakarta'
    put 'tpd_ns:employee','1','professional data:designation','manager'
    put 'tpd_ns:employee','1','professional data:salary','50000'
    ```
    
7.	Melihat data di table
    ```bash
    scan 'tpd_ns:employee'
    ```
8.	Mengisi data dengan skema berbeda
    ```bash
    put 'tpd_ns:employee','2','personal data:name','desi'
    put 'tpd_ns:employee','2','professional data:salary','15000'
    ```
9.	Update data
    ```bash
    put 'tpd_ns:employee','1','personal data:city','bandung'
    ```
10.	Query data
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
11.	Fiter (kalo di rdbm pake WHERE)
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
12.	Menghapus Data
    ```bash
    delete 'tpd_ns:employee','1','personal data:city',1684079532813
    ```
    ```bash
    deleteall 'tpd_ns:employee','2'
    ```
13.	Meta table
    ```bash
    scan 'hbase:meta'
    ```
    ```bash
    scan 'hbase:meta', {FILTER=>"PrefixFilter('tpd_ns:employee')"}
    ```
##	Snapshots dalam HBase

1.	Membuat snapshot
    ```bash
    snapshot 'tpd_ns:employee', 'pegawaiData-15052023'
    ```
2.	Menampilkan semua snapshots
    ```bash
    list_snapshots
    ```
3.	Membuat table dari snapshot
    ```bash
    clone_snapshot 'pegawaiData-15052023', 'tpd_ns:new_employee'
    ```    
4.	Menghapus row
    ```bash
    disable 'tpd_ns:employee'
    restore_snapshot 'pegawaiData-15052023'
    ```
5.	Menghapus snapshot
    ```bash
    delete_snapshot 'pegawaiData-15052023'
    ```