import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:work_task/core/Di/service_locator.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';
import 'package:work_task/presentation/pages/splash_page/splash_view.dart';

import 'core/constans/bloc_observable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await init();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        lazy: false,
        create: (context) => getItInstance<HomeCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,background: Colors.white),
            useMaterial3: false,
            dialogBackgroundColor: Colors.white,
          ),
          home: const SplashView(),
        ),
      ),
    );
  }
}
