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

1. Check the java version and see that the machine has at least Java 7/8.

  ```bash
  java -version
  ```
2. Add Datastax community repository to the sources list file: 
  
  ```bash
  echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
  ```
3. Add the Datastax repository key to the aptitude trusted keys:
  
  ```bash
  curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
  ```
4. Java Native Access (JNA) is required for production installations (latest version recommended). refer to : [Installing the JNA on Debian or Ubuntu Systems](http://docs.datastax.com/en//cassandra/2.0/cassandra/install/installJnaDeb.html)

  ```bash
  sudo apt-get install libjna-java
  ```
5. Install Cassandra:

  ```bash
  sudo apt-get update
  sudo apt-get install dsc20=2.0.11-1 cassandra=2.0.11
  ```
6. As the system starts the Cassandra service automatically, the server needs to be stopped and data must be cleared:
  
  ```bash
  sudo service cassandra stop
  sudo rm -rf /var/lib/cassandra/data/system/*
  ```
7. Open port for Cassandra in iptables:
  
  ```bash
  sudo iptable -A INPUT -p tcp --dport XXXX -j ACCEPT
  ```
  * XXXX is the port number of Cassandra, refer [this](http://docs.datastax.com/en/latest-dse/datastax_enterprise/sec/secConfFirePort.html?scroll=secConfFirePort__cassandrayaml_unique_24)

## Steps for testing:

In Cassandra, a keyspace is a container for your application data. It is similar to the schema in a relational database.

1. To start Cassandra:

  ```bash
  sudo service cassandra start
  ```

  Usually the Cassandra starts automatically, so before you manually start the Cassandra service, you can use the following command to validate:

  ```bash
  nodetool status
  ```
  If you see the information of datacenter, the service has been started.

2. In command line, enter the following command to start the CQL interactive terminal:

  ```bash
  cqlsh
  ```
3. Create Keyspace demo:

  ```cql
  CREATE KEYSPACE demo
  WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
  ```

  Check that the keyspace has been successfully created:
  ```cql
  SELECT * FROM system.schema_keyspaces;
  ```
  You will see keyspace "demo".

4. Now we should be able to write the program and run oour code using Cassandra. For testing this out, we use the [tutorial]
(https://academy.datastax.com/demos/getting-started-apache-cassandra-and-java-part-i). The tutorial also has a link to the [java
code](https://gist.github.com/beccam/06c3283e5ee4a480a555) which you can use. Remember to first create the [User](http://www.planetcassandra.org/create-a-keyspace-and-table/) table, otherwise java program with throws exception. The following cql command can be used to create the User table.:

  ```cql

  CREATE TABLE user(lastname text PRIMARY KEY, 
                    age int, 
                    city text, 
                    email text, 
                    firstname text );
  ```
If the command fails because the table has already exists, then you can use the command below to remove the old User table:

  ```cql
  DROP TABLE IF EXISTS demo.user;
  ```

5. You can also use the cqlsh shell to create all the tables and test it on command line. Excellent tutorials are available
[here](http://www.planetcassandra.org/create-a-keyspace-and-table/) and [here](https://www.tutorialspoint.com/cassandra/cassandra_create_table.htm).

6. The true power of Cassandra can be observed when you set it up on a multi-node cluster.
For details, you can check how to initialize a multiple node cluster with [single](http://docs.datastax.com/en//cassandra/2.0/cassandra/initialize/initializeSingleDS.html) 
or [multiple](http://docs.datastax.com/en//cassandra/2.0/cassandra/initialize/initializeMultipleDS.html) data centers.

# Another way to install Cassandra
1. You first need to make sure the version of java on your machine is at least jdk7, jdk8 is the best. Otherwise you can not start cassandra.

2. Download cassandra from the website http://cassandra.apache.org/download/, and decompress the file.

3. Configure files. Find the configuration file cassandra/conf/cassandra.yaml, and add these values:
   
   data_file_directories:
      - /var/lib/cassandra/data

   commitlog_directory: /var/lib/cassandra/commitlog
   
   saved_caches_directory: /var/lib/cassandra/saved_caches
  
   Attention: You have to add these key-values in exactly the same format as above, or there will be an exception when you    start cassandra. There is a space between key and value

4. Create these directories:
  
  ```bash
  sudo mkdir -p /var/lib/cassandra/data
  sudo mkdir -p /var/lib/cassandra/saved_caches
  sudo mkdir -p /var/lib/cassandra/commitlog
  sudo mkdir -p /var/log/cassandra/
  ```
5. Change the property of these directories:

  ```bash
  sudo chown -R root:root /var/lib/cassandra
  sudo chown -R root:root /var/log/cassandra/
  ```
   Attention: "root:root" should be the user that you are logging in your system. Here I use root

6. Configure the environment variables, open the file /etc/environment and add the environment variable:CASSANDRA_HOME=The address of your cassandra.

7. Make your environment variables effective by executing the command:. /etc/environment

8. Start your cassandra. Enter the bin file of your cassandra and execute the command:./cassandra -f
   
   Attention: If you see an exception like local_host:7000 port number is in use of another process, change the storage       
   port number to 8000 or 9000.

9. Access cassandra by typing in command:./cqlsh. Then you can use the instructions above to create your own tables.

# Pitfalls you should pay attention to

1. If you see error message like this:

```bash
sudo service cassandra start
Cassandra 2.0 and later require Java 7 or later.
```

The reason is that java only was configured for the local user, but not for sudo:
```bash
sudo java -version
sudo: java: command not found
```

The solution is to, first of all, tell the system that you have installed java and its path:
```bash
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/jdk64/jdk1.8.0_112/bin/java" 1
```

Then set the new java as default:
```bash
sudo update-alternatives --set java /usr/jdk64/jdk1.8.0_112/bin/java
```
You can find reference [here](http://stackoverflow.com/questions/24190063/cassandra-2-complaining-about-java-7-when-i-have-java-7-installed).

