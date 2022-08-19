import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inu_stream_ios/components/featured_content.dart';
import 'package:inu_stream_ios/components/recently_released.dart';
import 'package:inu_stream_ios/pages/search_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  final screens = [
    CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: FeaturedContent(),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: Text(
              'Recently Released',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FutureBuilder<http.Response>(
            future: http.get(Uri.parse(
                'https://consumet-api.herokuapp.com/anime/zoro/recent-episodes')),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RecentlyReleased(
                  recentJson: jsonDecode(snapshot.data!.body)['results'],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 160.0,
          ),
        )
      ],
    ),
    const SearchPage(),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xff16151A),
      body: DefaultTabController(
        length: screens.length,
        child: TabBarView(
          controller: _tabController,
          children: screens,
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(30.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        height: 70.0,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20.0)),
        child: GNav(
          rippleColor: Color(0xff242023),
          hoverColor: Color(0xff242023),
          gap: 8,
          activeColor: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Color(0xff242023),
          color: Colors.white,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.house,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: 'Search',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              _tabController.index = index;
            });
          },
        ),
      ),
    );
  }
}
