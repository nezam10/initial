import 'package:flutter/foundation.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();
  static final String baseUrl = dotenv.get('BASE_URL', fallback: null);
  static final kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';
  static String sandboxBaseUrl = dotenv.get('sendBoxPaypalBaseUrl');
  static String stripBaseUrl = dotenv.get('stripeBaseUrl');
}
