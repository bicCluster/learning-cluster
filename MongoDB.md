# Instructions for initialling MongoDB

For this assignment, you can install MongoDB Community Edition for all of the function required. The specific instructions about installation is as follow.

1. Import the public key used by package management system of Ubuntu.
You can do this by any package management tools for importing the public key. Here is an example using apt:
> * sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

2. Create a list file for MongoDB.
Since we are using Ubuntu 14 in the cluster, you can use this command to create the list file.
> * echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

3. Reload local package database.
This can be simplely done by:
> * sudo apt-get update

4. Install MongoDB packages
Now you can finally get the MongoDB package and install it! The command is simple:

> * sudo apt-get install -y mongodb-org

If you want to install a specific version of MongoDB, please follow the format like this:

> * sudo apt-get install -y mongodb-org=3.2.3 mongodb-org-server=3.2.3 mongodb-org-shell=3.2.3 mongodb-org-mongos=3.2.3 mongodb-org-tools=3.2.3

# Instructions for running MongoDB

Now that you have successfully install MongoDB in your cluster, let's go over some easy commands to run MongoDB.

1. To start MongoDB, you can use the start command:

> * sudo service mongod start

2. To stop it, just use stop:

> * sudo service mongod stop

3. You can also restart using the restart command

> * sudo service mongod restart

4. For more instructions on how to use the mongo shell, please refer to [this](https://docs.mongodb.org/manual/mongo/)
