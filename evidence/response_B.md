# 요청 B 응답 원문

- 실행: 2026-10-18, 독립된 새 세션(Claude Code, claude-sonnet-5-5), 1회 실행
- 시작 폴더: 프로젝트(`week05_state_lab`)의 상위 폴더. 요청 A와 같은 폴더다.
- 요청 원문:
  ```text
  lib/main.dart와 STATE_CONTEXT_MAP.md를 먼저 읽어라.
  CONTEXT_PACKET.md의 목표·제약·AC를 지켜 수정 계획만 제시하라.
  아직 코드를 바꾸지 말고 실제로 확인한 파일·변수와 확인하지 못한 항목을 구분하라.
  ```
- 세션 기록상 도구 호출: Glob 3회, Read 3회, Bash 1회. 파일 수정·생성 없음.

---

**수정 계획 (코드는 바꾸지 않았고 파일도 만들지 않았습니다.)**

`lib/main.dart`의 코드는 바꿀 필요가 없습니다. `CONTEXT_PACKET.md`의 AC1~AC3는 이미 구현돼 있고, 남은 일은 화면 캡처 증거 3장과 커밋입니다.

## 실제로 확인한 것

작업 폴더는 `week05_state_lab/`입니다. 아래 파일을 직접 읽었습니다.

- **`lib/main.dart`**
  - `_done`(원본, `List<bool>`)과 `_titles`(고정 데이터)가 있습니다.
  - `_remaining`은 `_done.where(...)`로 계산하는 getter입니다. 별도 저장 변수는 없어서 AC4를 만족합니다.
  - `_toggleDone(index)`는 `setState` 안에서 `_done[index]`를 뒤집습니다.
  - 아이콘(`check_circle` / `radio_button_unchecked`)과 버튼 문구(`취소` / `완료`)는 `_done[i]`에서 나오고, 상단 "남은 할 일: $_remaining"도 같은 원본에서 나옵니다.
  - `TODO(AC…)` 표시는 남아 있지 않습니다.
- **`STATE_CONTEXT_MAP.md`**: 상태 계약 표의 변수 이름(`_done`, `_remaining`, `_toggleDone`, `TaskPage`, `_TaskPageState`)이 코드와 일치합니다.
- **`CONTEXT_PACKET.md`**
  - 목표는 완료·취소가 카드와 남은 수에 함께 반영되는 것입니다.
  - 금지 범위는 새 패키지, 서버, 로그인, 영구 저장, 새 화면입니다.
  - AC1은 시작 화면에 항목 2개와 남은 수 2, AC2는 카드 표시의 왕복, AC3는 남은 수 2→1→2입니다.
- **추가로 읽은 파일**: `test/widget_test.dart`가 AC1~AC3를 위젯 테스트로 확인합니다. `evidence/`에는 `analyze.txt`와 `test.txt`만 있고 PNG는 없습니다.

## 단계별 계획

1. **코드 변경 없음.** `_done` 원본, `_remaining` getter, `setState` 안의 반전이 AC1~AC3와 AC4를 이미 만족합니다. 금지 범위(새 패키지, 서버, 로그인, 영구 저장, 새 화면)도 건드리지 않습니다.
2. **증거 캡처.** `flutter run`으로 `evidence/ac1-initial.png`(남은 수 2), `ac2-done.png`(첫 항목 완료, 남은 수 1), `ac2-undone.png`(취소 후 남은 수 2)를 저장합니다. 캡처 문구가 `완료`/`취소`/`남은 할 일: N`과 같은지 확인합니다.
3. **재검증.** `flutter analyze`와 `flutter test`를 다시 실행하고 결과를 `evidence/`에 덮어씁니다. 문구를 바꾸게 되면 테스트도 같이 고칩니다.
4. **문서 정리.** `CONTEXT_PACKET.md`의 "화면 캡처는 아직 없다" 문장을 캡처 후에 갱신하고, 그다음 git commit 합니다.

## 확인하지 못한 것

- `flutter analyze`와 `flutter test`가 통과했다는 것은 `CONTEXT_PACKET.md`의 기록과 `evidence/*.txt` 파일 존재만 봤습니다. 이번 세션에서 직접 실행하지 않았고 `.txt` 내용도 열지 않았습니다.
- 실제 화면 동작은 확인하지 못했습니다. 앱을 실행하지 않았고 캡처도 없습니다.
- `setState`의 API 계약은 공식 문서로 확인하지 않았습니다. `CONTEXT_PACKET.md`도 같은 한계를 적고 있고, 근거는 코드 구조와 테스트뿐입니다.
- `PROMPT_COMPARISON.md`는 파일이 있다는 것만 확인했고 내용은 읽지 않았습니다.
- git 상태와 커밋 여부는 확인하지 않았습니다. `.git` 폴더가 있다는 것만 봤습니다.
- 요청에 새 기능 요구가 따로 없어서, 위 계획은 `CONTEXT_PACKET.md`의 AC와 인계 항목을 기준으로 세웠습니다. 다른 변경을 의도하셨다면 알려 주세요.
