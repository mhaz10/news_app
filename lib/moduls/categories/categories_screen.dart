import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/news_state.dart';

import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  final String? category;

  const CategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        var categoryList = NewsCubit.get(context).categoriesNews;
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(category!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: ConditionalBuilder(
            condition: state is! NewsGetCategoryLoadingState,
            builder: (context) =>
                ListView.separated(
                    itemBuilder: (context, index) => articleItem(categoryList[index], context),
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      indent: 14,
                      endIndent: 14,
                    ),
                    itemCount: categoryList.length),
            fallback: (context) =>
                Center(child: CircularProgressIndicator(),),),

        );
      },
    );
  }
}
