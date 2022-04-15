import 'package:dartz/dartz.dart';
import 'package:proyek_awal/common/constants.dart';
import 'package:proyek_awal/common/utils.dart';

import 'package:proyek_awal/presentation/pages/movie/about_page.dart';

import 'package:proyek_awal/presentation/pages/movie/movie_detail_page.dart';
import 'package:proyek_awal/presentation/pages/tv/tv_detail_page.dart';

import 'package:proyek_awal/presentation/pages/movie/home_page.dart';
import 'package:proyek_awal/presentation/pages/tv/home_page_tv.dart';

import 'package:proyek_awal/presentation/pages/movie/popular_movies_page.dart';
import 'package:proyek_awal/presentation/pages/tv/popular_tv_page.dart';

import 'package:proyek_awal/presentation/pages/movie/search_page.dart';
import 'package:proyek_awal/presentation/pages/tv/search_page_tv.dart';

import 'package:proyek_awal/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:proyek_awal/presentation/pages/tv/top_rated_tv_page.dart';

import 'package:proyek_awal/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:proyek_awal/presentation/pages/tv/watchlist_tv_page.dart';

import 'package:proyek_awal/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/tv_detail_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/movie_list_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/tv_list_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/movie_search_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/tv_search_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/popular_tv_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/top_rated_tv_notifier.dart';

import 'package:proyek_awal/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:proyek_awal/presentation/provider/tv/watchlist_tv_notifier.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek_awal/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //movie
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        //tv
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case TvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvPage());

            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());

            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());

            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );

            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchPageTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTv());

            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());

            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
