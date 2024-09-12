import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled3/main.dart'; // main.dart dosyanızın yolunu doğru şekilde yazın.

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Uygulamanızı build edin ve bir frame oluşturun.
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // 0 başlangıç değerini doğrulayın.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // '+' simgesine tıklayın ve frame'i tekrar oluşturun.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Counter'in artmış olduğunu doğrulayın.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
