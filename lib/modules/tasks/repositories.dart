import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../core/utils/api_service/api_service.dart';
import '../../core/utils/failure/app_error.dart';
import 'models/task_response_model.dart';

class TaskRepository {
  Future<Either<AppError, TaskResponseModel>> getCompanyFromServer() async {
    try {
      var res = await ApiService().getRequest(
          "https://64e45c93c555638029131290.mockapi.io/btl-task/users");
      debugPrint(res.statusCode.toString());

      if (res.statusCode == 200) {
        // logger.i(res.body);

        var decodedJson = json.decode(utf8.decode(res.bodyBytes));

        var company = TaskResponseModel.fromJson(decodedJson);

        return Right(company);
      } else {
        return const Left(AppError.httpError);
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      return const Left(AppError.networkError);
    } catch (e) {
      debugPrint(e.toString());
      return const Left(AppError.unknownError);
    }
  }
}
