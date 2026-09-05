# ProgramProxy

Windows one-click proxy: double-click a script to start local proxy and open browser.

Based on: https://github.com/Alvin9999-newpac

## Requirements

- Run as administrator (script auto-elevates)
- At least one browser: Chrome / Edge / Firefox
- Extract fully to local disk before running (not from inside a zip)
- Antivirus may flag proxy programs — add exclusion if needed

## First-time Use

Config files are not included in the repo. First run must fetch them:

1. Double-click any script (e.g. `1_clash_metaFQ.cmd`)
2. In the IP update prompt, press `1` (don't skip), wait for download
3. Done — use normally from now on

## How to Use

1. Pick browser by prefix, then protocol by number (lower = more common):
   - Number prefix → Chrome, e.g. `1_clash_metaFQ.cmd`
   - `E` prefix → Edge, e.g. `E1_clash_metaFQEdge.cmd`
   - `F` prefix → Firefox, e.g. `F1_clash_metaFQFirefox.cmd`
2. IP update prompt: just wait for countdown to auto-skip;
   only press `1` when connection is broken or very slow
   (update may give worse IPs — don't update if it works)
3. Browser opens automatically after proxy starts
4. If main script crashes, use the `backup` version (e.g. `1_clash_metaFQ_backup.cmd`)

Try them in order — pick whichever is fastest.

## Proxy for Other Apps

Proxy listens locally, does NOT change system settings:

- Clash.Meta: `127.0.0.1:7890` (HTTP)
- Xray / SingBox / Hysteria etc: `127.0.0.1:1080` (SOCKS5)

Command line:

```cmd
set HTTP_PROXY=http://127.0.0.1:7890
set HTTPS_PROXY=http://127.0.0.1:7890
set ALL_PROXY=socks5://127.0.0.1:1080
```

Use `proxy_launcher.cmd` to launch any app with proxy env (opencode, git, python etc.):

1. Double-click to run, select proxy type (Clash.Meta / Xray / SingBox / Hysteria,
   or use already-running proxy)
2. Drag the exe into the window (or type full path), press Enter
3. Only works for apps that read proxy env vars;
   Chrome / Edge / Firefox don't — use the browser scripts above

## IP Update

When nodes fail or slow down, pick IP update in the script to fetch from source.

Issues: freeman105@gmail.com

Auto-reply, no support. Subject must not be blank.

## License

MIT License — see [LICENSE](LICENSE)
