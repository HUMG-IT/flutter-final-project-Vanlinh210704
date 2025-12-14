import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/product.dart';

void main() {
  group('Product Model Tests', () {
    test('Product should be created with required fields', () {
      final now = DateTime.now();
      final product = Product(
        id: '1',
        title: 'Test Product',
        description: 'Test Description',
        quantity: 10,
        price: 100.0,
        createdAt: now,
        updatedAt: now,
      );

      expect(product.id, '1');
      expect(product.title, 'Test Product');
      expect(product.description, 'Test Description');
      expect(product.quantity, 10);
      expect(product.price, 100.0);
      expect(product.createdAt, now);
      expect(product.updatedAt, now);
    });

    test('Product isInStock should return true when quantity > 0', () {
      final product = Product(
        id: '1',
        title: 'Test Product',
        quantity: 5,
        price: 100.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(product.isInStock, true);
    });

    test('Product isInStock should return false when quantity is 0', () {
      final product = Product(
        id: '1',
        title: 'Test Product',
        quantity: 0,
        price: 100.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(product.isInStock, false);
    });

    test('Product copyWith should create a copy with updated fields', () {
      final now = DateTime.now();
      final product = Product(
        id: '1',
        title: 'Original Product',
        description: 'Original Description',
        quantity: 10,
        price: 100.0,
        createdAt: now,
        updatedAt: now,
      );

      final updatedProduct = product.copyWith(
        title: 'Updated Product',
        quantity: 20,
      );

      expect(updatedProduct.id, '1');
      expect(updatedProduct.title, 'Updated Product');
      expect(updatedProduct.description, 'Original Description');
      expect(updatedProduct.quantity, 20);
      expect(updatedProduct.price, 100.0);
    });

    test('Product toFirestore should return correct map', () {
      final now = DateTime.now();
      final product = Product(
        id: '1',
        title: 'Test Product',
        description: 'Test Description',
        quantity: 10,
        price: 100.0,
        createdAt: now,
        updatedAt: now,
      );

      final map = product.toFirestore();

      expect(map['title'], 'Test Product');
      expect(map['description'], 'Test Description');
      expect(map['quantity'], 10);
      expect(map['price'], 100.0);
      expect(map['createdAt'], isA<Timestamp>());
      expect(map['updatedAt'], isA<Timestamp>());
    });

    test('Product equality should be based on id', () {
      final now = DateTime.now();
      final product1 = Product(
        id: '1',
        title: 'Product 1',
        quantity: 10,
        price: 100.0,
        createdAt: now,
        updatedAt: now,
      );

      final product2 = Product(
        id: '1',
        title: 'Product 2',
        quantity: 20,
        price: 200.0,
        createdAt: now,
        updatedAt: now,
      );

      final product3 = Product(
        id: '2',
        title: 'Product 1',
        quantity: 10,
        price: 100.0,
        createdAt: now,
        updatedAt: now,
      );

      expect(product1, equals(product2));
      expect(product1, isNot(equals(product3)));
    });

    test('Product toString should return correct format', () {
      final product = Product(
        id: '1',
        title: 'Test Product',
        quantity: 10,
        price: 100.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(
        product.toString(),
        'Product(id: 1, title: Test Product, quantity: 10, price: 100.0)',
      );
    });

    test('Product default description should be empty string', () {
      final product = Product(
        id: '1',
        title: 'Test Product',
        quantity: 10,
        price: 100.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(product.description, '');
    });
  });
}
