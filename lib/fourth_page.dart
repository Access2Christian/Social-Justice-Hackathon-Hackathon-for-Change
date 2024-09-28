import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Stateless widget for displaying alopecia-related videos
class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting screen size for responsive UI design
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Alopecia Videos'), // Title for the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          // Gradient background for the entire page
          gradient: LinearGradient(
            colors: [Colors.purple[900]!, Colors.pink[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title text for the page
              Text(
                'Educational Videos on Alopecia',
                style: TextStyle(
                  fontSize: screenSize.width * 0.07, // Responsive text size
                  color: Colors.white, // White text color
                ),
              ),
              SizedBox(height: 20), // Spacing between elements
              
              // Button to launch the educational video
              ElevatedButton(
                onPressed: () {
                  _launchURL('https://www.youtube.com/watch?v=XOS3qL3Wadw');
                },
                child: Text('Watch Video'),
              ),
              
              SizedBox(height: 20), // Additional spacing

              // Button to navigate back to the previous page
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle URL launching
  Future<void> _launchURL(String url) async {
    // Check if the URL can be launched
    if (await canLaunch(url)) {
      await launch(url); // Launch the URL in the default browser
    } else {
      throw 'Could not launch $url'; // Error handling if the URL cannot be launched
    }
  }
}
