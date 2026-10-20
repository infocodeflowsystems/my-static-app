
import 'package:flutter_test/flutter_test.dart';
import 'package:mybusiness_mini/main.dart';

void main() {
  testWidgets('shows salon branding and services', (tester) async {
    await tester.pumpWidget(const MyBusinessMiniApp());

    expect(find.text('Urban Trim Studio'), findsOneWidget);
    expect(find.text('Our Services'), findsOneWidget);
    expect(find.text('Classic Haircut'), findsOneWidget);
    expect(find.text('Beard Trim'), findsOneWidget);
  });
}
