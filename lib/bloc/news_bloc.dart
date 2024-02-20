import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_9/data/constants/api_key.dart';
import 'package:project_9/data/models/news_model.dart';
import 'package:http/http.dart';

part 'news_event.dart';
part 'news_state.dart';

final http = Client();

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoading());

      try {
        final response = await http.get(
          Uri.parse(
              'https://newsapi.org/v2/everything?q=tesla&from=2024-01-19&sortBy=publishedAt&apiKey=$API_KEY'),
        );
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body)['articles'];
          final List<News> news = jsonData.map((data) => News.fromJson(data)).toList();
          emit(NewsLoaded(articles: news));
        }else {
          emit(const NewsError(errorMessage: 'Failed to fetch news..'));
        }
      } catch (e) {
        emit(NewsError(errorMessage: 'Error: $e'));
      }
    });
  }
}
