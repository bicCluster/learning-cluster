# Objective
To install Hive on Cluster and make it run automatically on system startup.

# Steps

1. Go to the [Ambari Web](http://losalamos.pc.cs.cmu.edu:8080) and choose to install a new service - 'Hive'. It will reminds you that you need to install some extra services. (Tips:install new service step by step, do not select to install them all in a time, which may have complex errors)
2. Set up the Hive Directory and Permission. Find more detailes in [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap6.html) (I'm not sure if its a MUST step or not. You can try go directly to validate step and see.)
3. To validate whether Hive has been installed rightly, run instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap6-5.html).
4. To further validate you installation, you will need to create a script and run it on hive. You can find more details [here](http://www.edureka.co/blog/apache-hadoop-hive-script/). 
	- Create the script and input text as is written in the page. One thing to keep in mind is that the path of input text should be the path on the physical file system, which should be something like `/root/input.txt`
	- To run it on hive, you first need to copy the script to HDFS, and run it with `hdfs` username.
	- If you write the script exactly after the link, you first created a database called `sample` (or any name of your choice). You can type `show databases;` in hive to check the existing databases. 
	- If you try to run the same script for another time, hive will give you a failure warning you that such database already exists. What you have to do right now is delete the database you created before.
	- If no table has been created in that database, you can delete the database using `DROP DATABASE IF EXISTS [name of database to be deleted]` to drop the database. But if some table has already been created in it, you have to use `DROP DATABASE IF EXISTS [name] CASCADE` instead to first drop all the tables.
5. If the system successfully print all the data stored in the table, then congratulations you got it right!