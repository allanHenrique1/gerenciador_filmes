import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/filme_controller.dart';
import 'views/filme_list_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FilmeController())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Filmes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FilmeListView(),
    );
  }
}
