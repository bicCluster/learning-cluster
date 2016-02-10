# Objective
To install Pig on `losalamos` and make it run automatically on system startup.

# Steps
1. Switch to root such that you will have correct setting when running the server as a root
2. Install 'Pig' when install Hadoop through Ambari. Please find more detailes on in [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5.html)
3. Set up Pig configuration file and environmen variables, you can follow the instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-2.html). You can also set the password(optional).
4. To validate whether Pig has been installed rightly, run instructions [here](http://docs.hortonworks.com/HDPDocuments/HDP1/HDP-1.2.4/bk_installing_manually_book/content/rpm-chap5-3.html).
5. Write a simple script and see [here](http://www.folkstalk.com/2013/09/word-count-example-pig-script.html) to learn how to make the system run Pig. 
6. There are some arguments you may want to use, e.g. `pig -help` for more detail.


