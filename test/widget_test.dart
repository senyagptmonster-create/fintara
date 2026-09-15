import 'package:flutter_test/flutter_test.dart';
import 'package:fintara/fintara_app.dart';

void main() {
  testWidgets('FintaraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FintaraApp());
    expect(find.text('Envelopes Deck'), findsOneWidget);
  });
}
