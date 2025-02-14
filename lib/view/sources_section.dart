import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view/bottom_sheet_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utility/helper/network/dio_heper.dart';
import '../view_model/sources_cubit/sources_cubit.dart';
import '../view_model/sources_cubit/sources_state.dart';
import 'news_item.dart';

class SourcesSection extends StatefulWidget {
  final String catId;
  final Function onTap;

  SourcesSection({required this.catId, required this.onTap, Key? key})
      : super(key: key);

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  @override
  void initState() {
    var cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    cubit.getSources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = BlocProvider.of<HomeCubit>(context, listen: false);
        return Column(
          children: [
            if (cubit.sources.isNotEmpty)
              DefaultTabController(
                length: cubit.sources.length,
                child: TabBar(
                  onTap: (index) {
                    cubit.changeSelectedSource(index);
                    cubit.getNewsData(cubit.sources[index].id);
                  },
                  isScrollable: true,
                  indicatorColor: Colors.black,
                  dividerColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.black),
                  tabs: cubit.sources
                      .map((source) => Tab(text: source.name))
                      .toList(),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: cubit.articles.length,
                itemBuilder: (context, index) {
                  final article = cubit.articles[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => BottomSheetItem(
                              imageUrl: article.urlToImage,
                              description: article.description!,
                              onPressed: () async{
                                Uri uri = Uri.parse(article.url!);
                                if (!await launchUrl(uri)) {

                                }else{
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
            ),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}
