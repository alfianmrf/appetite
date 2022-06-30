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
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1280,
          minWidth: 280,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(280, name: MOBILE),
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(768, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1280, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(3200, name: "4K"),
          ],
          background: Container(color: AppColor.backgroundGrey),
        ),
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
