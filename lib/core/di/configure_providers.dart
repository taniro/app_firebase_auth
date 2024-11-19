import 'package:app_firebase_auth/services/auth_service.dart';
import 'package:app_firebase_auth/services/store_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class ConfigureProviders {

  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {

    final authService = AuthService();
    final storeService = StoreService();

    return ConfigureProviders(providers: [
      Provider<AuthService>.value(value: authService),
      Provider<StoreService>.value(value: storeService)
    ]);
  }
}