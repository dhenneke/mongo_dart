#import("../lib/mongo.dart");
#import("../lib/bson/bson.dart");
#import("dart:builtin");

main(){
  Db db = new Db("mongo-dart-blog");
  print("Connecting to ${db.serverConfig.host}:${db.serverConfig.port}");
  db.open();
  
  MCollection collection = db.collection('test-types');
  collection.remove();  
  collection.insert({
    'array':[1,2,3], 
    'string':'hello', 
    'hash':{'a':1, 'b':2}, 
    'date':new Date.now(),          // Stores only milisecond resolution
    'oid':new ObjectId(),
    'binary':new Binary.from([0x23,0x24,0x25]),
    'int':42,
    'float':33.3333,
//    'regexp':/foobar/i,
//    'regexp2':/foobar2/,
    'boolean':true,
    'where':new BsonCode('this.x == 3'),
//    'dbref':new BSON.DBRef(collection.collectionName, new BSON.ObjectID()),
    'null':null
    });
  collection.findOne().then((v){    
    print(v);  
    db.close();  
  }); 
  
}  