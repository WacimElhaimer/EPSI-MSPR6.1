// This is a basic Flutter widget test for the A'rosa-je application for the A'rosa-je application.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Application smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() async {
      await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MyApp());
    });
    });

    // Verify that the app title is displayed
    expect(find.text('A\'rosa-je'), findsOneWidget);
     // Verify that the login and register buttons are displaythe app title is displayed
    expect(find.text('A\'rosa-je'), findsOneWidget);

    // Verify that the login and register buttons are displayed
    expect(find.text('Connexion'), findsOneWidget);
     expect(find.text('Inscription'), findsOneWidget);
   });
}
