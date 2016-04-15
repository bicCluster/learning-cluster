# Objective
To install HBase and test it(load data and query data) on losalamos.

# Introduction
HBase is a column based NoSQL database. For more information, you can refer to [this](https://en.wikipedia.org/wiki/Apache_HBase)

# Install
-You can choose to install HBase during the Ambari set-up process. Just choose the 'Add service' option, select 'HBase', and proceed to install as you did for the other components. (Or you can install HBase while installing services in the Ambari Website)

-If you want HBase work well will Ambari, pay attention to your iptable settings. You must set accept rules to the Ambari and HBase related ports before you do reject or drop. For detail ports, you may refer to this [site](http://docs.hortonworks.com/HDPDocuments/Ambari-2.2.0.0/bk_ambari_reference_guide/content/_default_network_port_numbers_-_ambari.html) and search the key word "160" in this [site](https://hbase.apache.org/book.html).


![alt text](https://github.com/CleoJiang/CCAssignment/blob/master/WeChat_1458152481.jpeg)
<!-- Image courtesy of Group 14, from Storm.md -->



# Test
## Common command for HBase
To enter HBase shell, use:
```bash
hbase shell
```
To create a hbase table, pass table name, a dictionary of specifications per column family, and optionally a dictionary of table configuration.
```bash
hbase> create ‘t1’, {NAME => ‘f1’, VERSIONS => 5}
hbase> create ‘t1’, {NAME => ‘f1’}, {NAME => ‘f2’}, {NAME => ‘f3’}
```
The above in shorthand would be the following:
```bash
hbase> create ‘t1’, ‘f1’, ‘f2’, ‘f3’
hbase> create ‘t1’, {NAME => ‘f1’, VERSIONS => 1, TTL => 2592000, BLOCKCACHE => true}
hbase> create ‘t1’, {NAME => ‘f1’, CONFIGURATION => {‘hbase.hstore.blockingStoreFiles’ => ’10’}}
```
Table configuration options can be put at the end.

To describe the named table:
```bash
hbase> describe ‘t1’
```

To drop the named table (Table must first be disabled):
```bash
hbase> drop ‘t1’
```

To list all tables in hbase (Optional regular expression parameter could be used to filter the output):
```bash
hbase> list
hbase> list ‘abc.*’
```

To import exist csv table to Hbase:
first quit hbase shell:
```bash
quit
```
then use importTsv:
```bash
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=a,b,c <tablename> <hdfs-inputdir>
```

To check the content in your table:
```bash
scan 'table_name'
```

To create data in your table:
```bash
create 'table_name', 'column_family1', 'column_family2'
```

To create data in your table:
```bash
put 'table_name','row_no','column family1:qualifier', 'value'
```

To get data in your table (this command is based on the index of row number):
```bash
get 'table_name', 'rowid', {COLUMN ⇒ ‘column family:column name’}
```

To delete a table or change its settings, you need to first disable the table using the disable command. You can re-enable it using the enable command.
```bash
disable ‘table_name’
```

For more hbase shell command, you may refer to [this](https://learnhbase.wordpress.com/2013/03/02/hbase-shell-commands/) or [this](http://www.tutorialspoint.com/hbase/index.htm)

## Test Example Code
-You can use the example project provided [here](https://github.com/CodeMySky/hbase-hortonworks). To run your own implementation, replace the java files in hbase-hortonworks-master\src\main\java with your own.

-First, replace the configuration file in `src/resources` by the setting download from "HBase -> "Service Actions" -> "Download Client Configuration" in Ambari. 

-Then run:
`sh compile.sh`
