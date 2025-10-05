import 'package:flutter/material.dart';
import '../dog_class.dart';

// A stateful widget to display a random dog image
class DogPage extends StatefulWidget {
  @override
  _DogPageState createState() => _DogPageState();
}

// The state class for DogPage
class _DogPageState extends State<DogPage> {
  late Future<DogImage> _futureDog;

// Initialize the state and fetch the first dog image
  @override
  void initState() {
    super.initState();
    _futureDog = fetchDogImage();
  }
// Function to refresh and fetch a new dog image
  void _refresh() {
    setState(() {
      _futureDog = fetchDogImage();
    });
  }

// UI build to render widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Random Dog')),
      body: Center(
        child: FutureBuilder<DogImage>(
          future: _futureDog,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _refresh, child: Text('Retry'))
                ],
              );
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(snapshot.data!.url),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _refresh, child: Text('New Dog'))
                ],
              );
            }
            return Text('No data');
          },
        ),
      ),
    );
  }
}
