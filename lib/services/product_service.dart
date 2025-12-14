import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Tên collection trong Firestore
  static const String _collectionName = 'products';

  /// Lấy reference đến collection products
  CollectionReference<Map<String, dynamic>> get _productsRef =>
      _firestore.collection(_collectionName);

  /// Stream danh sách sản phẩm (realtime)
  Stream<List<Product>> getProductsStream() {
    return _productsRef.orderBy('createdAt', descending: true).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }

  /// Lấy danh sách sản phẩm (một lần)
  Future<List<Product>> getProducts() async {
    final snapshot =
        await _productsRef.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }

  /// Lấy sản phẩm theo ID
  Future<Product?> getProductById(String id) async {
    final doc = await _productsRef.doc(id).get();
    if (doc.exists) {
      return Product.fromFirestore(doc);
    }
    return null;
  }

  /// Thêm sản phẩm mới (Create)
  Future<String> addProduct(Product product) async {
    final now = DateTime.now();
    final productData = product
        .copyWith(
          createdAt: now,
          updatedAt: now,
        )
        .toFirestore();

    final docRef = await _productsRef.add(productData);
    return docRef.id;
  }

  /// Cập nhật sản phẩm (Update)
  Future<void> updateProduct(Product product) async {
    final updatedProduct = product.copyWith(
      updatedAt: DateTime.now(),
    );
    await _productsRef.doc(product.id).update(updatedProduct.toFirestore());
  }

  /// Xóa sản phẩm (Delete)
  Future<void> deleteProduct(String id) async {
    await _productsRef.doc(id).delete();
  }

  /// Tìm kiếm sản phẩm theo tên
  Stream<List<Product>> searchProducts(String query) {
    if (query.isEmpty) {
      return getProductsStream();
    }

    // Tìm kiếm đơn giản bằng cách lọc trên client
    return getProductsStream().map((products) => products
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }

  /// Cập nhật số lượng sản phẩm
  Future<void> updateQuantity(String id, int newQuantity) async {
    await _productsRef.doc(id).update({
      'quantity': newQuantity,
      'updatedAt': Timestamp.now(),
    });
  }

  /// Lấy sản phẩm sắp hết hàng (quantity < threshold)
  Stream<List<Product>> getLowStockProducts({int threshold = 10}) {
    return _productsRef
        .where('quantity', isLessThan: threshold)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList());
  }
}
