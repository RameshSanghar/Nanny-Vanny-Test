import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nanny_vanny/model/package_list_model.dart';
import '../config/app_api.dart';
import 'global_controller.dart';

class PackageController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();

  PackageListModel? packageListModel;

  Future<void> getPackageList() async {
    globalController.startLoading('secondApi');

    try {
      var myDio = dio.Dio();
      await myDio
          .get(
        AppApi.baseUrl + AppApi.packageList,
        options: dio.Options(
          validateStatus: (status) => true,
        ),
      )
          .then(
        (value) async {
          log(value.statusCode.toString());
          if (value.statusCode == 200 || value.statusCode == 201) {
            globalController.stopLoading('secondApi');
            log("Current Booking Data: $value");
            packageListModel = PackageListModel.fromJson(value.data);
            update();
          } else if (value.statusCode == 400 ||
              value.statusCode == 404 ||
              value.statusCode == 401) {
            globalController.stopLoading('secondApi');
            errorMessage(value.statusMessage ?? "Unknown");
          } else {
            globalController.stopLoading('secondApi');
            errorMessage(value.statusMessage ?? "Unknown");
          }
        },
      );
    } catch (err) {
      globalController.stopLoading('secondApi');
      errorMessage(err.toString());
    }
  }

  void errorMessage(String message) {
    Fluttertoast.showToast(msg: "Error:- $message");
    log("Error => $message");
  }
}
