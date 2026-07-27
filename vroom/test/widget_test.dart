
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vroom/main.dart'; 

void main() {
  testWidgets('Login screen elements smoke test', (WidgetTester tester) async {
   
    await tester.pumpWidget(const MyApp());

   
    expect(find.text('Login'), findsOneWidget);

  
    expect(find.text('Email'), findsOneWidget);

    
    expect(find.text('Password'), findsOneWidget);

    
    expect(find.text('0'), findsNothing);
  });
}
