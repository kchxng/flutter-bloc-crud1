import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketbooking_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketbooking_app/modules/auth/presentation/bloc/auth_event.dart';
import 'package:ticketbooking_app/modules/auth/presentation/bloc/auth_state.dart';
import 'package:ticketbooking_app/modules/auth/presentation/pages/login_page.dart';
import 'package:ticketbooking_app/modules/auth/presentation/pages/task_list_page.dart';
import 'package:ticketbooking_app/modules/tasks/presentation/bloc/task_bloc.dart';
import 'package:ticketbooking_app/modules/tasks/presentation/bloc/task_event.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(CheckAuthStatus()),
        ),
        BlocProvider<TaskBloc>(
          create: (_) => di.sl<TaskBloc>()..add(GetTasksRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter CRUD Clean Architecture',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthAuthenticated) {
              return const TaskListPage();
            } else {
              return const LoginPage();
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}