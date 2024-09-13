import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import the carousel slider package
import 'package:simple_flutter_app/main.dart';

void main() {
  testWidgets('HomePage displays expected widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the title is displayed.
    expect(find.text('Empowering Women Everywhere'), findsOneWidget);
    
    // Verify that the carousel slider is present.
    expect(find.byType(CarouselSlider), findsOneWidget);
    
    // Verify that the first feminist quote is displayed.
    expect(find.textContaining('Feminism is the radical notion'), findsOneWidget);
    
    // Verify that the button exists and has the correct label.
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Learn More About Feminism'), findsOneWidget);
  });
}
