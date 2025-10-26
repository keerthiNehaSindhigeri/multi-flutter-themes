import 'package:custom_app_scaffold/custom_app_scaffold.dart';
import 'package:flutter/material.dart';

class DynamicThemeScreen extends StatefulWidget {
  final Color color;
  const DynamicThemeScreen({super.key,
   required this.color,
  });

  @override
  State<DynamicThemeScreen> createState() => _DynamicThemeScreenState();
}

class _DynamicThemeScreenState extends State<DynamicThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      themeType: ThemeData.dark(useMaterial3: true),
      backgroundGradient: [
        widget.color, 
        widget.color.withValues(alpha: 0.5), 
        Colors.white,
      ],
      scrollable: false,
      showAppBar: false,
      body: Center(child: Text("Dynamic Theme Screen",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black,),),),
    );
  }
}