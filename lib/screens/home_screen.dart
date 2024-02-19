import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_9/bloc/news_bloc.dart';
import 'package:project_9/data/models/news_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            centerTitle: true,
          ),
          body: Center(
            child: state is NewsLoading
                ? const CircularProgressIndicator()
                : state is NewsLoaded
                    ? _buildNewsList(state.articles)
                    : state is NewsError
                        ? Text('Error : ${state.errorMessage}')
                        : const Text('No new available'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<NewsBloc>().add(FetchNewsEvent());
            },
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }

  Widget _buildNewsList(List<News> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ListTile(
          title: Text(article.title),
          subtitle: Text(article.description),
          onTap: () {},
        );
      },
    );
  }
}
