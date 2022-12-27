import 'dart:convert';
import 'dart:io';
import 'package:briskit/utils/basic_utils.dart';
import 'package:http/http.dart' as http;

class MoviesServices {
  Future<RepoValidator> getMovies() async {
    try {
      const String uri = '$imbdBaseApiUrl/$imbdApiKey';

      final response = await http.get(Uri.parse(uri), headers: setHeaders());

      final result = await jsonDecode(response.body);

      logger.d(response.statusCode);

      if (response.statusCode == 200) {
        return RepoSucess(result);
      } else {
        throw RepoFailure(result["message"] ?? "Try again");
      }
    } on SocketException {
      throw RepoFailure("No internet connection");
    } catch (e) {
      rethrow;
    }
  }


}

abstract class RepoValidator {}

class RepoSucess extends RepoValidator {
  final dynamic data;
  RepoSucess(this.data);
}

class RepoFailure extends RepoValidator {
  final String errorMessage;
  RepoFailure(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
