# pymongo tutorial

First start mongodb in the server by `mongod`

### Making a Connection with MongoClient
The first step when working with PyMongo is to create a MongoClient to the running mongod instance. Doing so is easy:

```
from pymongo import MongoClient
client = MongoClient()
```

The above code will connect on the default host and port.


### Getting a Database
A single instance of MongoDB can support multiple independent databases. When working with PyMongo you access databases using attribute style access on MongoClient instances:

```
db = client.test_database
```


### Getting a Collection
A collection is a group of documents stored in MongoDB, and can be thought of as roughly the equivalent of a table in a relational database. Getting a collection in PyMongo works the same as getting a database:

```
collection = db.test_collection
```

An important note about collections (and databases) in MongoDB is that they are created lazily - none of the above commands have actually performed any operations on the MongoDB server. Collections and databases are created when the first document is inserted into them.

### Loading json

Use `insert_many()`. [Doc](http://api.mongodb.org/python/current/api/pymongo/collection.html#pymongo.collection.Collection.insert_many)