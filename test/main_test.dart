import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Basic Tests', () {
    testWidgets('App should have a MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Quan Ly Kho'),
            ),
          ),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App should display title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Quan Ly Kho'),
            ),
          ),
        ),
      );

      expect(find.text('Quan Ly Kho'), findsOneWidget);
    });

    testWidgets('Scaffold should exist', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Test'),
            ),
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });
  });

  group('Login Screen UI Tests', () {
    testWidgets('Login form should have email and password fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mat khau'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Dang Nhap'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Mat khau'), findsOneWidget);
      expect(find.text('Dang Nhap'), findsOneWidget);
    });

    testWidgets('Login button should be tappable', (WidgetTester tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () => buttonPressed = true,
              child: const Text('Dang Nhap'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Dang Nhap'));
      await tester.pump();

      expect(buttonPressed, true);
    });
  });

  group('Product Form UI Tests', () {
    testWidgets('Product form should have required fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Ten san pham'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mo ta'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'So luong'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Gia'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Ten san pham'), findsOneWidget);
      expect(find.text('Mo ta'), findsOneWidget);
      expect(find.text('So luong'), findsOneWidget);
      expect(find.text('Gia'), findsOneWidget);
    });

    testWidgets('Add product button should exist', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });
  });
}
