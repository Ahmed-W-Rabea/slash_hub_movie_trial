import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slashhub_test/core/constatnts/constants.dart';
import 'package:slashhub_test/features/homeScreen/presentation/pages/home_screen.dart';
import 'package:slashhub_test/features/search/presentation/pages/search_screen.dart';

class MovieMainScreen extends StatefulWidget {
  const MovieMainScreen({super.key});

  @override
  State<MovieMainScreen> createState() => CinemaMainScreenState();
}

class CinemaMainScreenState extends State<MovieMainScreen> {
  List<IconData> bottomIcons = [
    Icons.home_filled,
    CupertinoIcons.search,
    CupertinoIcons.ticket_fill,
    Icons.person_rounded,
  ];

  int currentIndex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    page = [
      const HomeScreen(),
      const SearchScreen(),
      navBarPage(CupertinoIcons.ticket_fill),
      navBarPage(Icons.person_rounded),
    ];
    super.initState();
  }

  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      bottomNavigationBar: SizedBox(
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            bottomIcons.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: currentIndex == index ? 25 : 0,
                    width: currentIndex == index ? 25 : 0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          spreadRadius: currentIndex == index ? 10 : 0,
                          blurRadius: currentIndex == index ? 15 : 0,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    bottomIcons[index],
                    color: currentIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: page[currentIndex],
    );
  }

  navBarPage(iconNmae) {
    return Center(
      child: Icon(
        iconNmae,
        size: 100.w.h,
        color: Colors.white,
      ),
    );
  }
}
