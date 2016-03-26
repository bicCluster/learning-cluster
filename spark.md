### Instructions for installing Spark

## Install Spark
* Make sure the hdfs works correctly before install Spark, one good way to do this is first deploy hdfs(refer to README), and test hdfs by running mapreduce tesing job, then login Ambari web console to add Spark service.
* It better for you to follow the official installation Instructions: [here](http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.3.4/bk_spark-guide/content/ch_installing-spark.html)

* Steps
1. To add Service Spark through Ambari web console: go to 'Services' > 'Actions' > 'Add Service' > 'select spark'
2. Choose the Spark history Server, you can use default selection.
   Choose the number of clients. you may choose multiple clients to run spark.
3. The Spark will be installed automatically by Ambari.

## Test the Spark
* There are multiple testing materials you can refer to:
  1. You can find the simple samples from Spark offical site [here](http://spark.apache.org/examples.html):
     The complete code for samples can be found [here](https://github.com/apache/spark/tree/master/examples/src/main/python), you can easily test that using `pyspark`.
  2. Another example can be found at Hortonworks Ambari site [here](http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.3.4/bk_spark-guide/content/run_wordcount.html)


## Tips
* If you get permission denied when operating the hdfs, you can simply use command: `HADOOP_USER_NAME=hdfs`
* You don't need to install Spark Thrift Server to run Spark.
* The spark executive is default to be in /usr/bin/pyspark.
* You don't need to restart the service to make spark functional.
* To run spark on cluster, you need first put input file(not the program) in local file system and then upload to hdfs.
* Make sure the output folder doesn't exit on hdfs before running the spark.
* For the convenience of testing, you can write a bash script to automatically upload file to hdfs, run spark, download output from hdfs.
