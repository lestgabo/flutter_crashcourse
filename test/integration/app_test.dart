import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercrashcourse_lesson12/app.dart';
import 'package:fluttercrashcourse_lesson12/mocks/mock_location.dart';
import 'package:image_test_utils/image_test_utils.dart';

void main() {
  testWidgets('test app startup', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      await tester.pumpWidget(App());

      var mockLocation = MockLocation.fetchAny();

      expect(find.text(mockLocation.name), findsOneWidget);
      expect(find.text('${mockLocation.name}blah'), findsNothing);
    });
  });
}
