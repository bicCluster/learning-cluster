# Objective
To install Pig on Clustering and make it run automatically on system startup.

# Steps

1. Choose 'Pig' when install Hadoop through Ambari. Please find more detailes in [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5.html)
2. Set up Pig configuration file and environmen variables, you can follow the instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-2.html). You can also set the password(optional).
3. To validate whether Pig has been installed rightly, run instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-3.html). Execute the following commands :
	- `hdfs dfs -copyFromLocal /etc/passwd passwd`
	- Create the pig script file /tmp/id.pig with the following contents:
	`echo "A = load 'passwd' using PigStorage(':'); " > /tmp/id.pig`
	`echo "B = foreach A generate \$0 as id; store B into '/tmp/id.out'; " >> /tmp/id.pig`
	- Execute the Pig script, run `pig -l /tmp/pig.log /tmp/id.pig` , for more details, you can see [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-3.html)
	- There are some arguments you may want to use, e.g. `pig -help` for more details.
