import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/theme/theme.dart';
import '../../models/article_model.dart';
import '../network/remote/dio_helper.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<Article> news = [];

  void getNews() {
    emit(NewsGetDataLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'apiKey': apiKey,
      },
    ).then((value) {
      if (value.data['articles'] != null) {

        news = (value.data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();

        emit(NewsGetDataSuccessState());
      } else {
        emit(NewsGetDataErrorState("No articles found."));
      }
    }).catchError((error) {
      print("Error fetching news: $error");
      emit(NewsGetDataErrorState(error.toString()));
    });
  }

  List<Article> categoriesNews = [];

  void getCategoriesNews(String? category) {
    emit(NewsGetCategoryLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category' : category,
        'apiKey': apiKey,
      },
    ).then((value) {

      if (value.data['articles'] != null) {
        categoriesNews = (value.data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();

        emit(NewsGetCategorySuccessState());
      } else {
        emit(NewsGetCategoryErrorState("No articles found."));
      }
    }).catchError((error) {
      print("Error fetching news: $error");
      emit(NewsGetCategoryErrorState(error.toString()));
    });
  }

  List<Article> searchNews = [];

  void getSearchNews(String? search) {

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'q' : search,
        'apiKey': apiKey,
      },
    ).then((value) {

      if (value.data['articles'] != null) {
        searchNews = (value.data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();

        emit(NewsGetSearchSuccessState());
      } else {
        emit(NewsGetSearchErrorState("No articles found."));
      }
    }).catchError((error) {
      print("Error fetching news: $error");
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  ThemeData themeData = lightMode;

  void changeAppMode () {
    if (themeData == lightMode) {
      themeData = darkMode;
      emit(ChangeAppMode());
    } else {
      themeData = lightMode;
      emit(ChangeAppMode());
    }
  }

}
