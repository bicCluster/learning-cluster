#Hadoop Cluster Requirements
- OS: CentOS 7/ Ubuntu 14.04
- Network Structure: NAT, Losalamos need to be the NAT server. Losalamos can be connected to the port on wall through "eno2".
- Install Choice: [Link to installation]( http://docs.hortonworks.com/HDPDocuments/Ambari-2.2.0.0/bk_Installing_HDP_AMB/bk_Installing_HDP_AMB-20151221.pdf)
- You need to install 'HDFS','MapReduce2','Yarn', 'Ambari Metics' and you must install the package we are currently learning.
- You must keep a wiki of the necessary steps you think may be helpful to the next group here. Change of the wiki also is part of the grading. 
- You have 3 whole days minus 2h for grading from 1:00PM the first day to 11:00 AM the last day.


#Grading Criteria (30')
##Wiki (10')
- Beyond expectation, more than TA would write (12')
- Meet expectation (10')
- Basically meet expectation, missing some points that TA think is necessary for other groups (8')
- Below expectation (6')
- Less than 10 lines of wiki added/Modified, or modification makes no sense (2')

## Self designed demo (10')
- Beyond expectation, test some points that TA would not think of (12')
- Meet expectation (10')
- Basically meet expectation (8')
- Below expectation, there are some essential points are not tested (6')
- Demo does not work will add another 3 points penalty on the previous grade.

## Other (10')
- Iptables is up. (2')
- Name Node and Data Nodes are separate. (2')
- Hadoop put test on losalamos (2')
- Hadoop read test on losalamos (2')
- NAT test, get google home page on other three machines. (2')
- No Alert in Ambari. (1' each alert)

#Knowledge Background:
- Ubuntu Command Line, Network Config (hostname, hosts, etc)
- Basic Computer Network knowledge, like DNS, Subnet (IP, Mask), Gateway;
- SSH, NAT, Forwarding
- Hadoop structure
- Basic understanding of above topics would make this work much easier

#Things about hardware you should know:
- There are four servers to set up, but only the first one (Losalamos) has access to the Internet;
- The box connecting the servers is just a switch, not a router. So “forwarding” is needed to get the other three servers connected to the Internet;
- Every server has two network adapters, “eth0” and “eth1”, and it can only connects to the Internet by “eth1”. So please double-check the connection ports;
- Since “Losalamos” uses “eth1” to connect to the Internet, it should use “eth0” for the sub network.

#Installation Overview:
1. Install Ubuntu (recommend 14.04) on each machine;
2. Connect servers physically, through the switch and network adapter ports on each machine;
3. Config network environments to form a subnet among servers;
4. Set up hostnames and domains (domains are needed when installing Ambari)
5. Config DNS server and hostname lookup, make sure servers can “ping” each other by both IP address and hostname;
6. Enable “Losalamos” network forwarding mechanism (both IPv4 and IPv6). After that, other servers should be able to get access to the Internet through this gateway;
7. Follow the Ambari Installation Instructions and patch extra packages or components demanded;
8. Check Hadoop Components you want and arrange them reasonably on the servers. You should be aware of that “Losalamos” should be one of the clients since it is the only interface to run Hadoop programs from outside.

#Pitfalls you should pay attention to:
- Make sure the physical connection is correct;
- You should down/up network adapters or reboot machines to make your network configurations work;
- Make sure your configurations are permanent, otherwise they will remain unchanged after reboot, like iptables;
- Ambari Server should be installed on “Losalamos” since it is the only server you can get access to from outside the subnet;
“Losalamos” should also hold a Ambari Agent to be part of the cluster;
- Keep in mind that “Losalamos” should be one of the clients;
- (IMPORTANT) once you fail to set up the entire environment, it will be extremely hard to clean up and re-install (the official method doesn’t work in this case). So we highly recommend that you should keep retrying if you encounter problems when installing or deploying hadoop platform on Ambari.
