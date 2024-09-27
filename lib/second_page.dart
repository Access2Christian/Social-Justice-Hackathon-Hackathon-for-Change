import 'package:flutter/material.dart';
import 'resources_page.dart';
import 'fourth_page.dart'; 

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn More About Alopecia'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alopecia is a condition that results in hair loss. It can affect anyone, '
                'but it can be particularly challenging for women due to societal beauty standards. '
                'Empowering women to embrace their beauty beyond hair is crucial.',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResourcesPage()),
                  );
                },
                child: Text('View Resources'),
              ),
              // Add a button for the video page (after you create it)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FourthPage()), // Create this page
                  );
                },
                child: Text('View Video on Discrimination'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
