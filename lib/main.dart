import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view/Splashview.dart';
import 'package:news/view/home_screen.dart';
import 'package:news/view_model/sources_cubit/sources_cubit.dart';

import 'core/utility/helper/network/dio_heper.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(apiService: ApiService(dio: Dio()))..getSources()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
