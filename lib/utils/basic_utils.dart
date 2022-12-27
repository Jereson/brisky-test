import 'package:logger/logger.dart';

const imbdApiKey = 'k_1c9muzxk';
const imbdBaseApiUrl = 'https://imdb-api.com/en/API/MostPopularTVs';
const timeOutMessage = "TimeoutException: Timeout occured try again later";
const String profilePic =
    'https://firebasestorage.googleapis.com/v0/b/brisky-43ac8.appspot.com/o/profile-avatar.jpeg?alt=media&token=5a4edfab-35ba-4b3d-a983-24f6c4903856';

final logger = Logger();
Map<String, String> setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

const String serverErrorMessage =
    "Internal Server Error. Please try again later.";

const String networkErrorMessage =
    "Check your internet connection and try again";
const String unknownError = "Error occured try again later";

const Duration dbTimeOut = Duration(seconds: 20);
