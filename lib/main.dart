import 'package:flutter/material.dart';

void main() => runApp(const Week05App());

class Week05App extends StatelessWidget {
  const Week05App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

// 이 State 객체가 상태의 소유자다. _done은 이 객체가 살아 있는 동안만 유지되므로
// 앱을 완전히 다시 시작하면 초기값(모두 false)으로 돌아온다.
class _TaskPageState extends State<TaskPage> {
  final List<String> _titles = ['5주차 강의 복습', '상태 흐름도 작성'];

  // AC1: 항목별 완료 여부가 유일한 원본 상태다. 처음에는 모두 미완료로 시작한다.
  final List<bool> _done = [false, false];

  // AC3: 남은 수는 저장하지 않고 원본(_done)에서 매번 계산한다.
  // 별도 변수로 저장하면 _done과 어긋날 수 있다(AC4).
  int get _remaining => _done.where((done) => !done).length;

  void _toggleDone(int index) {
    // AC2: setState 안에서 원본을 뒤집으면 build가 다시 호출되어
    // 카드 표시와 상단 숫자가 같은 값에서 함께 갱신된다. 다시 누르면 원복된다.
    setState(() {
      _done[index] = !_done[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나의 할 일')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('남은 할 일: $_remaining',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          for (var i = 0; i < _titles.length; i++)
            Card(
              child: ListTile(
                leading: Icon(
                  _done[i] ? Icons.check_circle : Icons.radio_button_unchecked,
                ),
                title: Text(_titles[i]),
                trailing: TextButton(
                  onPressed: () => _toggleDone(i),
                  child: Text(_done[i] ? '취소' : '완료'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
