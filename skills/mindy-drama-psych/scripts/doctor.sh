#!/usr/bin/env bash
# 本機環境自檢：mindy-drama-psych 依賴
set -euo pipefail

ok=0
warn=0
fail=0

say() { printf '%s\n' "$*"; }
pass() { say "✓ $*"; ok=$((ok + 1)); }
soft() { say "⚠ $*"; warn=$((warn + 1)); }
bad() { say "✗ $*"; fail=$((fail + 1)); }

say "=== mindy-drama-psych doctor ==="

if command -v ffmpeg >/dev/null 2>&1; then
  pass "ffmpeg: $(ffmpeg -version 2>&1 | head -1)"
else
  bad "ffmpeg 未安裝（brew install ffmpeg / sudo apt install ffmpeg）"
fi

if command -v ffprobe >/dev/null 2>&1; then
  pass "ffprobe OK"
else
  bad "ffprobe 未安裝"
fi

if command -v python3 >/dev/null 2>&1; then
  pass "python3: $(python3 --version)"
else
  bad "需要 Python 3.10+"
fi

if command -v node >/dev/null 2>&1; then
  pass "node: $(node -v)"
else
  soft "node 未安裝（otopilot 需要 Node 22+）"
fi

SKILL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -f "$SKILL_ROOT/references/paths.json" ]]; then
  pass "已有 references/paths.json"
else
  soft "尚未建立 paths.json（請 cp references/paths.example.json references/paths.json 並填路徑）"
fi

if command -v npx >/dev/null 2>&1 && npx --yes ffmpeg-skill doctor >/dev/null 2>&1; then
  pass "ffmpeg-skill doctor 可跑"
elif [[ -d "${HOME}/.cursor/skills/ffmpeg-skill" ]] || [[ -d "${HOME}/.claude/skills/ffmpeg-skill" ]]; then
  soft "找到 ffmpeg-skill 目錄，但 npx doctor 未通過；請手動 npx ffmpeg-skill doctor"
else
  soft "未偵測到 ffmpeg-skill（剪片路線 A 需要：npx ffmpeg-skill --cursor）"
fi

for d in "${HOME}/.cursor/skills/bighead-collage" "${HOME}/.claude/skills/bighead-collage"; do
  if [[ -d "$d" ]]; then
    pass "bighead-collage: $d"
    break
  fi
done

if [[ -d "${HOME}/tools/otopilot" ]] || [[ -d "${HOME}/otopilot" ]]; then
  pass "找到 otopilot 工作目錄"
else
  soft "未找到 ~/tools/otopilot（主題生成路線 B 建議安裝）"
fi

say ""
say "結果: OK=${ok} WARN=${warn} FAIL=${fail}"
if [[ "$fail" -gt 0 ]]; then
  say "先修 ✗ 再剪片。"
  exit 1
fi
say "WARN 可稍後裝；路線 A 至少需要 ffmpeg + ffmpeg-skill + paths.json。"
exit 0
