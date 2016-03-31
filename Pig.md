# Objective
To install Pig on Clustering and make it run automatically on system startup.

# Steps

1. Choose 'Pig' when install Hadoop through Ambari. Please find more detailes in [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5.html). 
2. Set up Pig configuration file and environmen variables, you can follow the instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-2.html). You can also set the password(optional).
3. To validate whether Pig has been installed rightly, run instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-3.html). Execute the following commands :
	- `hdfs dfs -copyFromLocal /etc/passwd passwd`
	- Create the pig script file /tmp/id.pig with the following contents:

	    ```pig
	    A = load 'passwd' using PigStorage(':');
	    B = foreach A generate $0 as id; store B into '/tmp/id.out';
	    ```
	- Execute the Pig script, run `pig -l /tmp/pig.log /tmp/id.pig` , for more details, you can see [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-3.html)
	- There are some arguments you may want to use, e.g. `pig -help` for more details.
4. You can also install 'Pig' by adding the service 'Pig' through your Ambari server webpage after you install and setup well the cluster(i.e., you can run a simple mapreduce program on Hadoop). If you are informed to install Tez as well, just click yes and install it.
5. [here](http://salsahpc.indiana.edu/ScienceCloud/pig_word_count_tutorial.htm) provides detailed instructions and simple codes to deploy the Pig application.
