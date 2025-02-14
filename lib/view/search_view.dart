import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view_model/sources_cubit/sources_cubit.dart';
import 'package:news/view_model/sources_cubit/sources_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utility/helper/network/dio_heper.dart';
import 'bottom_sheet_item.dart';
import 'news_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              onChanged: (value){
                BlocProvider.of<HomeCubit>(context).search(value);
              },
              controller: searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search'
              ),
            ),
          ),
          BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              final cubit = BlocProvider.of<HomeCubit>(context);
              return Expanded(
                child: ListView.builder(
                  itemCount: cubit.searchList.length,
                  itemBuilder: (context, index) {
                    final article = cubit.searchList[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                BottomSheetItem(
                                    imageUrl: article.urlToImage,
                                    description: article.description!,
                                    onPressed: () async {
                                      Uri uri = Uri.parse(article.url!);
                                      if (!await launchUrl(uri)) {

                                      } else {
                                        await launchUrl(uri);
                                      }
                                    }));
                      },
                      child: NewsItem(
                        title: article.title ?? 'No title',
                        description: article.description ?? 'No description',
                        author: article.author ?? 'Unknown',
                        date: article.publishedAt?.substring(0, 10) ??
                            'Unknown date',
                        imageUrl: article.urlToImage,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
