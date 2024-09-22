import 'package:appetite/core/constants/constants.dart';
import 'package:appetite/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 281, name: MOBILE),
            const Breakpoint(start: 281, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 768, name: TABLET),
            const Breakpoint(start: 769, end: 1000, name: TABLET),
            const Breakpoint(start: 1000, end: 1280, name: DESKTOP),
            const Breakpoint(start: 1280, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) {
            return MaxWidthBox(
              maxWidth: 1200,
              backgroundColor: AppColor.backgroundGrey,
              child: ResponsiveScaledBox(
                width: ResponsiveValue<double>(context, conditionalValues: const [
                  Condition.equals(name: MOBILE, value: 280),
                  Condition.between(start: 800, end: 1100, value: 800),
                  Condition.between(start: 1000, end: 1200, value: 1000),
                ]).value,
                child: BouncingScrollWrapper.builder(context, const HomePage(), dragWithMouse: true),
              ),
            );
          });
        },
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
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
