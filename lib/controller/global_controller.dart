import 'package:get/get.dart';

class GlobalController extends GetxController {
  // List to track the loading states of multiple API calls
  var loadingApiCalls = <String>[].obs;

  // Add an API identifier to the list when API call starts
  void startLoading(String apiName) {
    loadingApiCalls.add(apiName);
  }

  // Remove the API identifier from the list when API call ends
  void stopLoading(String apiName) {
    loadingApiCalls.remove(apiName);
    update();
  }

  // Check if any API is still loading
  bool get isLoading => loadingApiCalls.isNotEmpty;
}
