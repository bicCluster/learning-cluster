__!!!NO USERNAME, PASSWORD HERE!!!__

* [Hadoop Cluster Requirements](#requirement)
* [Knowledge Background](#knowledge)
* [Notes About Hardware](#hd)
* [Steps to Follow](#step)
    - [Milestone Checklist](#milestone-checklist)
    - [Install Ubuntu](#install-ubuntu)
    - [Establsh Subnet](#install-subnet)
    - [Iptables](#iptables)
    - [Install Hadoop using Ambari](#install-hadoop)
    - [Test a MapReduce Program](#test-mapreduce)
* [Pitfalls](#pitfall)
* [How to Re-create the Cluster](#recreate-cluster)
* [Basic Network Troubleshooting](#troubleshoot)

## You may want to bring ear plugs to the machine lab, as you will be working next to a rack server for a couple of hours. Once you are able to ssh into your cluster, you can access them from outside the lab.

# <a name="requirement">Hadoop Cluster Requirements</a>
- OS: CentOS 7/ Ubuntu 14.04
- Network Structure: NAT, `losalamos` need to be the NAT server. `losalamos` can be connected to the port on wall through "eno2".
- Install Choice: [Link to installation]( http://docs.hortonworks.com/HDPDocuments/Ambari-2.2.0.0/bk_Installing_HDP_AMB/bk_Installing_HDP_AMB-20151221.pdf)
- You need to install `HDFS`,`MapReduce2 + YARN`, `Ambari Metrics`, and `ZooKeeper` and you must install the package we are currently learning.
- You must keep a wiki of the necessary steps you think may be helpful to the next group here. Change of the wiki also is part of the grading.
- You have 3 whole days minus 2h for grading from 1:00 PM the first day to 11:00 AM the last day.


# Grading Criteria (30')

## Wiki (extra points 5')
- Write down all the problems you have met and how you solve them.
- Make a clear demonstration on how you demo runs. For example, in a wordcount demo, you can describe how NameNode, DataNode, Jobtracker, Tasktracker (or container in YARN) work together to run this demo.
- Improve the sections of the previous wiki which are ambiguous.
- Less than 10 lines of wiki added/Modified, or simple modification makes no sense.

## Self designed demo with scripts to run without any intervention (15')
- Beyond expectation, test some points that TA would not think of, and make a perfect explanation on how the demo runs. (15')
- Meet expectation, the demo works fine, make reasonable explanation. (12')
- Basically meet expectation (9')
- Below expectation, there are some essential points are not tested (6')
- Demo does not work will add another 3 points penalty on the previous grade.
- Demo requires TA intervention will add 1~2 points penalty on the previous grade depending on the time spend on intervention.

## Other (15')
- Iptables is up on losalamos and has basic protection with minimum iptables (3')
- Primary Name Node and Data Nodes should be on separate machines. (3')
- Primary Name Node and Secondary Name Nodes should be on separate machines. (3')
- NAT test, get google home page on other three machines. (3')
- Strong Password, password including at least a number and a letter and longer than 6 characters (3')
- No Alert in Ambari. (1' each alert, 2' max)

### Minimum Iptables
```
target     prot opt in     out     source               destination
ACCEPT     all  --  any    any     anywhere             anywhere             ctstate RELATED,ESTABLISHED
ACCEPT     all  --  lo     any     anywhere             anywhere
ACCEPT     icmp --  any    any     anywhere             anywhere
REJECT     all  --  any    any     anywhere             anywhere             reject-with icmp-host-prohibited
```

# <a name="knowledge">Knowledge Background</a>
- Ubuntu Command Line, Network Config (hostname, hosts, etc)
- Basic Computer Network knowledge, like DNS, Subnet (IP, Mask), Gateway;
- SSH, NAT, Forwarding
- Hadoop structure
- Basic understanding of above topics would make this work much easier

# <a name="hd">Things about hardware you should know</a>
- There are four servers to set up, but only the first one (Losalamos) has access to the Internet;
- The box connecting the servers is just a switch, not a router. So “forwarding” is needed to get the other three servers connected to the Internet;
- Every server has two network adapters, `eth0` and `eth1`, and it can only connects to the Internet by `eth1`. So please double-check the connection ports;
- Since `losalamos` uses `eth1` to connect to the Internet, it should use `eth0` for the sub network.
- Keep the roles of `eth0` and `eth1` in mind when you are configuring iptables with the linked tutorials: you may need to change the bash command given in those tutorials.
- **Important** : Check the machine which has 2 UPS backup connections - use them as losalamos (name node). Currently, it is the top most machine in the rack.(Ask TAs in case of any issues). Sometimes, the power backup fails, and hence having an additional backup helps to keep the name node running.

<hr>

## <a name="milestone-checklist">Milestone Checklist</a>

1. System installation of `losalamos`. When you finish, you can log in with the username and password when you set up during the installation. Also, you can input command line `ping google.com` to test whether `losalamos` have the right access to Internet.

2. System installation of three slave machines, (which is `alpha`,`beta` and `gamma`, according to your choice of naming). When you finish, you can log in with the username and password when you set up during the installation.

3. Configuration of `/etc/network/interfaces` and `/etc/hosts`. When you finish, you can ping other machines using the hostname or ip.

4. Configuration of `iptables`. When you finish, you can input `ping google.com` on the three slave machines to test whether they have access to Internet.

# <a name="step">Steps to Follow</a>

Overview: Given four blank server, we need to install system and establish a subnet. Finally install the requested hortonwork components. The network should be built as this image

![image](network.png)

## <a name="install-ubuntu">Install Ubuntu</a>

Install Ubuntu (recommend 14.04) on each machine. The hard disks of four machines should already be erased. If not, press F11 when the system is starting and choose to start from the CD rom.

It may be hard to create a bootable USB stick on mac OS X. Failures occured for the following two approaches:
1. burn by command `dd` [[ref]](http://www.ubuntu.com/download/desktop/create-a-usb-stick-on-mac-osx)
2. burn by UNetbootin [[ref]](http://unetbootin.github.io/) Please update if there are methods that work. A convenient method is to install Ubuntu from CD (the CD is already provided, you can find it near the machines).

###Bullet points when installation
1. Insert the disk and press the power button to turn-off the machine. The lights on the machine should turn-off after a few seconds. Then press the pwer button again to start the machine.
2. Once the machine starts, press F11 to enter Boot menu. Select `boot from disk` option.
3. Select the `Install Ubuntu Server` option.
4. Make the appropriate language realted settings.
5. Detect keyboard layout? Select `No`
6. Select the appropriate time settings.
7. Encrypt your home directory? Select `No`
8. Partition method: `Guided - use entire disk` if there is such a choice. If there is multiple partition selections, just take the default one.
9. Write changes to disks? Select `Yes`
10. Network configuration. Choose `eth1` when configure `losalamos` and `eth0` (OR `eth1`, both are okay) when configure `alpha`, `beta` and `gamma`. Also, in case of `alpha`, `beta` and `gamma`, the network config will fail. Select `Do not configure netwrok`.
11. HTTP proxy information? `Continue` with blank
12. How do you want to manage upgrades on this system? `Install security updates automatically`
13. Choose software to install: Press space on `OpenSSH server` and there is a `*` ensures that you have chosen the software. Then press `Continue`.
14. Install the GRUB boot loader to the master boot record? Choose `YES`.
15. Before finishing installation, choose `Yes` for `Set clock to UTC` option  
16. Unmount partitions that are in use? `YES`

[Here](https://www.youtube.com/watch?v=P5lMuMhmd4Q) is a step-by-step installation video.

### Tips
1. In the image above, the three innet machines' hostname are `alpha`, `beta` and `gamma`. You can change them to whatever you like.

2. Sometimes the system may get stuck when reboots after completing installation, in such rare cases, just press the reboot button on the back of the server for more than 10 seconds and restart the system.

3. During the installation, we need configured network of `losalamos` with eth1 and we don't need to configure the network of three innet machines during the install process. Thus when installing Ubuntu on the three innet machines, you can either chose eth0 or eth1 during network configuration step, and it will eventually show "network auto configuration failed", just ignore and continue.

4. You probably want to install the OpenSSH during installation, so that you can then connect to the server using terminal in your own laptops. If you choose `not to update the server automatically` when you install the server, you might need to install the OpenSSH using `sudo apt-get install openssh-server`. If you still cannot install OpenSSH, please refer to [Here](http://askubuntu.com/questions/318012/openssh-server-package-not-available-on-12-04-2).

5. The openssh-server should be installed on all of the four machines for ssh to function properly, try `apt-get update` before install openssh-server. 

6. `losalamos` should have access to the internet already after installation. Using `ping google.com` or `ping + other known IP address` to check the connection. 

7. You need to choose unmount the disk partition before installation step. Choose the `guided use entire disk`, if there is multiple partition selections, just take the default one. If you get a note like this: "Note that all data on the disk you select will be erased, but not before you confirm that you really want to make changes. Select disk to partition:" and select "SCSI3 (2,0,0) (sda) - 72.7 GB DELL PERC 5/i" 

8. When reboot after installation is complete, press F11 to get into the boot menu then choose "reboot from Hard Drive C"




## <a name="install-subnet">Establish Subnet</a>

Notice: during the entire process (even after you finish this part), you’d better not reboot any of the four machines after you have done with following establish subnet steps, otherwise you may lose your network connection and need to install the OS once again (Welcome for the notes if you could solve this problems without reinstalling OS).
There are two ways, which is DHCP and static IP, to setup connection between `losalamos` and the other threes machine `alpha`, `beta` and `gamma`. Static IP is easier and safer, so the following step instruction is based on static IP method. If you want to use DHCP, please refer to the instruction below the `Steps` part.
### Steps

1. Connect servers physically, through the switch and network adapter ports on each machine. That is, connect the gray ethernet cables from each machine to the switch (small white box at the top corner of the server rack).  
2. Start from the `losalamos`. Configure `eth0` in the file `/etc/network/interfaces`, using the command line `sudo vim /etc/network/interfaces`. The content would be 
```
    auto eth0
    iface eth0 inet static
      address 10.0.0.2
      netmask 255.255.255.0
      gateway 10.0.0.2
      broadcast 10.0.0.255
      dns-nameservers 8.8.8.8 8.8.4.4
```
You can find an example [here](https://wiki.debian.org/NetworkConfiguration), in the **Configuring the interface manually** section. 
Attention: comment the keyword `loopback` and `dhcp` if you use static ip method (This is not needed!). `loopback` and `dhcp` are the default keywords which have already been in the files.
3. (Recommended)Still in the configuration of `losalamos`. Configure the file `/etc/hosts`, using the command line `sudo vim /etc/hosts`. The content would be
```
     127.0.0.1 localhost
     10.0.0.2 losalamos.pc.cs.cmu.edu losalamos
     10.0.0.3 alpha.pc.cs.cmu.edu alpha
     10.0.0.4 beta.pc.cs.cmu.edu beta
     10.0.0.5 gamma.pc.cs.cmu.edu gamma
```
This [page](http://linux.die.net/man/5/hosts) can give you more info.
4. When you finished the configuration of `losalamos`, **DO NOT** reboot losalamos. Use `sudo ifdown eth0`, `sudo ifup eth0` and `sudo ifconfig eth0 up` to enable the configuration (Note `eth0` for `losalamos`, not `eth1`! If it returns error information after executing second command, you can ignore it as long as the third command can be executed successfully). Otherwise you may lose your connection to external network. 
5. Modified the above two files similarly in the three slave machines. There are some minor modifications needed to make. The following is an example when configuring `alpha`. Other information refer to the image above.
When configure `eth1` in `/etc/network/interfaces` in `alpha`, , using the command line `sudo vim /etc/network/interfaces`. The content would be
```
    auto eth1
    iface eth1 inet static
      address 10.0.0.3
      netmask 255.255.255.0
      gateway 10.0.0.2
      broadcast 10.0.0.255
      dns-nameservers 8.8.8.8 8.8.4.4
```
The dns-nameservers can be the IP of any DNS service, not necessarily the one provided in the example(which is that of Google). If you need more help, please refer to [link](https://help.ubuntu.com/14.04/serverguide/network-configuration.html).
6. For slaves machine, after making the configurations above, remember the configurations will take effect only after 1) you reboot the machine **OR** 2) shut down port using `sudo ifdown eth1` and then restart using `sudo ifup eth1`. Though the command may return error information, it actually works. 
7. You should be able to ping each other now using IP.

### Tips
1. To prevent warning for Ambari part, you can set the hosts as 'ip_address domain_name alias', each node should maintain the same copies of hosts configuration file.
2. If you want to set the hosts as 'ip_address domain_name alias'. In the file `/etc/hosts`, you should list `all the hosts` below the localhost on each machine. Otherwise you would receive warning `Transparent Huge Pages` as you can see below when deploying the Ambari Server.
3. The warning for 'Transparent Huge Pages' can be removed by using the following commands:
```
i) Install hugepages:
>> apt-get install hugepages
ii) Then type the following command:
>> hugeadm --thp-never
iii) Check if [never]
cat /sys/kernel/mm/transparent_hugepage/enabled
```
4. If you are facing issues with connectivity, check the physical connection carefully to understand which port is considered eth0 and which port is eth1. **DO NOT** assume that eth0 and eth1 for all machines line up in the same column position in the machines.


* Using DHCP

> * Set up a DHCP server on `losalamos` first. [Here](https://www.youtube.com/watch?v=9Vc6-0smd64) is a video tutorial about how to set up a DHCP server on Ubuntu server. Be carefule about compatability. The system we install is Ubuntu 14.01. So download the version of DHCP server which is compatable with our system. The DNS server of CMU are [here](https://www.cmu.edu/computing/partners/dept-computing/services/domain.html) And you can check [this](http://askubuntu.com/questions/140126/how-do-i-install-and-configure-a-dhcp-server) for DHCP configuration.

> * Here is some quick tips for setting up the dhcp server. After installed dhcp in `losalamos`, you need to configure it in file `/etc/dhcp/dhcpd.conf`. In this file, you need to configure an internal subnet with `subnet`, `netmask`, `range`, `domain-name-servers`, `default-lease-time` and `max-lease-time`. You can configure the other parameters, but the stuff above is considered necessary to let your dhcp server work. After configuration, run `/etc/init.d/isc-dhcp-server restart` to restart your dhcp server. As always, please use sudo.

> * Switch to innet machines, up the `eth1`, and set up each `eth1` to `dhcp`. You can check this [page](http://inside.mines.edu/CCIT-NET-SS-Configuring-a-Dynamic-IP-Address-Debian-Linux) to help.


## <a name="iptables">Iptables</a>

![iptables](http://www.system-rescue-cd.org/images/dport-routing-02.png)

For now, the machines in the subnet are unable to connect the real internet. This is because the gateway does not forward their tcp/udp requests to the outside world. Thus we use `iptables` to tell gateway forwarding them.  

### Steps
1. Configure `losalamos`. Input the following command line,
 `sudo bash -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'`
 `sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE`
 `sudo iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT`
 `sudo iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT`
If the above command lines don't work in your case, please refer to this [HOWTO WIKI](http://www.revsys.com/writings/quicktips/nat.html). If you want to know more about forwarding, check [this](http://www.howtogeek.com/177621/the-beginners-guide-to-iptables-the-linux-firewall/).
Attention: `HOWTO WIKI` is not totally same as our case, according to the image above. `eth0` and `eth1` are supposed to be swapped in our case, compared with the examples in the wiki. Don't overthink the command lines in HOWTO WIKI. Just type in the commands, they are not script.
After configuring iptables, all four machines should be able to connect to the Internet now, you can try to ping www.google.com on all four machines to test your configuration.

You may want to configure the iptables to block some incoming traffic and allow access only to particular protocols and ports. [Here](http://developer-should-know.tumblr.com/post/128018906292/minimal-iptables-configuration) is a quick introduction. Use `iptables -L -v` to check current valid rules. In case you wrongly add a certain rule, use `iptable -D [rules]` to delete a cerain rules, check [this](https://www.digitalocean.com/community/tutorials/how-to-list-and-delete-iptables-firewall-rules) for reference. 

If you block or drop some important ports (i.e., 22, 80, 8080), you might lose the SSH connection or HTTP connection.

## IPtable explanation:
IPtables are like rule books that are used when a connection tries to establish itself on the server. The tables find a matching rule and take the corresponding action or use the default rule if no match is found. In the assignment we could add the `ACCEPT` rule for connections through ports that we know are being used by the required services (Such as port 22 for ssh etc.) and place a default rule to block all connections. Thus all required connections would be allowed and others would automatically be blocked.

It is very important to remember and save the changes that have been made to the iptable, otherwise all the rules will get deleted the next time the ip table servise is restarted. To save the ip table use the following command in Ubuntu:
`sudo /sbin/iptables-save`

To further understand IP tables here are a few good resources:
* [Beginners Guide](http://www.howtogeek.com/177621/the-beginners-guide-to-iptables-the-linux-firewall/)
* [Wikipedia Page](https://en.wikipedia.org/wiki/Iptables)
* [How To Page](https://www.digitalocean.com/community/tutorials/how-to-list-and-delete-iptables-firewall-rules)
* [Minimum Requirements](http://developer-should-know.tumblr.com/post/128018906292/minimal-iptables-configuration)


### Tips

1. If you cannot ping external resources on the inner machines, you can: 1) check if your server is able to ping outside or not; 2) check if the `dns-nameservers` is set in all four configuration files;(In order to resolve DNS host name you should add dns-nameservers line when you configure etc/network/interfaces on four machines as indicated above, otherwise the inner machine can only ping external IP address.) or 3) check carefully the spelling of your configuration files. 4) check `/etc/sysctl.conf` is well modified.
2. When setting the iptable protection, make sure you don't block the SSH. Just set the iptable on the `losalamos` according to the iptable minimum requirements table shown above.
3. When you are setting the iptable protection, if you want to set the REJECT all -- any any anywhere anywhere reject-with icmp-host-prohibited, make sure that you should first accpet the port 22 and port 8080, or you may lose the SSH connection. After that, it might become very slow to connect through SSH but it can still use SSH to connect. So do not panic and be patient.
4. For minimum iptables protection, as you can see in the principle figure above, for the local processes as the host `losalamos`, it seems you can drop some of the PREROUTING, FORWARD, or INPUT. But after attempting, the PREROUTING cannot be changed. Therefore, you can change FORWARD and INPUT for protecting.  After setting, you can also use `nmap losalamos.pc.cs.cmu.edu` and  `nmap losalamos.pc.cs.cmu.edu -Pn` to see the status of the PORT for protecting status checking.
5. Remember when you use a machine outside cluster to SSH in losalamos, you should try `ssh username@losalamos.pc.cs.cmu.edu`. Do #not# use its subnet IP adress. But inside the cluster, each machine can access another through either domain name or subnet IP(10.X.X.X).
6. Apart from the above mentioned ports, remember to also accept the port for the additional service that is required to be enabled (E.g. port 8088 for Zepplin in our case). 
7. The IP tables are stored in memory. You should save their state in case a reboot is required (**Do not** reboot for any reason, if avoidable). [This](http://www.cyberciti.biz/faq/how-do-i-save-iptables-rules-or-settings/) tells you how to do it.
8. It is also a good idea to keep a backup of your command history, in case you want to repeat what you did earlier, or if you want to figure out at which step you were probably going wrong. This can be done using
```bash
history > historyLog
```

## <a name="install-hadoop">Install Hadoop using Ambari</a>

Ambari is a automatical deploy system for Hadoop. [Link to installation]( http://docs.hortonworks.com/HDPDocuments/Ambari-2.2.0.0/bk_Installing_HDP_AMB/bk_Installing_HDP_AMB-20151221.pdf).

For setup, configure and deploy parts, you may also refer to [This](http://blog.phaisarn.com/node/1391) and [This](https://hadoopjournal.wordpress.com/2015/08/09/hortonworks-hadoop-installation-using-apache-ambari-on-centos6/).

### Tips
* Go through the “Getting Ready” section to check and configure if you could meet with the basic environment requirements. Take care of part 1.4.
* It's better to follow the Official installation document. Link has been given above. But for the password-less SSH setting, the links behind in the tips are more detailed(although basically they are the same), you may get puzzled follow the official document.
* **Do not** skip the 1.4 “Prepare the Environment” for the sake of less possible problems in the later installation process:
1. Do 1.4.1 Set Up Password-less SSH use links behind in the tips 
**Note**: The passwordless ssh communication has to be setup between itself and the rest of the 4 hosts(eg:losalamos has to setup the passwordless connection with alpha beta and gamma as well as allow inception into losalamos itself). Copying the same machine’s and other machines id_rsa.pub into the authorized_keys file and replicating that among all the 4 hosts does the trick.

2. no need do 1.4.2: there is default account
3. Do 1.4.3 NTP on all four hosts, there is no ubuntu version command in the official installation document, refer to [here](http://blogging.dragon.org.uk/setting-up-ntp-on-ubuntu-14-04/).
Follow these steps on all four systems:
```
i)
>> sudo apt install ntp

ii)
>> sudo vi /etc/ntp.conf

iii) Change the pool of servers:
*for losalamos*
server 0.north-america.pool.ntp.org
server 1.north-america.pool.ntp.org
server 2.north-america.pool.ntp.org
server 3.north-america.pool.ntp.org 
OR
server 0.us.pool.ntp.org
server 1.us.pool.ntp.org
server 2.us.pool.ntp.org
server 3.us.pool.ntp.org

*for others, put the above lines as well as the one below*
server losalamos.pc.cs.cmu.edu prefer iburst

iv)
watch ntpq -cpe -cas

v)
>> sudo service ntp restart
```
**Note**: You need not wait for the ntp’s configured in individual machines to sync with each other. The ambari installation/setup/cluster install/usage in the later sections don’t fail without the sync.

4. no need do 1.4.4: Offitial installation document gives hosts name and network setting on redhat and centOS. for ubuntu, hostname and network are set in etc/network/interfaces already in the "Establish Subnet" process。
5. no need for 1.4.5: detailed iptable setting guide has been given above.
6. Do 1.4.6 Ubuntu 14 has no selinux pre-installed. Follow the instruction to set umask.
7. You can set ulimit at /etc/security/limits.conf, make sure you change the ulimit of the ACCOUNT YOU USE(e.g root) to install Ambari. **Do not** reboot the system when you finish the ulimit installation. If do, you may need to reinstall the machine.
8. You do not need to do the section 1.5 of "Using a Local Repository"

* [This](http://posidev.com/blog/2009/06/04/set-ulimit-parameters-on-ubuntu/) will help you when setting `ulimit`. Notice that in this instruction, `user` means `[user]`. Thus you need to replace it with your system username.
* While using ulimit, and referring to the link in the above tip, do not reboot the system but make sure to log out of all active sessions and then login to see effective changes by using the command: ulimit -a
* Set up the SSH carefully. After this part being done, you can remotely control those four machines with your own laptop. If you did not install OpenSSH during installation, you can install it using `apt-get install openssh-server`. You can only directly SSH into `losalamos` from the outside, but you can SSH into other machines within `losalamos` (like Inception!).

* You need to set up password-less SSH during the process:
        - Overview for password-less SSH: produce a pair of public key and private key on one host, copy the public key to other hosts, then you could visit those hosts without inputting password. It's like give away your public key to others, you have the access to them.
        - The goal is that you can ssh from any one of the four machines to the root of all (including itself) without typing in password manually.
        - Before you try to set up the password-less SSH, you need to enable ssh root access on Ubuntu 14.04. For detailed instructions, please follow the link: http://askubuntu.com/questions/469143/how-to-enable-ssh-root-access-on-ubuntu-14-04
        - One way to achieve password-less SSH is that: for each node, login as root user by su and put the same copy of rsa key pair in the /.ssh directory of root user account. 
        - The other way is: [allow the SSH login root account](http://askubuntu.com/questions/469143/how-to-enable-ssh-root-access-on-ubuntu-14-04) and then follow [this](http://www.linuxproblem.org/art_9.html) steps in four machines (you need to set the pw-less SSH from a root acount in any machine to another root acount of any other machine, so every username in this example should be replaced by root. You may also check next 3 instruction for reference.And be careful that you should still use `ssh-keygen` while generating key pairs, otherwise it could not ssh the root properly later).
        - A much easier way to achieve password-less SSH from server A to server B (under root account) would be:
        ```
        1. ssh-keygen -t rsa -f ~/.ssh/id_rsa
        2. cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
        3. chmod 700 ~/.ssh && chmod 600 ~/.ssh/*
        4. cat ~/.ssh/id_rsa.pub | ssh root@B 'cat >> .ssh/authorized_keys'
        5. ssh root@B
        ```
        Explaination: The private key is just the key for a server and the pubic key is like a lock that the private key could solve. If you append the public key to the authorized_keys file in the remote server, the private key in current server can match with it automatically and you can ssh to B without password.
        - Be careful when you copy paste the command line from the official guide, there might be extra whitespaces due to pdf format. So double check before running the command.
        - Ubuntu system has no pre-set password for root user, in order to login as root user, you need to set password first, use command -'sudo passwd'
        - The manual from Hortonworks have covered the basic steps. You can also check [this](http://askubuntu.com/questions/497895/permission-denied-for-rootlocalhost-for-ssh-connection) if you need more help.
        - You need to use root permission to set up password-less SSH. To set the root password see [this](http://askubuntu.com/questions/155278/how-do-i-set-the-root-password-so-i-can-use-su-instead-of-sudo).
        - If you change the ssh configuration, you may need to restart ssh by `service ssh restart`.
        - Make sure the password-less SSH works in both directions among four machines: scp the private and public key to the .ssh folder of four machines and modify authorized_key file. Sometimes when you reinstall the cluster, you would encounter a problem that you cannot have the remote connection with the correct ssh key. In this time, you can type `chmod 400`+ key name or vim into the file that store the original key to delete the original one.
        - If something goes wrong with the password-less SSH, you may get timeout error in building cluster. Then try Installing Ambari Agents Manually, look at [this](https://ambari.apache.org/1.2.0/installing-hadoop-using-ambari/content/ambari-chap6-1.html). For Ubuntu, use apt-get instead of yum.
        - You may generate the public key or private key from the user account which is not root, check it carefully or you may not be able to automatically install the hadoop system. The public key and private key is under the file /root/.ssh. .ssh file is invisible file there.
        - When input the private key in the Ambari installation, don't forget to include the first line and last line. It is best to just scp the private key of losalamos to your local system and use it by selecting the file from the GUI.
        - Remember to set id_rsa.pub as authroized_keys in the `losalamos` if you want other slave machines to login using `ssh losalamos`.
        - The Ambari Web Console has by default admin/admin as username/password
        
* If you come accross failure in registering four machines, check:
        - If you set the ssh correctly, and can login in other machine from root@losalamos without password.
        - Use the private key: `id_rsa`. Copy this with `scp` to your laptop beforehand. You could use this [link](http://www.hypexr.org/linux_scp_help.php) for reference. Upload the file. Do not copy paste the key from terminal (there might be extra white-spaces or lines added/missing).
        - All machine, /etc/hosts need to have their FQDN inside. Also, according to Install Documentation, check `hostname -f` is return its FQDN.
* Before Install the services, better to carefully handle the warning from the registeration section. Check whether NTP is intalled.If you meet warings when confirms hosts which said ntp services error, you may check whether you have already started up the ntp on each machine, if not, use this command line 'sudo service ntp start'.
* The services you need to install are `HDFS`, `MapReduce2`, `Yarn`, `ZooKeeper` and  `Ambari Metrics`. Some other services may fail so do not install services that you do not need.
* You need to install both `ambari-server` and `ambari-agent` on `losalamos`, and you only need to install `ambari-agent` on three innet machine,
* But if everything goes smoothly, you only have to manually install `ambari-server` on `losalamos`, and everything else can be done through the [Ambari Web](http://losalamos.pc.cs.cmu.edu:8080) in web browser.
* If any/all of the 'target hosts' fail to register, it might be because of the following problems:
        - **Hostname conflict**. Look for errors in the log. If there is a hostname conflict (eg: expecting alpha.pc.cs.cmu.edu but got alpha), you can change the hostname by using the `hostname <name>` command.
        - Misconfiguration of the ambari agents. Remove the ambari installation and try again with a clean slate. (Not for losalamos)
* While installing `ambari-server` on `losalamos`, java 1.8 will be installed with your choice during the process, but you need to configure the environment variables by yourself this [page](http://stackoverflow.com/questions/9612941/how-to-set-java-environment-path-in-ubuntu) will help on your configurations.
* Your java directory should be under `/usr/jdk64/`. You can find your $JAVA_HOME path in this directory and carefully set it to your configuration file as the previous instruction indicates.
* Remember to use `sudo source /etc/profile` after you modify the environment variables. After that, you should be able to check the version of your java by using `java -version`.
* Sometimes you may encounter the problem when you execute the “source command” and the shell may remind you that “command not found: source”. You can try `source –s <filename>` here. It might works.
* While going through the Ambari Install Wizard, there are several parts you should watch out: 
        - Make sure password-less SSH is correctly set up, which will let you SSH from any one of the four machines to other three without typing in password manually. Otherwise if may gave you failure when registering three inner machines.
	- Make sure to use the host cleanup file if you see package warnings. But make sure the cleanup file is actually deleting the packages that were requested as warnings during the registration process.
        - When choosing services to install, only choose those are required. One safe way to do this is to first install only `HDFS`, `MapReduce2`, `Yarn`, `ZooKeeper` and  `Ambari Metrics`. And go back to install other required services after confirming your hadoop can run correctly by runing a MapReduce task.
        - When assinging master, name node, data node, go through the `Grading Criteria` in `Requirements` section carefully.
        - When install extra service, you should not omit the warning. You need to handle it one by one.
        - Restart the service before runing Demo
* You should be aware of that `losalamos` should be one of the clients since it is the only interface to run Hadoop programs from outside.
* Select default setting when installing Ambari Server.
* During installation, the setup may prompt a warning related to increasing the heap size. Go to the previous page and make all the required changes. On clicking `Next`, the same warning will be shown again. Do not worry about it and proceed to the next step.
* If you come across errors when starting the server, Check [ this](https://community.hortonworks.com/articles/16944/warning-setpgid31734-0-failed-errno-13-permission.html).
* Once the cluster is installed, make sure [this page](http://losalamos.pc.cs.cmu.edu:8080/#/main/hosts) shows each host has correct IP address (10.0.0.x).s If the IP address is 127.0.0.1 that's not correct, check whether the four `/etc/hosts` files are same with each other. Modify `/etc/hosts` if necessary, then restart both ambari-server and all ambari-clients.
* If something goes wrong, check your firewall settings or you may find causes by looking at log files under `/var/log`
* If run into Transparent Huge Pages error, check out [this](https://docs.mongodb.org/manual/tutorial/transparent-huge-pages/).
[this](https://access.redhat.com/solutions/46111). You may first try the following commands to disable THP and see if the problem can be fixed:
```
# echo never > /sys/kernel/mm/transparent_hugepage/enabled
# echo never > /sys/kernel/mm/transparent_hugepage/defrag
```
* For installing Ambari (except for logging into node for debug), you DON'T need to install python2.6, Ambari is compatible with python2.6 or later version.
* If you decide to install python yourself, actually for anything, DO NOT use any personal repository, use official ones. Otherwise it may lead to cluster building failure and probably reinstallation of OS.
* SName Node and Name node should be on different machines. Data Node and Name Node should be on different machines. Name node(Not SName Node) is the primary Name Node.


## <a name="test-mapreduce">Test a MapReduce Program</a>

If everything is green on the dashboard of Ambari, you can follow [this](http://www.joshuaburkholder.com/blog/2014/05/15/how-to-run-ava-mrv2-using-hadoop/) to run a mapreduce job on the machines.

### Steps

1. Create a input directory under the user of `hdfs`(use command `su hdfs`)
2. Write the test MapReduce program (eg. wordcount)
3. Compile the java files to class files with `javac` and archive the class files into `jar`
4. Use command `yarn` to run the project and remember to set the output directory of your project or you will hard to find it
5. Run the program under the user `hdfs` (HADOOP_USER_NAME=hdfs).
6. If you want to move the files to HDFS via Ambari UI, you could follow the steps mentioned [here](https://developer.ibm.com/hadoop/blog/2015/10/22/browse-hdfs-via-ambari-files-view/). Also, it is better to create a separate user 'hdfs' instead of 'admin' in Ambari if you follow this approach and give it root permissions in Ambari.

### Tips

- If you meet any permission problem of `hdfs`, check [this](http://stackoverflow.com/a/20002264/2580825) or try using `sudo`.
- Make sure the file paths provided will creating the jar and running are correct.
- Log in through SSH to `losalamos` and perform all you tests here since this server should be the only interface;
- Switch to other Hadoop users (ex. hdfs, but you can still create a new one) and upload or create your files on HDFS;
- The output folder of your map reduce program should not exist when executing the jar program.
- If there's any "permission" problem, try using su (root), or `sudo` in each command;
- Remember that in MapReduce 2.0, you should use the command `yarn` but not `hadoop`.
- If you have trouble running your wordcount program, you may need to install the Java Jre before. You can choose the default one. 
- If you have already run the wordcount program successfully and want to run it again, make sure to remove two things. The first one is the output folder. Using hdfs 'dfs -rm -r StartsWithCount/output'. And anther one is the previous version's result. Or you may meet problems say 'File exits'.
- If you meet some problems when you try to compile the java files, you might meet some errors. You might need to install or import some libraries. You do not need to reinstall the cluster.
- Make sure to take screenshots of your process since the nodes might fail at any time during the demo if the cluster has been up for some time. 
- Create a new user (mandatory) in the Ambari browser interface by clicking the current user name on the top right → Manage Ambari → Users and Groups and give it Admin access, you will need to use this user since Hadoop does not recognize the other ubuntu users as true admins and you will face issues with accessing the Hadoop filesystem. 
- The files in the link for wget are no longer active. You can copy the content and host the same into a repo to access and perform the wget steps[Job, Mapper and Reducer]

# <a name="pitfall">Pitfalls you should pay attention to</a>
- Make sure the physical connection is correct;
- Make sure you have correctly identified which ethernet port maps to eth0 and which maps to eth1.
- Do not make temporary changes to your environment variables. It leads to complications later on. Use /etc/profile to push all of your environment variables changes.
- You should down/up network adapters or reboot machines to make your network configurations work;
- Make sure your configurations are permanent, otherwise they will remain unchanged after reboot, like iptables;
- Ambari Server should be installed on `losalamos` since it is the only server you can get access to from outside the subnet;
`losalamos` should also hold a Ambari Agent to be part of the cluster;
- Keep in mind that `losalamos` should be one of the clients;
- Make sure you use `ulimit` to change file descriptors limit before installing Ambari, or you may encounter problems in running the cluster.
- If by any chance you mapped the History Server incorrectly, you can change it using the steps given [here](https://cwiki.apache.org/confluence/display/AMBARI/Move+Mapreduce2+History+Server) instead of re-doing everything.
- **Do not** reboot losalamos after installing the OS. If you reboot the losalamos after install the ulimit and lose ssh and net connection, you don't need to restart all the machine. Just the losalamos. Install it from the beginning.
- If you see failures in service setup during cluster creation, specifically saying couldnt find heartbeat to the host, go back to step 3 to make sure the hosts are still active and can be registered without issues. If not try to recreate the cluster using below steps. 
- If you observe package warnings during host registration, use the hostCleanup.py script as prompted repeatedly on the host until you see a message saying that the package has been selected for cleaning. (May need to do this more than 5-6 times)
Check if the required package has been cleaned from the host after every trial just in case the purge message is not getting displayed due to some other reason.
- Edit this instruction file carefully, wrong tips can lead to a huge waste of time of other people.

# <a name="recreate-cluster">How to Re-create the Cluster</a>
In case anything you configured wrong, you might want to rebuild the cluster again. Please follow the below steps.

##(Two groups have indicated that the following 5 steps may cause components of ambari not being able to install and the ambari to fail rebooting, so be careful if you need to reconfigure the server)
1. Stop all services from Ambari first, both in losalamos and 3 slave machines. On slave machines, `sudo ambari-client stop`. On losalamos, do `sudo ambari-client stop` and `sudo ambari-server stop`.
2. Clean installed services on all four machines
`python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py`
3. Stop Ambari Server `sudo ambari-server stop`
3. Reset Ambari Server `sudo ambari-server reset`
4. Start Ambari Server again `sudo ambari-server start`
5. Login to Ambari webpage and create the cluster
If you want to recreate the cluster again and cant do it with the above steps. Use this link instead(**Do not** follow the install/reinstall steps just the removal steps will do). Use apt-get instead of yum for ubuntu. 
https://community.hortonworks.com/questions/1110/how-to-completely-remove-uninstall-ambari-and-hdp.html
If you get messages saying it cant delete some file and that file is still present in ur system, add a line to the above script and force remove these types of files using `rm -rf`.

If you can't create iptables by following the steps above, you can refer to this script created by Hsueh-Hung Cheng [Here](https://gist.github.com/xuehung/8859e7162466918aac82), make sure you understand each line of script (it may not work). When you make use of this script, if there is permission denied alert, try to add `sudo` at the head of most of the lines and refer to the tips in Iptables above to modify the rest one.

# <a name="trubleshoot">Basic Network Troubleshooting</a>
## Troubleshooting Checklist

* Is the interface configured correctly? (Related command or files: ifconfig, /etc/network/interfaces, lspci, lsmod, dmesg)
* Is DNS/hostnames configured correctly? (Related command or files: /etc/hosts, /etc/resolv.conf, bind)
* Are the ARP tables correct? (arp -a)
* Can you ping the localhost? (ping localhost/127.0.0.1)
* Can you ping other local hosts (hosts on the local network) by IP address? How about hostname? (Related command: ping)
* Can you ping hosts on another network (Internet)? (Related command: ping)
All your are doing is going either up or down the network model layers.

## Explanations about several useful command

* `route -n`: To see your routing tables. `-n` means return numeric output
* `ping`: Ping your computer (by address, not host name) to determine that TCP/IP is functioning. You can also use option `-c` to determine how many packets you'are sending.
* `ifconfig`: Tell you everything about the network interface
* `iptables -L -v` Check current valid rule in iptable
* `scp` Please refer to [Here](http://www.hypexr.org/linux_scp_help.php)



