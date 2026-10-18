// AC1~AC3 위젯 테스트. 화면 문구('완료', '취소', '남은 할 일: N')에 의존하므로
// lib/main.dart의 문구를 바꾸면 이 테스트도 함께 바꾼다.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:week05_state_lab/main.dart';

void main() {
  testWidgets('AC1 초기 화면: 항목 두 개, 남은 수 2', (WidgetTester tester) async {
    await tester.pumpWidget(const Week05App());

    expect(find.text('5주차 강의 복습'), findsOneWidget);
    expect(find.text('상태 흐름도 작성'), findsOneWidget);
    expect(find.text('남은 할 일: 2'), findsOneWidget);
    expect(find.text('완료'), findsNWidgets(2));
    expect(find.text('취소'), findsNothing);
  });

  testWidgets('AC2·AC3 완료 후 취소하면 카드와 남은 수가 함께 왕복', (WidgetTester tester) async {
    await tester.pumpWidget(const Week05App());

    // 첫 항목 완료: 남은 수 2→1, 아이콘과 버튼 문구 변경
    await tester.tap(find.text('완료').first);
    await tester.pump();
    expect(find.text('남은 할 일: 1'), findsOneWidget);
    expect(find.text('취소'), findsOneWidget);
    expect(find.text('완료'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    // 다시 누르면 원복: 남은 수 1→2
    await tester.tap(find.text('취소'));
    await tester.pump();
    expect(find.text('남은 할 일: 2'), findsOneWidget);
    expect(find.text('취소'), findsNothing);
    expect(find.text('완료'), findsNWidgets(2));
    expect(find.byIcon(Icons.check_circle), findsNothing);
  });
}
