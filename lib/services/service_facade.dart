import 'package:yugioh/services/service_index.dart';
import 'package:get_it/get_it.dart';

class ServiceFacade {
  static final _getIt = GetIt.instance;
  static final _apiService = YugiohService();
  static registerDefaultService() {
    _getIt.registerSingleton<YugiohService>(_apiService);
  }

  static T getService<T extends Object>() {
    return _getIt.get<T>();
  }
}
