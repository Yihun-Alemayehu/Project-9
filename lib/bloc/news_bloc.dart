import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_9/data/models/news_model.dart';
import 'package:http/http.dart';

part 'news_event.dart';
part 'news_state.dart';

final http = Client();

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async{
      emit(NewsLoading());

      try {
        final response = await http.get(Uri.parse('uri'));
        
      } catch (e) {
        
      }
    });
  }
}
