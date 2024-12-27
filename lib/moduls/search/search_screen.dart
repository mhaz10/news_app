import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        var searchList =  NewsCubit.get(context).searchNews;

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  searchList.clear();
                },
                icon: Icon(Icons.arrow_back_ios)),
            title: searchBox(
              controller: controller,
              hintText: 'Search',
              onChange: (value){
                NewsCubit.get(context).getSearchNews(value);
              }
            ),
          ),

          body: ConditionalBuilder(
              condition: searchList.length != 0,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => articleItem(searchList[index], context ),
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    indent: 14,
                    endIndent: 14,
                  ),
                  itemCount: searchList.length),
              fallback: (context) => Center(child: Text('There are no results to display', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),),),
        );
      },
    );
  }
}
