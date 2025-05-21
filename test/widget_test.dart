import 'package:flutter_test/flutter_test.dart';
import 'package:nexo_shop/main.dart';

void main() {
  testWidgets('آزمایش اجرا شدن اپلیکیشن', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Nexo Shop'), findsOneWidget);
  });
}
