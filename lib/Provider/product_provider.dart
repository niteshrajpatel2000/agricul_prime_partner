import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_pos/Screens/Products/Model/product_model.dart';

import '../Screens/Products/Repo/product_repo.dart';

ProductRepo productRepo = ProductRepo();
final productProvider = FutureProvider.autoDispose<List<ProductModel>>((ref) => productRepo.fetchAllProducts());
final fetchProductDetails = FutureProvider.family.autoDispose<ProductModel, String>((ref, id) {
  return productRepo.fetchProductDetails(productID: id);
});
