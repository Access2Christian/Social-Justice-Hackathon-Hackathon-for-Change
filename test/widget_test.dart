import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carousel_slider/carousel_slider.dart'; 
import 'package:simple_flutter_app/main.dart';

void main() {
  testWidgets('HomePage displays expected widgets', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(MyApp());

    // Verify that the title is displayed
    expect(find.text('Empowering Women with Alopecia'), findsOneWidget);
    
    // Verify that the carousel slider is present
    expect(find.byType(CarouselSlider), findsOneWidget);
    
    // Verify that one of the empowering quotes is displayed
    expect(find.textContaining('You are not your hair'), findsOneWidget);
    
    // Verify that the button exists and has the correct label
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Learn More About Alopecia'), findsOneWidget);
  });
}
