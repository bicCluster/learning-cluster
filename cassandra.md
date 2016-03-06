# Objective
To install Cassandra and test it on losalamos.

# What's Cassandra
An open-source distributed-database management system for handling large amounts of data across many commodity servers 
with no single point of failure. Cassandra offers capabilities that relational databases and other NoSQL databases 
simply cannot match such as: continuous availability, linear scale performance, operational simplicity and easy 
data distribution across multiple data centers and cloud availability zones.
The DataStax community has a lot of support for Cassandra, and we followed the steps and tutorials
available on their [website](http://docs.datastax.com/en//cassandra/2.0/cassandra/install/installDeb_t.html).

# Steps for Installation:

1. Check the java version and see that the machine has atleast Java 7/8.
> * java -version

2. Add Datastax community repository to the sources list file: 
> * echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

3. Add the Datastax repository key to the aptitude trusted keys:
> * curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -

4. Install Cassandra:
> * sudo apt-get update
> * sudo apt-get install dsc20=2.0.11-1 cassandra=2.0.11

5. As the system starts the Cassandra service automatically, the server needs to be stopped and data must be cleared:
> * sudo service cassandra stop
> * sudo rm -rf /var/lib/cassandra/data/system/*


## Steps for testing:

In Cassandra, a keyspace is a container for your application data. It is similar to the schema in a relational database.

1. To start Cassandra:
>* sudo service cassandra start

2. In command line, enter:
> * cqlsh

3. Create Keyspace:
> * CREATE KEYSPACE demo
WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

4. Now we should be able to write the program and run oour code using Cassandra. For testing this out, we use the [tutorial]
(https://academy.datastax.com/demos/getting-started-apache-cassandra-and-java-part-i). The tutorial also has a link to the [java
code](https://gist.github.com/beccam/06c3283e5ee4a480a555) which you can use. 

4. You can also use the cqlsh shell to create all the tables and test it on command line. An excellent tutorial is available
[here](http://www.planetcassandra.org/create-a-keyspace-and-table/).

5. The true power of Cassandra can be observed when you set it up on a multi-node cluster.
For details, you can check how to initialize a multiple node cluster with [single](http://docs.datastax.com/en//cassandra/2.0/cassandra/initialize/initializeSingleDS.html) 
or [multiple](http://docs.datastax.com/en//cassandra/2.0/cassandra/initialize/initializeMultipleDS.html) data centers.
