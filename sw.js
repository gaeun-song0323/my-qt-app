/* 나만의 QT 노트 — 웹 버전 오프라인 캐시
   인터넷이 끊겨도 홈 화면 앱이 열리도록, 열 때마다 새 파일을 받아 두고
   실패하면 마지막에 받아 둔 파일을 보여 준다(network-first). */
const CACHE = 'qt-note-web-v1';
const ASSETS = [
  './index.html',
  './manifest.json',
  './apple-touch-icon.png',
  './icon-192.png',
  './icon-512.png',
];

self.addEventListener('install', (event) => {
  self.skipWaiting();
  event.waitUntil(
    caches.open(CACHE).then((cache) => cache.addAll(ASSETS)).catch(() => {})
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    const keys = await caches.keys();
    await Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)));
    await self.clients.claim();
  })());
});

self.addEventListener('fetch', (event) => {
  const req = event.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return; // 폰트 등 바깥 파일은 브라우저에 맡긴다

  event.respondWith((async () => {
    const cache = await caches.open(CACHE);
    try {
      const fresh = await fetch(req);
      if (fresh && fresh.ok) cache.put(req, fresh.clone());
      return fresh;
    } catch (err) {
      const hit = await cache.match(req, { ignoreSearch: true });
      if (hit) return hit;
      const shell = await cache.match('./index.html');
      if (shell) return shell;
      throw err;
    }
  })());
});
