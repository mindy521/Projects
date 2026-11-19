# 本機安裝：mindy-drama-psych

在你的電腦（能讀到 Extreme SSD 的那台）安裝。Cloud Agent 讀不到外接硬碟，剪片請用**本機 Cursor**。

## 0. 前置

- Cursor 桌面版（或 Claude Code／Codex）
- FFmpeg 6.1+、Python 3.10+、Node.js 22+（otopilot 需要）
- 外接硬碟已掛載，能開到劇集資料夾

檢查：

```bash
ffmpeg -version
python3 --version
node -v
```

## 1. 安裝這個專用 skill

把本資料夾放到 Cursor skills 目錄（擇一）：

```bash
# 建議：從本 repo 複製
mkdir -p ~/.cursor/skills
cp -R skills/mindy-drama-psych ~/.cursor/skills/mindy-drama-psych

# 或做符號連結（方便跟著 repo 更新）
ln -sfn "$(pwd)/skills/mindy-drama-psych" ~/.cursor/skills/mindy-drama-psych
```

Claude Code 用：

```bash
mkdir -p ~/.claude/skills
ln -sfn "$(pwd)/skills/mindy-drama-psych" ~/.claude/skills/mindy-drama-psych
```

## 2. 安裝依賴 skill

### 必裝：ffmpeg-skill（剪片引擎）

```bash
npx ffmpeg-skill --cursor
npx ffmpeg-skill doctor
```

### 建議：otopilot（主題生成）

```bash
git clone https://github.com/wj-sidiss/otopilot.git ~/tools/otopilot
cd ~/tools/otopilot
npm ci --ignore-scripts
node araclar/doktor.js
```

Cursor／Claude 若以 repo 當工作區，直接開 `~/tools/otopilot` 並依其 `AGENTS.md` 跑即可。  
也可把其 `.claude/skills` 內容鏈到 skills 目錄（依該專案當版說明）。

### 可選：bighead-collage（大頭拼貼風）

```bash
git clone https://github.com/HeyChengC/bighead-collage.git ~/.cursor/skills/bighead-collage
cd ~/.cursor/skills/bighead-collage
pip install -r requirements.txt
npm install
npx playwright install chromium
python scripts/doctor.py
```

### 暫緩：lanshu

不要預設安裝。真要數位人口播再裝：

- https://github.com/cclank/lanshu-infinite-stream-koubo
- https://github.com/cclank/lanshu-create-ai-presenter-video

## 3. 填本機路徑

```bash
cd ~/.cursor/skills/mindy-drama-psych
cp references/paths.example.json references/paths.json
```

編輯 `references/paths.json`：把 `EXTREME_SSD_ROOT` 改成你硬碟實際掛載點，並確認素材夾名稱。

範例（macOS）：

```json
{
  "ssd_root": "/Volumes/Extreme SSD",
  "footage": {
    "geng_geng_solo": "TV/2016 耿耿單人三無分段案",
    "best_of_us": "TV/2016 最好的我們"
  },
  "output_dir": "~/Movies/mindy-drama-psych",
  "episodes_doc": "~/Library/Application Support/Cursor/User/globalStorage/.../tan-songyun-episodes.md"
}
```

`episodes_doc` 若找不到，可先留空；剪片時只用 `references/first-episode.md` 已寫死的場次範圍。

## 4. 一鍵自檢（可選）

```bash
bash ~/.cursor/skills/mindy-drama-psych/scripts/doctor.sh
```

## 5. 怎麼叫我做事

在**本機 Cursor**新對話直接說，例如：

- 「用 mindy-drama-psych：剪第一支大魚小池／耿耿」
- 「路線 A，素材在 Extreme SSD，做成 9:16 Reels」
- 「路線 B，主題是『比較對象換了不是人變笨』，用 otopilot 產片，不要劇畫面」

Agent 應自動讀 `SKILL.md` 並路由。若沒載入，手動：`請讀 ~/.cursor/skills/mindy-drama-psych/SKILL.md 後執行`。
