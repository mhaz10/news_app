import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/moduls/search/search_screen.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';
import '../models/category_data.dart';
import '../shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        if (state is NewsGetDataErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {

        var newsList =  NewsCubit.get(context).news;
        var categoriesList =  getCategories();

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'News',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                    ),
                  ),
                  SizedBox(width: 4,),
                  Text(
                    'App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      NewsCubit.get(context).changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4))
              ],
            ),

            body: ConditionalBuilder(
              condition: state is! NewsGetDataLoadingState,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 14),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoriesList.length,
                        itemBuilder: (context, index) => categoryItem(categoriesList[index], context)),
                    ),

                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsList.length,
                      itemBuilder: (context, index) => articleItem(newsList[index], context),
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        indent: 14,
                        endIndent: 14,
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
        );
      },
    );
  }
}
