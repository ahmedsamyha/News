import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view/app_drawer.dart';
import 'package:news/view/search_view.dart';
import 'package:news/view/sources_section.dart';

import '../view_model/sources_cubit/sources_cubit.dart';
import 'categories_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(categoryName ?? "Home"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchView()));
          }, icon: Icon(Icons.search ,color: Colors.black,))
        ],
      ),
      drawer: AppDrawer(onTap: onDrawerClicked),
      body: categoryName == null
          ? CategoriesSection(onTap: onCategoryClicked)
          : SourcesSection(catId: categoryName!, onTap: onDrawerClicked),
    );
  }

  void onDrawerClicked() {
    Navigator.pop(context);
    var cubit = BlocProvider.of<HomeCubit>(context);
    cubit.articles.clear();
    setState(() {
      categoryName = null;
    });
  }

  void onCategoryClicked(String category) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    cubit.categoryName = category;
    setState(() {
      categoryName = category;
    });
    HomeCubit.get(context).getSources();
  }
}
