import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
        // 在主轴方向上居中对齐
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
              textAlign: TextAlign.center,
              style: TextStyle(height: 2),
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to Homepage.\n',
                    style: TextStyle(fontSize: 18),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                  ),
                ],
              )),
        ]);
  }
}
