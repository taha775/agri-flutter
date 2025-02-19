import 'package:agri_connect/data/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository productRepository;

  ProductController({required this.productRepository});

  var isLoading = false.obs;
  var orders = <dynamic>[].obs;

  Future<void> createProduct(product) async {
    isLoading.value = true;
    try {
      final result = await productRepository.CreateProduct(product);
      print(result);
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getProduct() async {
    isLoading.value = true;
    try {
      var result = await productRepository.getMyProduct();
      return result;
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getAllProducts({count = 0}) async {
    isLoading.value = true;
    try {
      var result = await productRepository.getAllProduct();
      return count == 0 ? result : result.sublist(0, count);
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getProductByID(id) async {
    isLoading.value = true;
    try {
      var result = await productRepository.getProductbyId(id);
      print("result ${result}");
      return result;
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(product, String productId) async {
    isLoading.value = true;
    try {
      final result = await productRepository.UpdateProduct(product, productId);
      print(result);
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(productId) async {
    isLoading.value = true;
    try {
      final result = await productRepository.DeleteProduct(productId);
      print(result);
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> orderNow(cart, paymentMethod, shippingAddress) async {
    isLoading.value = true;
    try {
      print("Order Now API called");
      final result = await productRepository.orderProduct(
          cart, paymentMethod, shippingAddress);
      print(result);
    } catch (err) {
      print(err.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getAllOrders() async {
    isLoading.value = true;
    try {
      final result = await productRepository.get_myAllOrders();
      orders.value = result; // Update observable list with fetched data
    } catch (error) {
      print("Error fetching orders: $error");
      orders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future writeReview(prodcutId, review, rating) async {
    try {
      final result =
          await productRepository.addReview(prodcutId, review, rating);
      return result;
    } catch (error) {
      print("Error fetching orders: $error");
      orders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getReviewbyId(id) async {
    isLoading.value = true;
    try {
      final result = await productRepository.get_ReviewbyId(id);
      orders.value = result; // Update observable list with fetched data
    } catch (error) {
      print("Error fetching orders: $error");
      orders.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
