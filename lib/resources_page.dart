import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatefulWidget {
  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  List<dynamic> articles = []; // List to hold fetched articles

  @override
  void initState() {
    super.initState();
    fetchArticles(); // Fetch articles when the page initializes
  }

  Future<void> fetchArticles() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=alopecia&apiKey=1b65f25f647f4c28963e2b8b32e4543d'), // News Authorization header with API key
    );

    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body)['articles']; // Decode and store articles
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Get screen size for responsiveness

    return Scaffold(
      appBar: AppBar(
        title: Text('Alopecia Resources'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[900]!, Colors.pink[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: articles.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching
            : ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  final imageUrl = article['urlToImage'] ?? 'https://via.placeholder.com/150'; // Default image
                  final title = article['title'] ?? 'No Title'; // Default title
                  final description = article['description'] ?? 'No Description'; // Default description

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.network(
                          imageUrl, // Article image
                          fit: BoxFit.cover,
                          height: screenSize.height * 0.3,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: screenSize.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            description,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            final url = article['url'];
                            if (await canLaunch(url)) {
                              await launch(url); // Open article in the default browser
                            } else {
                              throw 'Could not launch $url'; // Handle the error case
                            }
                          },
                          child: Text('Read More'),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
