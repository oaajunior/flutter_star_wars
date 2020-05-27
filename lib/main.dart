import 'package:flutter/material.dart';
import 'router.dart' as router;

/* 
** main class of all app.
*/
main() => runApp(StarWarsApp());

class StarWarsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: router.generateRoute,
     );
  }
}
