#!/bin/sh
# 아이폰 홈 화면(웹앱) 버전을 GitHub Pages 에 올립니다.
#   가은님이 GitHub 에서 저장소를 만들어 주신 뒤에 한 번 실행하세요.
#
#   sh push_to_pages.sh            # 기본 이름 my-qt-app
#   sh push_to_pages.sh qt-note    # 다른 이름
#
# 저장소는 Public 이어야 Pages 를 무료로 씁니다. (기록은 폰 안에만 저장되므로 올라가는 개인 정보는 없습니다.)
set -e
REPO_NAME="${1:-my-qt-app}"
OWNER="gaeun-song0323"
cd "$(dirname "$0")"

if ! gh repo view "$OWNER/$REPO_NAME" >/dev/null 2>&1; then
  echo "저장소 $OWNER/$REPO_NAME 이(가) 아직 없습니다."
  echo "GitHub 에서 Public 저장소를 먼저 만들어 주세요 (README.md 'GitHub에 올리기' 참고)."
  exit 1
fi

if [ ! -d .git ]; then
  git init -b main
fi
git add -A
git commit -m "나만의 QT 노트 웹 버전" || echo "바뀐 내용이 없습니다."
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/$OWNER/$REPO_NAME.git"
git branch -M main
git push -u origin main

# Pages 켜기 (이미 켜져 있으면 그대로 둡니다)
gh api -X POST "repos/$OWNER/$REPO_NAME/pages" \
  -f 'source[branch]=main' -f 'source[path]=/' >/dev/null 2>&1 \
  || echo "Pages 는 저장소 Settings → Pages 에서 Branch: main / (root) 로 한 번만 켜 주세요."

echo
echo "올렸습니다. 1~2분 뒤 아래 주소를 사파리로 열고 '홈 화면에 추가' 하세요."
echo "  https://$OWNER.github.io/$REPO_NAME/"
