import 'package:flutter_mvvm_project/app/app_prefs.dart';
import 'package:flutter_mvvm_project/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_project/data/network/app_api.dart';
import 'package:flutter_mvvm_project/data/network/dio_factory.dart';
import 'package:flutter_mvvm_project/data/network/network_info.dart';
import 'package:flutter_mvvm_project/data/repository/repository_impl.dart';
import 'package:flutter_mvvm_project/domain/repository/repository.dart';
import 'package:flutter_mvvm_project/domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm_project/presentation/views_models/login_view_model/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //
  final sharePrefs = await SharedPreferences.getInstance();
  //* shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(
    () => sharePrefs,
  );

  //* app prefs instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(instance()),
  );

  final dataConnectionChecker = InternetConnectionChecker();
  //* network info instance
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementor(dataConnectionChecker),
  );

  //* dio factory instance
  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(instance()),
  );

  // final dioFactory = DioFactory(instance());
  // final dio = await dioFactory.getDio();

  //dio-instance using get_it package
  final dio = await instance<DioFactory>().getDio();
  //* app service client instance
  instance.registerLazySingleton<AppServieceClient>(
    () => AppServieceClient(dio),
  );

  //* remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImplementer(instance()),
  );

  //* repository instance
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance(), instance()),
  );
}

initLogin() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
