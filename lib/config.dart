import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get flutterDbUrl => dotenv.env['FIREBASE_DB_URL'] ?? '';
}
