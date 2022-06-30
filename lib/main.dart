import 'package:appetite/core/constants/constants.dart';
import 'package:appetite/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/blocs/blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MenuBloc()..add(LoadMenu()),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.title,
        theme: ThemeData(
          primarySwatch: AppColor.primarySwatch,
          fontFamily: AppStrings.fontFamily,
          scaffoldBackgroundColor: AppColor.background,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColor.text,
            displayColor: AppColor.text,
            fontFamily: AppStrings.fontFamily,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
