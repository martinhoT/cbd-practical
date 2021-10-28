# Database organization

**MongoDB stores binary JSON documents (BSON)**. Comparing MongoDB and usual Relational Database Management Systems (RDBMS), we can make the following table relating similar terminology between both:

| RDBMS | MongoDB |
|-------|---------|
| Database | Database |
| Table | Collection |
| Tuple/Row | Document |
| Column | Field |
| Table join | Embedded documents |
| Primary key | Default key _id

# CRUD operations

Some of the operations down below allow for extra arguments (such as Write Concerns) to be passed. For more information on these optional arguments, refer to the proper documentation on the specific function.

## Create

### Databases

```
use <database name>
```

Will also change the current database to the created one (future operations will apply to this database)

### Collections

```
db.createCollection("<collection name>", {<options>})
```
As an alternative, do operations on that collection, such as insert, and it will be created automatically:

```
db.<collection name>.insertOne({...})
```

### Documents

```
> db.<collection name>.insert(...)			(DEPRECATED)
> db.<collection name>.insertOne({...})
> db.<collection name>.insertMany([{...}, ...])
```

Another way of creating documents is through the [save()](#document.save) operation

## Read

### Databases

```
> show dbs
admin   0.000GB
config  0.000GB
local   0.000GB
test    0.000GB
```

Notes: 

- the `test` database can be used, as the name implies, for testing
- only non-empty databases are shown

### Collections

```
> show collections
tutorialspoint
users
```

### Documents

```
db.<collection name>.find({<selection>}, {<projection>})
```

The `selection` argument is used to specify which of the entries to find. In SQL, it's akin to the `WHERE` statement

The `projection` argument is used to specify which of the fields to return from the found entries. In SQL, it's akin to the `SELECT` statement. The projection can either be inclusive or exclusive, **but not both**. In order to do so, specify the desired fields with a boolean value of 1 or 0, where 1 is inclusive and 0 is exclusive

Use the `pretty()` function at the end of `find()` in order to increase the readability of the output

#### Query selectors

| Name | Description | Name | Description |
|------|-------------|------|-------------|
| $eq  | Equal | $and | And |
| $ne  | Not equal | $or | Or |
| $gt  | Greater than | $not | Not |
| $gte | Greater than or equal | $nor | Nor |
| $lt  | Less than | $all | Contains all elements |
| $lte | Less than or equal | $size | Size of array |
| $in  | In an array | $text | Text search |
| $nin | Not in an array | $regex | Match regular expression |

For more, see: [Query and Projection Operators](https://docs.mongodb.com/manual/reference/operator/query/)


#### Example:

```
> db.users.find({ $or: [{"by": "me", "url": "localhost"}, {likes: 100}] }, {"title": 1}).pretty()
{
	"_id" : ObjectId("507f191e810c19729de860ea"),
	"title" : "MongoDB Overview"
}
{ "_id" : ObjectId("617a6c93118fcc73bf17df77"), "title" : "Another one" }
```

## Update

### Databases

Databases can't be "updated". For example, their name can't be changed, since the name is used for referencing the database in many locations, and so a rename operation is very impractical, and infeasible in live production.

### Collections

A collection can be renamed with:

```
db.<collection name>.renameCollection("<new name>", <drop target>)
```

`<drop target>` is optional. It is a boolean value (`true`/`false`), indicating whether or not overwriting existing collections with the new name is allowed (default is `false`)

This operation is not supported on sharded collections

### Documents

#### Update fields

```
db.<collection name>.update({<selection>}, {$set: {<updated_data>})
```

This operation will, by default, only update a single element, but specifying the extra argument `{multi: true}` allows updating multiple documents that match the selection criteria

#### Update entire document {document.save}

```
db.<collection name>.save({"_id": <object id>, <new_data>})
```

##### Example:

```
> db.nosa.find().pretty()
{
	"_id" : ObjectId("507f191e810c19729de860ea"),
	"title" : "MongoDB Overview",
	"description" : "MongoDB is no sql database",
	"by" : "tutorials point",
	"url" : "http://www.tutorialspoint.com",
	"tags" : [
		"mongodb",
		"database",
		"NoSQL"
	],
	"likes" : 100
}
{
	"_id" : ObjectId("617a6c93118fcc73bf17df77"),
	"title" : "Another one",
	"description" : "can't bother",
	"by" : "me",
	"url" : "localhost",
	"tags" : [ ],
	"likes" : "kgosagkao"
}
> db.nosa.save({"_id": ObjectId("507f191e810c19729de860ea"), "title":"MongoDB New Overview"})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
> db.nosa.find().pretty()
{
	"_id" : ObjectId("507f191e810c19729de860ea"),
	"title" : "MongoDB New Overview"
}
{
	"_id" : ObjectId("617a6c93118fcc73bf17df77"),
	"title" : "Another one",
	"description" : "can't bother",
	"by" : "me",
	"url" : "localhost",
	"tags" : [ ],
	"likes" : "kgosagkao"
}

```

#### Other variations

```
> db.<collection name>.findOneAndUpdate({<selection>}, {$set: {<updated_data>}})
> db.<collection name>.updateOne({<selection>}, {$set: {<updated_data>}})
> db.<collection name>.updateMany({<selection>}, {$set: {<updated_data>}})
```

Apparently, the difference between `findOneAndUpdate` and `updateOne` is that `findOneAndUpdate` returns a document and `updateOne` doesn't (it just returns the `_id` if it has created a new document)

## Delete

### Databases

Remove the database that is **currently in use**:

```
db.dropDatabase()
```

### Collections

```
db.<collection name>.drop()
```

### Documents

```
db.<collection name>.remove({<selection>}, <just one>)
```

`<just one>` is an optional boolean argument that limits the deletion to just one document, default is `false`

Specifying an empty `<selection>` (`{}`) deletes **all** documents!

# Misc notes

- Functions in the `mongo` interface are implemented in JavaScript, so their code can be read by inputting the function without parenthesis.