import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 60),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('에러가 발생했습니다.'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('데이터를 불러오는 데 실패했습니다.'),
          ),
        ],
      ),
    );
  }
}
