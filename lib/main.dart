import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall/HomePage/HomePage.dart';
import 'package:mirror_wall/provider/mirror_provider.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(myAPP());
}
class myAPP extends StatelessWidget {
  const myAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return   ChangeNotifierProvider(
      create: (BuildContext) => MirrorProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
