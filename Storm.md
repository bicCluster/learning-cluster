# Objective
Install Storm service using Ambari install wizard

# Pitfalls
* Choose only basic services in the first basic Ambari Installation process, add storm service later.
* There are 2 ways to install Storm (1 using Ambari (2 non-Ambari. Choose the first one.
* Do not assign losalamos as supervisor. Details are in the following step by step installation part.

# What's Storm
Apache Storm is a free and open source distributed realtime computation system. Storm makes it easy to reliably process unbounded streams of data, doing for realtime processing what Hadoop did for batch processing. Storm is simple, can be used with any programming language, and is a lot of fun to use!<br /> 
Refer to Official Document [here](http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.2.9/bk_storm-user-guide/content/ch_using_storm.html)

# Installation step by step
* Add new services in the Ambari main page

![alt text](https://github.com/CleoJiang/CCAssignment/blob/master/WeChat_1458152481.jpeg)

* Choose Storm in Choosing services step

* Assign losalamos to run Storm’s Nimbus daemon as well as the Storm UI server and the other three hosts to run Supervisor daemons.  [this](http://www.michael-noll.com/tutorials/running-multi-node-storm-cluster/)

* During the Customize Services step, configure 2 propertities. read [here]( http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.2.9/bk_storm-user-guide/content/storm-install-config.html)<br /> 
(1 supervisor.childopts property<br />
(2 worker.childopts property<br />

#Running a Storm Application
You can use the example from the Apache [storm-starter] (https://github.com/apache/storm/tree/v1.0.0/examples/storm-starter) project. This project contains several examples to learn about Storm in Java and its multilang capabilities. 

Storm uses "topologies" to do realtime computations. A topology is a graph of computation. Each node in the topology contains the processing logic, and the links between each node indicate how the data should be passed around between nodes.

After creating a jar, run the Storm application in the cluster with the following command:</br>
* storm jar all-my-code.jar org.apache.storm.MyTopology arg1 arg2

We ran the ExclamationTopology in Los Alamos like this:

* storm jar storm-starter-0.0.1-storm-0.9.0.1.jar storm.starter.ExclamationTopology org.apache.storm.starter.ExclamationTopology -c storm.starter.ExclamationTopology org.apache.storm.starter.ExclamationTopology -c nimbus.host=losalamos.pc.cs.cmu.edu

You would be able to see the topology running in the StormUI. In our case, we openned the UI in port 8744.

![image](StormTopology.png)

You can get more information from [this](http://storm.apache.org/releases/current/Tutorial.html) link. 
# Test

* Refer [this tutorial](http://zh.hortonworks.com/hadoop-tutorial/processing-streaming-data-near-real-time-apache-storm/) to run a Storm topology. Check the Storm Log files to see if your topology was executely without any error. 
