import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:work_task/core/utils/assets_manager.dart';
import 'package:work_task/presentation/pages/home_page/cubit/home_cubit.dart';
import 'package:work_task/presentation/pages/home_page/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      context.read<HomeCubit>().fetchUsers();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Lottie.asset(AssetsManager.catAnimation)),
      ),
    );
  }
}
