import 'package:flutter/material.dart';
import 'package:proyek_awal/presentation/pages/movie/about_page.dart';
import 'package:proyek_awal/presentation/pages/movie/home_page.dart';
import 'package:proyek_awal/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:proyek_awal/presentation/pages/tv/home_page_tv.dart';
import 'package:proyek_awal/presentation/pages/tv/search_page_tv.dart';
import 'package:proyek_awal/presentation/pages/tv/watchlist_tv_page.dart';

Widget BuildDrawer(context) {
  return Drawer(
    child: Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Movies'),
          onTap: () {
            Navigator.pushNamed(context, HomePage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: const Icon(Icons.tv),
          title: const Text('Tv'),
          onTap: () {
            Navigator.pushNamed(context, TvPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist Movie'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Watchlist Tv'),
          onTap: () {
            Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    ),
  );
}
