# Objective
Install Storm service using Ambari install wizard

# Pitfall
* Choose only basic services in the first basic Ambari Installation process, add storm service later.
* There are 2 ways to install Storm (1 using Ambari (2 non-Ambari. Choose the first one.

# What's Storm
Apache Storm is a free and open source distributed realtime computation system. Storm makes it easy to reliably process unbounded streams of data, doing for realtime processing what Hadoop did for batch processing. Storm is simple, can be used with any programming language, and is a lot of fun to use!<br /> 
Refer to Official Document [here](http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.2.9/bk_storm-user-guide/content/ch_using_storm.html)

# Installation step by step
* Add new services in the Ambari main page

![alt text](https://github.com/CleoJiang/CCAssignment/blob/master/WeChat_1458152481.jpeg)

* Choose Storm in Choosing services step

* Choose default configuration in the Assign Masters step and Assign Slaves and Clients step

* During the Customize Services step, configure 2 propertities. read [here]( http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.2.9/bk_storm-user-guide/content/storm-install-config.html)<br /> 
(1 supervisor.childopts property<br />
(2 worker.childopts property<br />
