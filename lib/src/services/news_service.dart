import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_flutter/src/models/category_model.dart';
import 'package:news_flutter/src/models/news_models.dart';
import 'package:http/http.dart' as http;


const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY   = 'fe8102bfbb424a839c09241444eafd6f';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'  ),
    Category( FontAwesomeIcons.tv, 'entertainment'  ),
    Category( FontAwesomeIcons.addressCard, 'general'  ),
    Category( FontAwesomeIcons.headSideVirus, 'health'  ),
    Category( FontAwesomeIcons.vials, 'science'  ),
    Category( FontAwesomeIcons.volleyball, 'sports'  ),
    Category( FontAwesomeIcons.memory, 'technology'  ),
  ];

  Map<String, List<Article>> categoryArticles = {};


      
  NewsService() {
    getTopHeadlines();

    for (var item in categories) {
      categoryArticles[item.name] = [];
    }

    getArticlesByCategory( _selectedCategory );
  }

  bool get isLoading => _isLoading;


  String get selectedCategory => _selectedCategory;
  set selectedCategory( String valor ) {
    _selectedCategory = valor;

    _isLoading = true;
    getArticlesByCategory( valor );
    notifyListeners();
  }
  
  List<Article>? get getArticulosCategoriaSeleccionada => categoryArticles[ selectedCategory ];



  getTopHeadlines() async {
    
      const url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
      final resp = await http.get(Uri.parse(url));

      final newsResponse = newsResponseFromJson( resp.body );

      headlines.addAll( newsResponse.articles );

      notifyListeners();
  }

  getArticlesByCategory( String category ) async {

      if ( categoryArticles[category]!.isNotEmpty ) {
        _isLoading = false;
        notifyListeners();
        return categoryArticles[category];
      }

      final url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
      final resp = await http.get(Uri.parse(url));

      final newsResponse = newsResponseFromJson( resp.body );

      categoryArticles[category]?.addAll( newsResponse.articles );

      _isLoading = false;
      notifyListeners();

  }


}




