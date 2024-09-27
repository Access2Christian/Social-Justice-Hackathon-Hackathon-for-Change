import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'second_page.dart';
import 'resources_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; // Make sure to import this package

void main() {
  runApp(MyApp());
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
  List<dynamic> images = [];
  final List<String> feministQuotes = [
    "“You are not your hair.” - Unknown",
    "“Hair loss is a journey, not a destination.” - Unknown",
    "“True beauty is about how you feel on the inside.” - Unknown",
  ];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=bald%20women%20empowerment%20aplopecia&per_page=30'),
      headers: {'Authorization': 'Bb17bgsb4TY1LEsMKok7lmZOIxus9NTSDrnVVlNtsIS7sEb0if6jsMSO'}, // Pexels API key
    );

    if (response.statusCode == 200) {
      setState(() {
        images = json.decode(response.body)['photos'];
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Empower Women with Alopecia'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
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
              colors: [Colors.purple[900]!, Colors.pink[900]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Empowering Women with Alopecia',
                style: TextStyle(
                  fontSize: 24, // Adjust text size for mobile view
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: screenSize.height * 0.4,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          image['src']['medium'],
                          fit: BoxFit.contain,
                          width: screenSize.width * 0.8, // Adjust image width
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: feministQuotes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      feministQuotes[index],
                      style: TextStyle(
                        fontSize: 16, // Adjust font size for readability
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
                child: Text('Learn More About Alopecia'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 18), // Adjust button text size
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3230136/'); // Url to direct users to resources about alopecia
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
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
