import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'second_page.dart';
import 'resources_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp()); // Run the web application
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower Women with Alopecia',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.purple[900],
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> images = []; // List to hold images
  final List<String> feministQuotes = [
    "“You are not your hair.” - Unknown",
    "“Hair loss is a journey, not a destination.” - Unknown",
    "“True beauty is about how you feel on the inside.” - Unknown",
  ];

  @override
  void initState() {
    super.initState();
    fetchImages(); // Fetch images on initialization
  }

  // Fetch images from the API
  Future<void> fetchImages() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=bald%20women%20empowerment%20alopecia%&per_page=30'),
      headers: {'Authorization': 'Bb17bgsb4TY1LEsMKok7lmZOIxus9NTSDrnVVlNtsIS7sEb0if6jsMSO'}, // Pexels API key
    );

    // Check for successful response
    if (response.statusCode == 200) {
      setState(() {
        images = json.decode(response.body)['photos']; // Decode and store images
      });
    } else {
      throw Exception('Failed to load images'); // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Get screen size for responsive design

    return Scaffold(
      appBar: AppBar(
        title: Text('Empower Women with Alopecia'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Navigate to Resources Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResourcesPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
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
              Text(
                'Empowering Women with Alopecia',
                style: TextStyle(
                  fontSize: screenSize.width * 0.07,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: screenSize.height * 0.5,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        image['src']['medium'],
                        fit: BoxFit.contain,
                        width: screenSize.width,
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: feministQuotes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        feministQuotes[index],
                        style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Second Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
                child: Text('Learn More About Alopecia'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  const url = 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3230136/'; // URL for resources about alopecia
                  if (await canLaunch(url)) {
                    await launch(url); // Launch the URL
                  } else {
                    throw 'Could not launch $url'; // Handle error
                  }
                },
                child: Text('View Resources'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
