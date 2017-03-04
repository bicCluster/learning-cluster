#!/bin/bash
HADOOP_USER_NAME=hdfs hadoop fs -rm -r -f /user/output
HADOOP_USER_NAME=hdfs yarn jar WordCount-1.0.jar WordCount /user/input /user/output
HADOOP_USER_NAME=hdfs hadoop fs -copyToLocal /user/output/part-r-00000 ./
