import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/moduls/web_view/web_view.dart';
import 'package:news_app/shared/cubit/news_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/article_model.dart';
import '../../moduls/categories/categories_screen.dart';

Widget articleItem(Article article, context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WebViewScreen(url: article.articleUrl),));
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConditionalBuilder(
          condition: article.imageUrl.isNotEmpty,
          builder: (context) => Container(
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.only(
              top: 20.0,
              left: 14.0,
              right: 14.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(article.imageUrl),
                onError: (exception, stackTrace) => const SizedBox(),
              )
            ),
          ),
          fallback: (context) => Container(
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.only(
              top: 20.0,
            ),
            child: Center(child: Icon(Icons.image_not_supported, color: Colors.grey, size: 40),),),
          ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 8.0,
            left: 14.0,
            right: 14.0,
            bottom: 8,
          ),
          child: Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}


Widget categoryItem (CategoryModel category, context) {
  return GestureDetector(
    onTap: (){
      NewsCubit.get(context).getCategoriesNews(category.categoryName);
      Navigator.push(context,
          MaterialPageRoute(builder:
              (context) => CategoriesScreen(category: category.categoryName,),));
    },
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text('${category.categoryName}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
    ),
  );
}


Widget searchBox({
  TextEditingController? controller,
  ValueChanged<String>? onChange,
  String? hintText,
}) => TextFormField(
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration.collapsed(hintText:hintText),autofocus: true);