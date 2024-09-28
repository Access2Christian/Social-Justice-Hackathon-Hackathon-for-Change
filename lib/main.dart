import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'second_page.dart';
import 'resources_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; 

void main() {
  runApp(MyApp()); // Entry point of the Flutter application
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower Women with Alopecia',  // Application title
      theme: ThemeData(
        primarySwatch: Colors.purple,  // Set the primary theme color to purple
        scaffoldBackgroundColor: Colors.black,  // Background color for the app
        appBarTheme: AppBarTheme(
          color: Colors.purple[900], // AppBar background color
        ),
      ),
      home: HomePage(), // The home page of the app
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); // Create the mutable state for the home page
}

class _HomePageState extends State<HomePage> {
  List<dynamic> images = []; // List to hold the images fetched from the API
  final List<String> feministQuotes = [
    "“You are not your hair.” - Unknown",
    "“Hair loss is a journey, not a destination.” - Unknown",
    "“True beauty is about how you feel on the inside.” - Unknown",
  ]; // List of feminist quotes to display

  @override
  void initState() {
    super.initState();
    fetchImages(); // Fetch images when the page is initialized
  }

 // Function to fetch images from the Pexels API
  Future<void> fetchImages() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=bald%20women%20empowerment%20aplopecia&per_page=30'),
      headers: {'Authorization': 'Bb17bgsb4TY1LEsMKok7lmZOIxus9NTSDrnVVlNtsIS7sEb0if6jsMSO'}, // Authorization header with API key
    );

     // If the request is successful, decode and store the images
    if (response.statusCode == 200) {
      setState(() {
        images = json.decode(response.body)['photos'];
      });
    } else {
      throw Exception('Failed to load images'); // Handle failure to fetch images
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Get the screen size for responsive design

    return Scaffold(
      appBar: AppBar(
        title: Text('Empower Women with Alopecia'), // Title in the AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.info), // Info icon button
            onPressed: () {
              // Navigate to the Resources Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResourcesPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[900]!, Colors.pink[900]!], // Gradient background for the page
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Empowering Women with Alopecia',
                style: TextStyle(
                  fontSize: 24, // Responsive font size
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Space between elements

               // Carousel slider to display images
              CarouselSlider(
                options: CarouselOptions(
                  height: screenSize.height * 0.4,  // Responsive carousel height
                  autoPlay: true,  // Auto-play the carousel
                  enlargeCenterPage: true, // Enlarge the centered image
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          image['src']['medium'], // Display image from the API
                          fit: BoxFit.contain, // Fit the image within the box
                          width: screenSize.width * 0.8, // Responsive font size
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ListView.builder(  // List of feminist quotes
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: feministQuotes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding around each quote
                    child: Text(
                      feministQuotes[index], // Display the quote
                      style: TextStyle(
                        fontSize: 16, // Font size for readability
                        fontStyle: FontStyle.italic, // Italicize the text
                        color: Colors.white, // White text color
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

               // Button to navigate to the second page
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()), // Navigate to the second page
                  );
                },
                child: Text('Learn More About Alopecia'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18), // Button text size
                ),
              ),
              SizedBox(height: 20),

               // Button to launch an external URL with resources about alopecia
              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3230136/'); // URL to alopecia resources
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url); //Luanch the URL 
                  } else {
                    throw 'Could not launch $url'; // Handle failure to launch URL
                  }
                },
                child: Text('View Resources'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18), // Adjust button text size
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
