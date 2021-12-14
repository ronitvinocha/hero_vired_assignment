import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hero_vired/bl/glitch/clienterror.dart';
import 'package:hero_vired/bl/glitch/glitch.dart';
import 'package:hero_vired/bl/glitch/nointernet.dart';
import 'package:hero_vired/bl/glitch/servererror.dart';
import 'package:hero_vired/bl/glitch/tokenexpired.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<Either<Glitch, String>> networkCall(String url, String method,
      String unencodedPath, Map<String, String> queryparameter) async {
    Uri uri;
    uri = Uri.https(url, unencodedPath, queryparameter);
    log("===========$uri=======");
    // log("=====parameter" + parameter.toString());
    try {
      http.Response response;
      if (method == "GET") {
        response = await http.post(
          uri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        );
      } else {
        response = await http.post(
          uri,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
        );
      }
      log("$url response${response.body}");
      if (response.statusCode == 200) {
        if (response.body.contains("Token not found")) {
          return Left(TokenExpiredGlitch());
        } else {
          return Right(response.body);
        }
      } else if (response.statusCode == 400) {
        return Left(ClientErrorGlitch());
      } else if (response.statusCode == 500) {
        return Left(ServerErrorGlitch());
      } else if (response.statusCode == 404) {
        return Left(NoInternetGlitch());
      } else {
        return Left(Glitch(message: "Unknown error occured"));
      }
    } catch (e) {
      return Left(ServerErrorGlitch());
    }
  }
}
