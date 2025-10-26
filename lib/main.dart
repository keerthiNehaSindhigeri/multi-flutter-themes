import 'package:custom_app_scaffold/custom_app_scaffold.dart';
import 'package:custom_app_scaffold/dynamic_theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var colors = [Color(0xFFC63F17), Color(0xFF6DB5A6), Color(0xFFFBC02D)];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: true,
      showAppBar: true,
      sliverShadowColor: Colors.black.withValues(alpha: 0.5),
      sliverBaseColor: Colors.white,
      themeType: ThemeData.light(useMaterial3: true),
      showTransparentSliverAppBar: true,
      backgroundGradient: [Color(0xFFE2D3F3), Colors.white, Colors.white],
      centerSliverWidget: Text(
        "Multi Theme App Scaffold",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      sliverToBoxAdapter: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Gap(50),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DynamicThemeScreen(color: colors[index]),
                    ),
                  );
                },
                child: Card(
                  color: colors[index],
                  // surfaceTintColor: colors[index],
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(child: Text("View Next Theme ${index + 1}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                  ),
                ),
              );
            },
          ),
          Gap(20),
              ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4,),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("item ${index + 1}"),
              ));
            },
          ),
        ],
      ),
    );
  }
}
