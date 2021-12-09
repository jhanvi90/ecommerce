

import 'package:ecommercee/model/productmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String ProductTable = 'Product_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPrice = 'price';
  String colQty = 'qty';
  String colImage = 'image';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'productDatabase.db';

    // Open/create the database at a given path
    var ProductsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return ProductsDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $ProductTable('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $colTitle TEXT, '
        '$colPrice TEXT, '
        '$colQty TEXT, '
        '$colImage TEXT)');
  }

  // Fetch Operation: Get all Product objects from database
  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await this.database;

    var result = await db.query(ProductTable);
    return result;
  }

  Future<List<Product>> getProductList() async {
    var ProductMapList = await getProductMapList(); // Get 'Map List' from database
    int count = ProductMapList.length; // Count the number of map entries in db table

    List<Product> ProductList = [];
    // For loop to create a 'Product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      ProductList.add(Product.fromMapObject(ProductMapList[i]));
    }

    return ProductList;
  }
  // Insert a Product object to database
  Future<int> insertProduct(Product Product) async {
    Database db = await this.database;
    var result = await db.insert(ProductTable, Product.toMap());
    return result;
  }


  //  number of Product objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $ProductTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}








