import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:restaurant_v2/data/models/restaurant_detail_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
    sqfliteFfiInit();
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = await openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             city TEXT,
             address TEXT,
             pictureId TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertFavorite(RestaurantDetailModel restaurantModel) async {
    final db = await database;
    await db!.insert(_tblFavorite, {
      'id': restaurantModel.restaurant.id,
      'name': restaurantModel.restaurant.name,
      'description': restaurantModel.restaurant.description,
      'city': restaurantModel.restaurant.city,
      'address': restaurantModel.restaurant.address,
      'pictureId': restaurantModel.restaurant.pictureId,
      'rating': restaurantModel.restaurant.rating,
    });

    // Insert kategori
    for (Category category in restaurantModel.restaurant.categories) {
      await db.insert(
        'categories',
        {
          'id': category.name,
          'restaurantId': restaurantModel.restaurant.id,
          'name': category.name
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Insert menu
    for (Category food in restaurantModel.restaurant.menus.foods) {
      await db.insert(
        'foods',
        {
          'id': food.name,
          'restaurantId': restaurantModel.restaurant.id,
          'name': food.name
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    for (Category drink in restaurantModel.restaurant.menus.drinks) {
      await db.insert(
        'drinks',
        {
          'id': drink.name,
          'restaurantId': restaurantModel.restaurant.id,
          'name': drink.name
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Insert Customer Review
    for (CustomerReview review in restaurantModel.restaurant.customerReviews) {
      await db.insert(
        'customer_reviews',
        {
          'id':
              '${restaurantModel.restaurant.id}_${review.name}_${review.date}',
          'restaurantId': restaurantModel.restaurant.id,
          'name': review.name,
          'review': review.review,
          'date': review.date,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<RestaurantDetailModel>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) {
      return RestaurantDetailModel(
        error: false,
        message: '',
        restaurant: DetailRestaurant(
          id: res['id'],
          name: res['name'],
          description: res['description'],
          city: res['city'],
          address: res['address'],
          pictureId: res['pictureId'],
          rating: res['rating'].toDouble(),
          categories: [],
          menus: Menus(foods: [], drinks: []),
          customerReviews: [],
        ),
      );
    }).toList();
  }

  Future<Map<String, dynamic>> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.isNotEmpty ? results.first : {};
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
