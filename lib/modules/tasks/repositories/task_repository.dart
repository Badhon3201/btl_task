import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled4/core/values/assets_image_manager.dart';
import '../../../core/utils/api_service/api_service.dart';
import '../../../core/utils/api_service/urls.dart';
import '../../../core/utils/failure/app_error.dart';
import '../models/task_response_model.dart';

class TaskRepository {
  Future<Either<AppError, List<TaskResponseModel>>> getTaskList() async {
    try {
      var res = await ApiService().getRequest(Urls.taskUrl);
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        var decodedJson = json.decode(utf8.decode(res.bodyBytes));
        final List<TaskResponseModel> taskResponseModel = [];
        for (var tasks in decodedJson) {
          var taskModel = TaskResponseModel.fromJson(tasks);
          taskResponseModel.add(taskModel);
        }
        return Right(taskResponseModel);
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

  Future<Either<AppError, TaskResponseModel>> adTask(String taskName,
      String taskTitle, String taskDescription, bool completeStatus) async {
    try {
      Map<String, dynamic> body = {
        "task_name": taskName,
        "task_title": taskTitle,
        "task_description": taskDescription,
        "complete_status": completeStatus,
        "avatar": AssetsImageManager.taskImage
      };
      var res = await ApiService().postRequest(Urls.taskUrl, body);
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200 || res.statusCode == 201) {
        var decodedJson = json.decode(utf8.decode(res.bodyBytes));
        var taskModel = TaskResponseModel.fromJson(decodedJson);

        return Right(taskModel);
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

  Future<Either<AppError, TaskResponseModel>> updateTask(
      int id,
      String taskName,
      String taskTitle,
      String taskDescription,
      bool completeStatus) async {
    try {
      Map<String, dynamic> body = {
        "task_name": taskName,
        "task_title": taskTitle,
        "task_description": taskDescription,
        "complete_status": completeStatus,
        "avatar": AssetsImageManager.taskImage
      };
      var res = await ApiService().putRequest("${Urls.taskUrl}/$id", body);
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200 || res.statusCode == 201) {
        var decodedJson = json.decode(utf8.decode(res.bodyBytes));
        var taskModel = TaskResponseModel.fromJson(decodedJson);

        return Right(taskModel);
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
