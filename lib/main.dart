import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'second_page.dart'; // Import the second page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empower Women',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Pacifico'),
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.purple[900],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/pexels-alexander-mass-748453803-27869834.jpg',
    'assets/images/pexels-artempodrez-6003075.jpg',
    'assets/images/pexels-cathy-b-748462208-28243575.jpg',
    'assets/images/pexels-esma-atak-46104031-20370059.jpg',
    'assets/images/pexels-hatice-baran-153179658-28003132.jpg',
    'assets/images/pexels-karina-1622396627-27555585.jpg',
    'assets/images/pexels-miguelreyes-28296202.jpg',
    'assets/images/pexels-nayla-bernardes-1673442920-28302543.jpg',
    'assets/images/pexels-njeromin-20678740.jpg',
    'assets/images/pexels-opticaltimeline-27854288.jpg',
    'assets/images/pexels-polina-tankilevitch-5585857.jpg',
    'assets/images/pexels-raymond-petrik-1448389535-28232676.jpg',
  ];

  final List<String> feministQuotes = [
    "“Feminism is the radical notion that women are human beings.” - Cheris Kramarae",
    "“There is no limit to what we, as women, can accomplish.” - Michelle Obama",
    "“A feminist is anyone who recognizes the equality and full humanity of women and men.” - Gloria Steinem",
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Empower Women'),
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
                'Empowering Women Everywhere',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: screenSize.height * 0.5,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                ),
                items: imagePaths.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(
                        imagePath,
                        fit: BoxFit.contain, // Adjusted to show the full image
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
                          fontSize: 18,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
                child: Text('Learn More About Feminism'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
