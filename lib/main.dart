import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_flutter/src/theme/tema.dart';
import 'package:provider/provider.dart';

import 'src/pages/tabs_page.dart';
import 'src/services/news_service.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light );

    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewsService() ),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: const TabsPage()
      ),
    );
  }
}