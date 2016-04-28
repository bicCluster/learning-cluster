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
