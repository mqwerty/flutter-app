import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Some test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Characters'), findsOneWidget);
  });
}
