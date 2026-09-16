import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:life_os/main.dart';

void main() {
  testWidgets('tab scaffold renders Home, Search, Settings', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeOSApp());

    expect(find.byType(CupertinoTabScaffold), findsOneWidget);
    expect(find.byType(CupertinoTabBar), findsOneWidget);

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('counter increments with Increment button', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeOSApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}