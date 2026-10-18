# 5주차 과제 — Flutter 상태(State)와 작업 컨텍스트

앱프로그래밍기초 2026-2, 5주차. 할 일 두 개의 [완료]/[취소] 버튼을 누르면 **카드 표시**와 **남은 할 일 수**가 같은 값에서 함께 바뀌는 작은 Flutter 앱입니다.

## 실행

Windows 명령 프롬프트(cmd) 기준입니다.

```bat
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
```

## 제출 설명

### 누가 상태를 소유하는가

`_TaskPageState`가 소유합니다. 완료 여부 `_done`(`List<bool>`)이 **유일한 원본 상태**입니다. 이 값을 읽는 위젯(카드 아이콘, 버튼 문구, 상단 "남은 할 일: N")이 모두 `TaskPage` 안에 있어서 한 곳에서 소유하면 충분하고, 다른 화면과 공유하지 않습니다.

남은 수 `_remaining`은 `_done`에서 매번 계산하는 getter이며 따로 저장하지 않습니다(AC4). 데이터는 메모리에만 있어서 앱을 완전히 다시 시작하면 초기값(모두 미완료)으로 돌아옵니다.

```text
버튼 탭 → _toggleDone(i) → setState 안에서 _done[i] 반전 → _remaining 계산 → 카드·상단 숫자
```

### AI에게 어떤 자료를 왜 제공했는가

| 자료 | 제공한 이유 |
|---|---|
| `lib/main.dart` | 실제 변수·화면·TODO를 확인해 이름을 맞추기 위해 |
| `STATE_CONTEXT_MAP.md` | 원본 상태와 계산값, 변경 영향 범위를 알려 주기 위해 |
| `CONTEXT_PACKET.md` | 목표·금지 범위(새 패키지, 서버, 로그인, 영구 저장, 새 화면)·AC·검사 명령을 고정하기 위해 |

요청 A(기능만 설명)와 요청 B(위 자료 제공)를 독립된 새 세션에서 각 1회 실행해 비교했습니다. 결과와 한계는 `PROMPT_COMPARISON.md`에 있습니다. 두 세션이 모두 프로젝트의 상위 폴더에서 시작했고 요청 A는 프로젝트를 찾지 못했기 때문에, "맥락의 효과"와 "탐색 실패"를 분리해서 결론 내리지는 않았습니다.

### 실행 증거가 어느 AC를 확인하는가

| 증거 | 확인하는 AC |
|---|---|
| `evidence/ac1-initial.png` | AC1 — 항목 두 개와 남은 수 2인 첫 화면 |
| `evidence/ac2-done.png` | AC2 — 첫 항목 완료 시 카드(✓, [취소])와 남은 수 1이 함께 바뀜 |
| `evidence/ac2-undone.png` | AC3 — 취소하면 카드와 남은 수 2가 함께 원복 |
| `evidence/analyze.txt` | `flutter analyze` 결과: No issues found |
| `evidence/test.txt` | `flutter test` 결과: 위젯 테스트 2개 통과(AC1~AC3) |
| 코드 검토 (`_remaining`이 getter) | AC4 |
| `STATE_CONTEXT_MAP.md`, `CONTEXT_PACKET.md`와 코드의 이름 대조 | AC5 |
| `PROMPT_COMPARISON.md`, `evidence/response_A.md`, `response_B.md` | AC6 |

화면 캡처는 크롬(웹)으로 실행한 화면이며, 안드로이드·iOS 에뮬레이터에서는 실행하지 않았습니다.

### 다음 수정에 무엇을 다시 읽어야 하는가

1. `lib/main.dart` — 변수·클래스 이름과 화면 문구
2. `STATE_CONTEXT_MAP.md` — 상태 계약과 변경 영향 표(이름이 바뀌면 함께 수정)
3. `test/widget_test.dart` — `완료`, `취소`, `남은 할 일: N` 문구와 `Week05App` 이름에 의존
4. `CONTEXT_PACKET.md` — 수정 범위·금지 범위·AC

## 파일 구조

```text
lib/main.dart             상태 기능 (제출물 1)
test/widget_test.dart     AC1~AC3 위젯 테스트
STATE_CONTEXT_MAP.md      상태 계약, 흐름도, 컨텍스트 지도 (제출물 2·3)
CONTEXT_PACKET.md         작업 컨텍스트 (제출물 4)
PROMPT_COMPARISON.md      요청 A/B 비교 (제출물 5)
evidence/                 화면 캡처, analyze·test 결과, A/B 응답 원문 (제출물 6)
```
