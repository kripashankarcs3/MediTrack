// This is a basic Flutter widget test for MediTrack.

import 'package:flutter_test/flutter_test.dart';

import 'package:meditrack/main.dart';

void main() {
  testWidgets('MediTrack App Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MediTrackApp());

    // Verify that our title is shown.
    expect(find.text('MediTrack'), findsOneWidget);

    // Verify that greeting header is shown.
    expect(find.text('नमस्ते रमेश जी'), findsOneWidget);
  });
}

