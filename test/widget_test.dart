import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_flutter1/main.dart';

void main() {
  testWidgets('Hello Wassim is displayed', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify that 'Hello Wassim' is present
    expect(find.text('Hello Wassim'), findsOneWidget);
  });
}
