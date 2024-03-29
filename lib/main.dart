import 'package:book_reading_app/providers/books.dart';
import 'package:book_reading_app/providers/bookshelf.dart';
import 'package:book_reading_app/providers/categories.dart';
import 'package:book_reading_app/providers/nyt.dart';
import 'package:book_reading_app/screens/bookshelf_screen.dart';
import 'package:book_reading_app/screens/home_screen.dart';
import 'package:book_reading_app/screens/search_screen.dart';
import 'package:book_reading_app/screens/specific_search_screen.dart';
import 'package:book_reading_app/services/connectivity_service.dart';
import 'package:book_reading_app/services/connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Books(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => NYT(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Bookshelf(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Categories(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (BuildContext context) =>
          ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.Online,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        initialRoute: HomeScreen.routeName,
        routes: {
          SearchScreen.routeName: (context) => SearchScreen(),
          BookShelfScreen.routeName: (context) => BookShelfScreen(),
          SpecificSearchScreen.routeName: (context) => SpecificSearchScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}
