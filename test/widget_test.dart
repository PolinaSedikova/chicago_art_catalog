import 'package:flutter_test/flutter_test.dart';
import 'package:chicago_art_catalog/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ChicagoArtApp());
  });
}
