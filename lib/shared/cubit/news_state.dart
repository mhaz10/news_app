abstract class NewsState {}

final class NewsInitialState extends NewsState {}

final class NewsGetDataLoadingState extends NewsState {}

final class NewsGetDataSuccessState extends NewsState {}

final class NewsGetDataErrorState extends NewsState {
  final String error;
  NewsGetDataErrorState(this.error);
}


final class NewsGetCategoryLoadingState extends NewsState {}

final class NewsGetCategorySuccessState extends NewsState {}

final class NewsGetCategoryErrorState extends NewsState {
  final String error;
  NewsGetCategoryErrorState(this.error);
}

final class NewsGetSearchSuccessState extends NewsState {}

final class NewsGetSearchErrorState extends NewsState {
  final String error;
  NewsGetSearchErrorState(this.error);
}

final class ChangeAppMode extends NewsState {}
