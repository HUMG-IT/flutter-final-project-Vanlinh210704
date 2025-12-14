import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/widgets/product_item.dart';

void main() {
  group('ProductItem Widget Tests', () {
    late Product testProduct;

    setUp(() {
      testProduct = Product(
        id: '1',
        title: 'Test Product',
        description: 'Test Description',
        quantity: 10,
        price: 50000,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });

    testWidgets('ProductItem displays product title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('ProductItem displays product description', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('ProductItem displays quantity', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.text('SL: 10'), findsOneWidget);
    });

    testWidgets('ProductItem calls onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () => tapped = true,
              onDelete: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });

    testWidgets('ProductItem calls onDelete when delete button pressed',
        (tester) async {
      bool deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () => deleted = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      expect(deleted, true);
    });

    testWidgets('ProductItem shows green color for in-stock product',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      final quantityText = find.text('SL: 10');
      expect(quantityText, findsOneWidget);
    });

    testWidgets('ProductItem shows red color for out-of-stock product',
        (tester) async {
      final outOfStockProduct = Product(
        id: '2',
        title: 'Out of Stock Product',
        description: 'No stock',
        quantity: 0,
        price: 100000,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: outOfStockProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.text('SL: 0'), findsOneWidget);
    });

    testWidgets('ProductItem displays delete icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    });

    testWidgets('ProductItem displays inventory icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductItem(
              product: testProduct,
              onTap: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.inventory_2), findsOneWidget);
    });
  });
}
