import 'package:agri_connect/data/controllers/product_controller.dart';
import 'package:agri_connect/data/models/ProductModel.dart';
import 'package:agri_connect/product_detail_page.dart';
import 'package:agri_connect/shop_profile.dart';
import 'package:agri_connect/utils/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'ProdcutCard.dart';
import 'custom.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'utils/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController = Get.find<ProductController>();

  var products = []; // List to store product data

  // Controllers for text fields
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // Selected category (global)
  String selectedCategory = 'seed';
  File? _selectedImage; // Image file

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  getProducts() async {
    try {
      var productResponse = await productController.getProduct();
      setState(() {
        products = productResponse;
      });
    } catch (e) {
      print("Error fetching products: $e");
      setState(() {
        products = [];
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await ImagePickerHelper.pickImage(
      ImageSource.gallery,
      context: context,
      source: "product",
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        print("Image path: ${_selectedImage!.path}");
        print("Image size: ${_selectedImage!.lengthSync()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.greenTextColor,
        title: Text(
          "Products",
          style: TextStyle(color: CustomColor.mintForestTextColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopProfile()));
            },
            icon: Icon(
              Icons.store,
              color: CustomColor.mintForestTextColor,
            ),
          ),
          IconButton(
            onPressed: () {
              showAddBottomSheet(context: context);
            },
            icon: Icon(
              Icons.add,
              color: CustomColor.mintForestTextColor,
            ),
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                "No products added yet.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                print("product:  ${product['_id']}");
                return Slidable(
                  key: ValueKey(product['id']),
                  startActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: "Edit",
                        onPressed: (context) {
                          showAddBottomSheet(
                              context: context,
                              isEdit: true,
                              productId: product['_id']);
                        },
                      ),
                      SlidableAction(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: "Delete",
                        onPressed: (context) async {
                          await productController.deleteProduct(product['_id']);
                          await getProducts();
                          // Delete functionality here
                        },
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        print("Testing");
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage());
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: CustomColor.mutedSageTextColor,
                          backgroundImage: product['image'] != null &&
                                  Uri.tryParse(product['image'])?.isAbsolute ==
                                      true
                              ? NetworkImage(product['image'])
                              : null,
                          child: product['image'] == null ||
                                  !(Uri.tryParse(product['image'])
                                          ?.isAbsolute ??
                                      false)
                              ? Icon(Icons.image, color: Colors.white)
                              : null,
                        ),
                        title: Text(
                          product['name'] ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                                "Description: ${product['description'] ?? ''}"),
                            Text("Price: \$${product['price'] ?? ''}"),
                            Text("Stock: ${product['stock'] ?? ''}"),
                            Text("Category: ${product['category'] ?? ''}"),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: CustomColor.greenTextColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void showAddBottomSheet(
      {required BuildContext context, bool isEdit = false, productId}) {
    // Create a local variable for the category to be used within the bottom sheet
    String localSelectedCategory = selectedCategory;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.image,
                            size: 100,
                            color: CustomColor.mutedSageTextColor,
                          ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                  ),
                  TextFormField(
                    controller: stockController,
                    decoration: InputDecoration(labelText: 'Stock'),
                  ),
                  SizedBox(height: 20),
                  // Radio buttons for category selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: "seed",
                        groupValue: localSelectedCategory,
                        onChanged: (String? value) {
                          setModalState(() {
                            localSelectedCategory = value!;
                          });
                        },
                      ),
                      Text("Seed"),
                      SizedBox(width: 20),
                      Radio<String>(
                        value: "cropprotection",
                        groupValue: localSelectedCategory,
                        onChanged: (String? value) {
                          setModalState(() {
                            localSelectedCategory = value!;
                          });
                        },
                      ),
                      Text("Crop Protection"),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      print("add product");

                      String?
                          imgurl; // Nullable string to handle possible null values

                      if (_selectedImage != null) {
                        print("_selectedImage: ${_selectedImage!.path}");

                        imgurl = await CloudinaryService()
                            .uploadImage(imageFile: _selectedImage!);

                        if (imgurl == null) {
                          print("Error: Image upload failed!");
                        } else {
                          print("Image uploaded successfully: $imgurl");
                        }
                      } else {
                        print("No image selected.");
                      }

                      print("Final imgurl: $imgurl");
                      print("selectedCategory: $selectedCategory");

                      final product = ProductModel(
                        name: productNameController.text.trim(),
                        description: descriptionController.text.trim(),
                        price:
                            double.tryParse(priceController.text.trim()) ?? 0.0,
                        stock: int.tryParse(stockController.text.trim()) ?? 0,
                        image: imgurl ?? "",
                        // Ensure a valid string
                        category: localSelectedCategory,
                      );

                      if (isEdit) {
                        await productController.updateProduct(
                            product, productId);
                      } else {
                        await productController.createProduct(product);
                      }
                      await getProducts();

                      Navigator.pop(context);
                    },
                    child: isEdit ? Text("Edit Product") : Text("ADD Product"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
