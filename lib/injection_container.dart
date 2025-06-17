import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'core/network/network_info.dart';

// Features - Auth
import 'modules/auth/data/datasource/auth_local_datasource.dart';
import 'modules/auth/data/datasource/auth_remote_datasource.dart';
import 'modules/auth/data/repository/auth_repository_impl.dart';
import 'modules/auth/domain/repository/auth_repository.dart';
import 'modules/auth/domain/usecase/get_cached_user.dart';
import 'modules/auth/domain/usecase/login_user.dart';
import 'modules/auth/domain/usecase/logout_user.dart';
import 'modules/auth/presentation/bloc/auth_bloc.dart';

// Features - Tasks
import 'modules/tasks/data/datasource/task_local_datasource.dart';
import 'modules/tasks/data/datasource/task_remote_datasource.dart';
import 'modules/tasks/data/repository/task_repository_impl.dart';
import 'modules/tasks/domain/repository/task_repository.dart';
import 'modules/tasks/domain/usecase/add_task.dart';
import 'modules/tasks/domain/usecase/delete_task.dart';
import 'modules/tasks/domain/usecase/get_tasks.dart';
import 'modules/tasks/domain/usecase/update_task.dart';
import 'modules/tasks/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(loginUser: sl(), logoutUser: sl(), getCachedUser: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => GetCachedUser(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sharedPreferences: sl()),
  );

  //! Features - Tasks
  // Bloc
  sl.registerFactory(
    () => TaskBloc(
      getTasks: sl(),
      addTask: sl(),
      updateTask: sl(),
      deleteTask: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<TaskRemoteDatasource>(
    () => TaskRemoteDatasourceImpl(client: sl()),
  );

  sl.registerLazySingleton<TaskLocalDatasource>(
    () => TaskLocalDatasourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  // In the init() function:
  sl.registerLazySingleton(() => Connectivity());
}
