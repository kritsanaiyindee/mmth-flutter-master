import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623)),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}