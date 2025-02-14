import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/utility/helper/network/dio_heper.dart';
import 'package:news/view_model/sources_cubit/sources_state.dart';

import '../../model/NewsDataResponse.dart';
import '../../model/source_response.dart';

class HomeCubit extends Cubit<HomeStates> {
  SourceResponse? sourceResponse;
  NewsDataResponse? newsDataResponse;
  final ApiService apiService;
  int selectedIndex = 0;
  List<SourceResponse> sources = [];
  List<Articles> articles = [];
  List<Articles> searchList = [];
  late String categoryName;
  HomeCubit({required this.apiService}) : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void changeSelectedSource(int index) {
    selectedIndex = index;
    emit(ChangeSelectedSourceState());
  }

  Future<void> getSources() async {
    emit(GetSourcesLoadingState());
    try {
      var data = await apiService.get(endPoint: 'top-headlines/sources?category=$categoryName');
      var sourcesList = data['sources'] as List;
      sources = sourcesList.map((item) => SourceResponse.fromJson(item)).toList();
      emit(GetSourcesSuccessState());
      print('Fetched ${sources.length} sources');
    } catch (e) {
      emit(GetSourcesErrorState(error: e.toString()));
      print('Failed to fetch sources: $e');
    }
  }
  Future<void> search(String title) async {
    emit(SearchLoadingState());
    try {
      var data = await apiService.get(endPoint: 'everything?q=$title');
      var articlesList = data['articles'] as List;
      searchList = articlesList.map((item) => Articles.fromJson(item)).toList();
      emit(SearchSuccessState());
      print('Fetched ${searchList.length} articles');
    } catch (e) {
      emit(SearchErrorState(error: e.toString()));
      print('Failed to fetch articles: $e');
    }
  }



  Future<void> getNewsData(String sourceId) async {
    emit(GetNewsDataLoadingState());
    try {
      var data = await apiService.get(endPoint: 'top-headlines?sources=$sourceId');
      var articlesList = data['articles'] as List;
      articles = articlesList.map((item) => Articles.fromJson(item)).toList();
      emit(GetNewsDataSuccessState());
      print('Fetched ${articles.length} articles');
    } catch (e) {
      emit(GetNewsDataErrorState(error: e.toString()));
      print('Failed to fetch articles: $e');
    }
  }
}


