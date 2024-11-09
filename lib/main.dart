import 'package:employee_management/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/employee/data/datasources/hive_database.dart';
import 'features/employee/presentation/cubit/custom_date_picker_cubit.dart';
import 'features/employee/presentation/pages/employee_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveDatabase = HiveDatabase();
  await hiveDatabase.initDatabase();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              EmployeeBloc(database: hiveDatabase)..add(LoadEmployees())),
      BlocProvider(create: (_) => DatePickerCubit(DateTime.now())),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            primary: Colors.blue,
            secondary: Colors.white,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          )
          // useMaterial3: true,
          ),
      home: const EmployeeScreen(),
    );
  }
}
