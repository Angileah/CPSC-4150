import 'dart:convert';
import 'package:http/http.dart' as http;

// Model class to represent a Dog image on application
class DogImage {
  final String url;
  DogImage({required this.url});

  // Factory contrcutor to create a 'DogImage' instance from JSON Data
  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(url: json['message']);
  }
}

// The function to fetch a rondom dog image from the API
Future<DogImage> fetchDogImage() async {
  final response = await http.get(
    Uri.parse('https://dog.ceo/api/breeds/image/random')
  );
  // Checks to see if the request was successful
  if (response.statusCode == 200) {
    return DogImage.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dog image');
  }
}