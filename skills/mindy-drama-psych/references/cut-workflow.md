# 路線 A · 剪片工作流（ffmpeg-skill）

適用：硬碟上已有譚松韻劇集片段，要剪成心理學短片。

## 前置

- 本機已裝 `ffmpeg-skill`（`npx ffmpeg-skill --cursor`）
- `references/paths.json` 已填 `ssd_root` 與素材夾
- 能 `ls` 到素材（讀不到就停，請使用者掛載硬碟或改路徑）

## 步驟

### 1. 定概念與場次

- 讀 `writing-rules.md`、`first-episode.md`（或使用者指定的新概念）
- 寫 3–6 句旁白大綱＋需要畫面的時間情緒（進校／被壓／考砸…）
- 標出「文件依據的動作」vs「不可演的推測」

### 2. 找素材

```bash
# 例：列出首選資料夾（依 paths.json 替換）
ls "$SSD_ROOT/TV/2016 耿耿單人三無分段案"
```

選 2–5 段能對上開場動作的 clip。說不清時間碼時，先 `probe`／抽帧 `look` 再決定。

### 3. 剪輯鏈（ffmpeg-skill）

在 ffmpeg-skill 的 scripts 目錄執行（或經 MCP）。固定順序：

1. `probe.py` 每個來源
2. `cut.py` 取出段落（可 `--segments`；要準用 `--accurate` 或 `--smart`）
3. `join.py` 拼接（需要轉場再加）
4. `fit.py --aspect 9:16 --fit crop`（主體不在正中時調 `--crop-x`／`--crop-y`）
5. 可選：`silence.py`（口播轨才去靜音；劇情對白轨慎用）
6. `loudness.py` → 約 −14 LUFS
7. `caption.py`：只燒**心理說明**字幕（你寫的旁白／概念句），不要虛構角色對白
8. `export.py --preset reels`（或 shorts）
9. `check.py --platform reels`
10. `look.py` 出 contact sheet，目視安全區

多步驟時優先寫 `project.json` 用 `render.py` 一次跑完。

### 4. 輸出

- 寫入 `paths.json` → `output_dir`
- 檔名建議：`YYYYMMDD-概念短名-劇短名.mp4`  
  例：`20261119-big-fish-little-pond-best-of-us.mp4`

### 5. 交片回報

依主 `SKILL.md` 的回報格式；附上用了哪些來源檔、切了哪些時間碼。

## 常見坑

- Cloud Agent 看不到 `/Volumes/...` → 請使用者改本機 Cursor
- 劇情轨亂跑 `silence --filler` 會切壞對白
- 字幕不要劇透過度；概念句短、大
- 版權與平台標示：提醒一次即可
