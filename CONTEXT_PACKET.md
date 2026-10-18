# 완료·취소 기능 작업 컨텍스트

## 목표와 현재 상태

- 목표: 두 할 일의 완료·취소가 카드와 남은 수에 함께 반영된다.
- 현재 상태: `lib/main.dart`의 `TODO(AC1)`~`TODO(AC3)`를 모두 구현했다. `_done`(원본), `_remaining`(getter), `_toggleDone`(setState)로 동작하며 `flutter analyze`와 `flutter test`가 통과했다. 사용자가 `flutter run -d chrome`으로 실행한 화면 캡처 3장이 `evidence/`에 있다.
- 상태 소유자와 이유: `_TaskPageState`. 완료 여부를 읽는 위젯(카드 아이콘·버튼, 상단 숫자)이 모두 `TaskPage` 안에 있어 한 곳에서 소유하면 충분하다. 다른 화면과 공유할 필요가 없다.

## 이번 작업에 필요한 자료

| 자료 | 이번 작업에 필요한 이유 | 확인한 사실 |
|---|---|---|
| `lib/main.dart` | 실제 화면·상태·TODO를 확인 | 원본 `_done`, 계산 `_remaining`, 이벤트 `_toggleDone`, 화면 `TaskPage` |
| `STATE_CONTEXT_MAP.md` | 원본 상태와 영향 범위를 확인 | 완료 여부만 원본, 남은 수는 계산값 |
| `test/widget_test.dart` | AC1~AC3를 자동으로 확인 | 문구 `완료`/`취소`/`남은 할 일: N`에 의존 |
| Flutter `State.setState` 문서 | 갱신 알림의 API 계약을 확인 | 이 문서는 이번 세션에서 열어 보지 않았다. `setState` 안에서 값을 바꾸면 build가 다시 호출된다는 점은 테스트 통과로만 확인했다 |

관련 없는 파일을 제외한 이유: 플랫폼 폴더(`android`, `ios` 등)와 `pubspec.yaml`은 상태 로직과 무관하다.  
새 오류가 다른 파일을 가리킬 때 범위를 넓히는 기준: `flutter analyze`나 `flutter test`의 첫 오류가 가리키는 파일만 추가로 읽는다.

## 변경 계약과 인수 조건

- 수정 범위: `TODO(AC1)` ~ `TODO(AC3)`과 직접 관련된 표시 코드, 그리고 기본 카운터 테스트를 대체한 `test/widget_test.dart`
- 금지 범위: 새 패키지, 서버, 로그인, 영구 저장, 새 화면
- AC1: 시작 화면에 할 일 두 개와 남은 수 2
- AC2: 첫 항목 완료·취소 시 카드 표시가 왕복
- AC3: 같은 동작에서 남은 수가 2→1→2
- 검사 명령: `flutter analyze`, `flutter test`
- 증거: `evidence/ac1-initial.png`, `ac2-done.png`, `ac2-undone.png` (크롬 실행 화면. 상단 `남은 할 일` 숫자가 2→1→2, 첫 카드가 ○+[완료] → ✓+[취소] → ○+[완료]로 바뀐 것을 확인)

## 실패와 갱신

| 관찰 시점 | 실제 값·화면 | 기대값 | 첫 오류·관련 코드 | 다음 행동 |
|---|---|---|---|---|
| 프로젝트 생성 | `setup-week5.cmd`가 `flutter create` 직후 멈추고 `SETUP_OK`를 출력하지 않음. 파일 복사·`git init`·`evidence` 생성이 되지 않음 | `SETUP_OK` 출력과 파일 복사 | 스크립트가 `flutter create`를 `call` 없이 호출(추정, 원인 확인은 하지 않음) | 나머지 단계를 수동으로 실행함 |
| `flutter analyze` | `No issues found!` | 오류 0개 | 없음 | 결과를 `evidence/analyze.txt`에 저장함 |
| `flutter test` | 2개 테스트 모두 통과 | 통과 | 없음 | 결과를 `evidence/test.txt`에 저장함 |

## 다음 작업을 위한 인계

- 완료한 AC: AC1~AC3는 위젯 테스트로 확인. AC4는 코드 검토(`_remaining`이 getter이고 별도 저장 변수 없음)로 확인
- 아직 미확인 또는 실패한 AC: 없음. 단, 화면 캡처는 크롬(웹) 실행만 있고 안드로이드·iOS 에뮬레이터 실행은 하지 않았다. `PROMPT_COMPARISON.md`의 A/B는 각 1회 실행해 관찰을 적었고(응답 원문은 `evidence/response_A.md`, `response_B.md`), 한계는 그 문서의 "한계" 절에 있음
- 선택한 상태 소유자와 근거: `_TaskPageState` — 읽는 위젯이 모두 `TaskPage` 안에 있음
- 증거 파일과 분석 결과 위치: `evidence/analyze.txt`, `evidence/test.txt`, 화면 `evidence/ac1-initial.png`·`ac2-done.png`·`ac2-undone.png`
- 다음 한 행동: git commit (사용자가 요청할 때)
