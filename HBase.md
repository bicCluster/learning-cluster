# Objective
To install HBase and test it on losalamos.

# Introduction
HBase is a clolumn based NoSQL database. For more information, you can refer to [this](https://en.wikipedia.org/wiki/Apache_HBase)

# Install
You can choose to install HBase during the Ambari set-up process.

# Test
## Test HBase Shell
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
For more hbase shell command, you may refer to [this](https://learnhbase.wordpress.com/2013/03/02/hbase-shell-commands/)

## Test Example Code
-We use the example code provided [here](https://github.com/CodeMySky/hbase-hortonworks).
-First, replace the configuration file in `src/resources` by the setting download from "HBase -> "Service Actions" -> "Download Client Configuration" in Ambari. Then run:
`compile.sh`
