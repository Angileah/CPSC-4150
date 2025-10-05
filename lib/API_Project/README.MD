# api_app
Flutter Random Dog API App

## Solo 3 - Fetch & Display Data from a Public API

How the application should run link: 
- https://www.loom.com/share/3df8f29bfe9c4830b4db1e0a98c47a0e?sid=b18e619a-e62d-4a34-b02b-09f73345ec24 

This Flutter app requests data from a public HTTP API, parses the JSON response, and displays a UI with proper loading and error states. 

## Features

Fetches JSON data from the Dog CEO API (https://dog.ceo/api/breeds/image/random)

Parses JSON into a Dart model (DogImage)

Displays a loading spinner while fetching

Shows an error message with the Retry button if the request fails

Displays the fetched image in a clean, centered UI

The user can fetch a new image using the “New Dog” button

## How to run
  This app requires access to the internet
1. Make sure Flutter SDK is installed. To test this, run Flutter Doctor
2. Clone the repository or navigate to your project folder
3. Install dependencies:
    run "fluttr pub get"
4. Run the application:
    flutter run
5. Once the application is open, you can tap on the "New Dog" button to fetch a new random dog image.
   If the app fails to fetch an image, the retry button allows the user to try again.

## Edge Case Handling

- If the API request fails (Ex, if no internet connection), the app will display an error message.
- It will display a Retry button, and the user will be able to click on that and refresh once they are connected to the internet. 


