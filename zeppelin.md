# Zeppelin
It is a web-based notebook that enables interactive data analytics. You can make beautiful data-driven, interactive and collaborative documents with SQL, Scala and more. 

# Make sure that the dependencies of Zeppelin are installed on the cluster.
# The dependencies of Zeppelin are:
1. Java 1.7 +
2. Scala
3. Spark

# Steps and Commands:
1. Download file (pre-compiled binary package)
  ```
  wget http://www.webhostingjams.com/mirror/apache/incubator/zeppelin/0.5.6-incubating/zeppelin-0.5.6-incubating-bin-all.tgz
  ```

2. Make directory
 ```
  sudo mkdir /usr/local/src/zeppelin
 ```

3. Unpack the contents of the downloaded zeppelin archive to the created directory
 ```
  sudo tar xvf zeppelin-0.5.6-incubating-bin-all.tgz -C /usr/local/src/zeppelin/
 ```

4. Configure Environment of Zeppelin:
  *As the port 8080 is dedicated to Ambari, You need to change the port for Zeppelin. This is because the default port for Zeppelin is also 8080. We gave port number 8000
 ```
  In the conf/zeppelin-env.sh file, make changes and put:
  ZEPPELIN_PORT="8000"
  AND
  Rename the conf/zeppelin-site.xml.template file to conf/zeppelin-site.xml and change the port to 8000
 ```

5. Start Zeppelin with a service manager:
  *In the /etc/init/zeppelin.conf file:
  ```
  description "zeppelin"
  
  start on (local-filesystems and net-device-up IFACE!=lo)
  stop on shutdown
  
  # Respawn the process on unexpected termination
  respawn
  
  # respawn the job up to 7 times within a 5 second period. 
  # If the job exceeds these values, it will be stopped and marked as failed.
  respawn limit 7 5
  
  # zeppelin was installed in /usr/share/zeppelin in this example
  chdir /usr/share/zeppelin
  exec bin/zeppelin-daemon.sh upstart
  ```
  ```
  sudo service zeppelin start
  sudo service zeppelin stop
  sudo service zeppelin restart
  ```

6. If there are any problems, do not reboot, just logout of all active sessions and re - login to check if the changes have taken effect.

7. You can check if zeppelin is working by going to ```http://losalamos.pc.cs.cmu.edu:8000``` and checking whether it works.

8. You can visit the following website for other details: <https://zeppelin.incubator.apache.org/docs/0.6.0-incubating-SNAPSHOT/install/install.html>

###Tips:

1. Before you run your own scala code on zeppelin, make sure "spark %spark..." is blue and click save

2. You can use scala version of word count as example to test if your zepperlin works properly.
   For code, please refer to <http://spark.apache.org/examples.html>
   Make sure you change the path of textFile function in example to valid path like "README.md"

3. During the installation of zepperlin, make sure you set up proper version number of dependencies using "export" if neccessary

4. If you encounter any problem during installation, make sure that you satisfy all requirement for installing zepperlin.
   If you don't have requirements prepared, install it.
   sudo apt-get update
   sudo apt-get install git
   sudo apt-get install openjdk-7-jdk
   sudo apt-get install npm
   sudo apt-get install libfontconfig

   # install maven
   wget http://www.eu.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
   sudo tar -zxf apache-maven-3.3.3-bin.tar.gz -C /usr/local/
   sudo ln -s /usr/local/apache-maven-3.3.3/bin/mvn /usr/local/bin/mvn
   
5. Kind reminder: Please also refer to the official github of zepperlin for the latest version before you install. Any package 
   or command on this page may become outdate since zepperlin is a fast-growing product.
   Check <https://github.com/apache/incubator-zeppelin> for more details.

