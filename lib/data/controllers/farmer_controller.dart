import 'package:agri_connect/data/repositories/farmer_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FarmerController extends GetxController {
  final FarmerRepository farmerRepository;
  FarmerController({required this.farmerRepository});
  var isLoading = false.obs;
  var farmers = [].obs;

  Future completeFarmerProfile(farmer) async {
    isLoading.value = true;
    try {
      final result = await farmerRepository.CompleteFarmerProfile(farmer);
      print(result);
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future getAllFarmers() async {
    isLoading = true.obs;
    try {
      final result = await farmerRepository.getFarmer();
      // print(result);
      isLoading = false.obs;
      return result;
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future getFarmersDetails(id) async {
    try {
      final result = await farmerRepository.getFarmerDetail(id);
      print("result: ${result}");
      return result;
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future hireFarmer(id) async {
    try {
      final result = await farmerRepository.hire_Farmer(id);
      // print(result);
      return result;
    } catch (err) {
      print(err.toString());
      rethrow;
    }
  }

  Future<void> get_hiredFarmer() async {
  isLoading.value = true; // Correct way to update the observable
  try {
    final result = await farmerRepository.get_hireFarmer();
    if (result != null) {
      farmers.value = result;
    } else {
      farmers.value = []; // Ensure the list updates to empty if no data is returned
    }
  } catch (err) {
    print(err.toString());
  } finally {
    isLoading.value = false; // Ensure loading stops
  }
}

}
