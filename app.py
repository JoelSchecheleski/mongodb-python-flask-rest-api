#import pymongo
#client = pymongo.MongoClient("mongodb+srv://admin:Mongo%40pass1@ro-cluster0-ayzbp.azure.mongodb.net/test?retryWrites=true&w=majority")
#print(client.list_database_names())

from flask import Flask
from flask import jsonify
from flask import request
from flask_pymongo import PyMongo

app = Flask(__name__)

app.config['MONGO_DBNAME'] = 'superstoremerchDb'
app.config['MONGO_URI'] = 'mongodb+srv://admin:Mongo%40pass1@ro-cluster0-ayzbp.azure.mongodb.net/superstoremerchDb?retryWrites=true&w=majority'

mongo = PyMongo(app)

#GET all products
@app.route('/product', methods=['GET'])
def get_all_products():
  product = mongo.db.products
  output = []
  for p in product.find():
    output.append({'ID' : p['ID'], 'Name' : p['Name']})
  return jsonify({'result' : output})

if __name__ == '__main__':
    app.run(debug=True)