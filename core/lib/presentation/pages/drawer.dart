// import 'package:flutter/material.dart';
// import 'package:about/about.dart';
// import 'package:core/utils/routes.dart';
// import 'package:movie/presentation/pages/home_page.dart';
// import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
// import '../../../presentation/pages/tv/home_page_tv.dart';
// import 'package:search/presentation/pages/tv/search_page_tv.dart';
// import 'package:watchlist/presentation/pages/watchlist_tv_page.dart';

// Widget BuildDrawer(context) {
//   return Drawer(
//     child: Column(
//       children: [
//         const UserAccountsDrawerHeader(
//           currentAccountPicture: CircleAvatar(
//             backgroundImage: AssetImage('assets/circle-g.png'),
//           ),
//           accountName: Text('Ditonton'),
//           accountEmail: Text('ditonton@dicoding.com'),
//         ),
//         ListTile(
//           leading: const Icon(Icons.movie),
//           title: const Text('Movies'),
//           onTap: () {
//             Navigator.pushNamed(context, HOME_PAGE_MOVIE);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.tv),
//           title: const Text('Tv'),
//           onTap: () {
//             Navigator.pushNamed(context, HOME_PAGE_TV);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.save_alt),
//           title: const Text('Watchlist Movie'),
//           onTap: () {
//             Navigator.pushNamed(context, WATCHLIST_MOVIE);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.save_alt),
//           title: const Text('Watchlist Tv'),
//           onTap: () {
//             Navigator.pushNamed(context, WATCHLIST_TV);
//           },
//         ),
//         ListTile(
//           onTap: () {
//             Navigator.pushNamed(context, WATCHLIST_TV);
//           },
//           leading: const Icon(Icons.info_outline),
//           title: const Text('About'),
//         ),
//       ],
//     ),
//   );
// }
