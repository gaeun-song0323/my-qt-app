# 나만의 QT 노트 — 웹 버전 (아이폰 홈 화면 앱)

이 폴더 하나를 그대로 GitHub Pages 저장소에 올리면, 폰 브라우저로 열고 **홈 화면에 추가**해서
앱처럼 쓸 수 있습니다. 기록은 그 브라우저(홈 화면 앱) 안에만 저장됩니다.

## 들어 있는 것

| 파일 | 쓰임 |
| --- | --- |
| `index.html` | 앱 전체 (앱 `qt-app/index.html`과 똑같은 한 장, 3.25MB) |
| `manifest.json` | 홈 화면에 추가할 때 쓰는 이름·색·아이콘 |
| `apple-touch-icon.png` | 180×180 · 아이폰 홈 화면 아이콘 |
| `icon-192.png` / `icon-512.png` | 안드로이드·브라우저용 아이콘 |
| `icon-maskable-512.png` | 안드로이드가 모양을 잘라 쓰는 아이콘 |
| `sw.js` | 인터넷이 끊겨도 열리도록 하는 오프라인 캐시 |
| `.nojekyll` | GitHub Pages 가 파일을 그대로 내보내도록 |
| `push_to_pages.sh` | 저장소를 만든 뒤 올리고 Pages 를 켜는 스크립트 |

`index.html`·아이콘·`manifest.json` 은 `cd qt-app && python3 make_web.py` 로 다시 만듭니다.
(`sw.js`·`.nojekyll`·이 설명서는 손으로 둔 파일이라 그대로 남습니다.)

## GitHub에 올리기

1. GitHub에서 새 저장소를 만든다 — 이름 `my-qt-app`, 공개(Public)로.
   (Pages를 무료로 쓰려면 Public 이어야 합니다. 기록은 폰 안에만 저장되니 올라가는 개인 정보는 없습니다.)
2. 이 폴더에서:

       cd qt-app/web
       git init
       git add -A
       git commit -m "나만의 QT 노트 웹 버전"
       git branch -M main
       git remote add origin https://github.com/gaeun-song0323/my-qt-app.git
       git push -u origin main

3. 저장소 → **Settings → Pages** → Source: *Deploy from a branch*, Branch: `main` / `/ (root)` → Save
4. 1~2분 뒤 주소가 열립니다: `https://gaeun-song0323.github.io/my-qt-app/`

저장소를 만든 뒤에는 `sh push_to_pages.sh` 한 번으로 2~3번까지 할 수도 있습니다
(Pages 켜기도 시도하고, 주소를 알려 줍니다).

## 아이폰에서 홈 화면에 추가

1. **Safari** 로 위 주소를 연다 (크롬 말고 사파리여야 홈 화면 앱으로 붙습니다).
2. 아래 **공유** 버튼 → **홈 화면에 추가**.
3. 이름이 `나만의 QT 노트` 로 들어갑니다 → **추가**.
4. 홈 화면 아이콘으로 열면 주소창 없이 앱처럼 열립니다.

## 알아 둘 것

- **기록은 기기·브라우저마다 따로** 저장됩니다. APK 앱에 적은 기록은 웹 버전에 자동으로 넘어오지 않습니다.
  옮기려면 앱에서 **기록 내보내기** → 웹에서 **가져오기** 로 JSON 파일을 옮겨 주세요.
- 인터넷이 끊겨도 열리도록 첫 방문 때 파일을 저장해 둡니다(서비스 워커). 한 번은 인터넷으로 열어야 합니다.
- 앱을 지우거나 브라우저 저장소를 지우면 기록도 지워집니다. 가끔 **기록 내보내기**로 백업해 두세요.
- 새로 올린 파일이 폰에 바로 반영되지 않을 때는 홈 화면 앱을 지웠다가 다시 추가하면 됩니다.
  (GitHub Pages 자체 캐시 때문에 10분 정도 걸릴 수 있습니다.)
- 매일 알림은 아이폰 웹앱에서 화면을 열어 둘 때만 뜹니다. 앱을 닫아 둔 채로 울리는 알림은 APK 앱 쪽이 확실합니다.

## 확인 (개발용)

    cd qt-app/src
    python3 test_web.py     # 로컬 서버 + Chromium, 아이폰 390×844 화면으로 검사
