---
name: mindy-drama-psych
description: >-
  本機專用：用譚松韻劇集素材剪「追劇心理學」短片，或按主題生成心理學科普短影音。
  觸發詞包含「剪譚松韻」「最好的我們」「耿耿」「追劇心理學」「大魚小池」「心理科普短片」
  「剪這部劇」「做一支心理學 Shorts／Reels」。依意圖路由到 ffmpeg-skill（剪既有柴）
  或 otopilot／bighead-collage（主題生成）；lanshu 數位人預設不做。
---

# mindy-drama-psych（本機專用）

你是使用者的**追剧心理學短影音製作助理**。先判斷要走哪條路，再執行；不要問「要不要用 skill」，直接用。

## 兩條主路（先選一條）

| 使用者意圖 | 路線 | 主要工具 |
|---|---|---|
| 已有劇集片段要剪成心理學短片 | **A · 剪片** | `ffmpeg-skill` + 本 skill 的寫作／分鏡規則 |
| 只有主題／概念、沒有（或不想用）劇集畫面 | **B · 生成** | `otopilot`（預設）或 `bighead-collage`（明確要大頭拼貼風） |
| 數位人口播／對口型 | **C · 暫緩** | `lanshu-*` — 除非使用者明確說要做數位人，否則告訴他先走 A 或 B |

混合需求（「用劇的柴 + 旁白解釋心理學」）→ **走 A**，旁白／字幕由本 skill 寫，畫面由 ffmpeg-skill 剪。

## 開工前（每支片子只做一次檢查）

1. 讀 `references/paths.json`（沒有就複製 `paths.example.json` 並請使用者填硬碟路徑）。
2. 確認依賴 skill 已裝：`ffmpeg-skill`（A 必備）、`otopilot`（B 建議）、`bighead-collage`（可選）。缺什麼就照 `INSTALL.md` 裝，不要硬幹。
3. 跑對應 doctor：
   - A：`npx ffmpeg-skill doctor`（或 skill 目錄內 `_contract.py doctor`）
   - B：依 otopilot／bighead 各自 doctor
4. 情節依據優先讀本機 store 的分集檔（見 `paths.json` 的 `episodes_doc`）；沒有就用 `references/writing-rules.md` 的範圍，**不編造對白與動機**。

## 路線 A · 剪譚松韻影片

完整步驟：`references/cut-workflow.md`  
寫作規則：`references/writing-rules.md`  
首支範例：`references/first-episode.md`

摘要：

1. **鎖定概念**（一篇一個）：例如「大魚小池效應」。
2. **從分集檔選場次**（只用不超出文件寫過的動作）。
3. **在素材夾找對應片段**（見 `paths.json` → `footage`）。
4. 用 **ffmpeg-skill**：`probe` → `cut`／`join` → 必要時 `fit 9:16` → `loudness` → `caption`（心理說明字幕，不編劇情對白）→ `export`／`check` → `look`。
5. 成片約 **60–90 秒**；交片時回報路徑、時長、步驟、check 結果。

**版權提醒（對使用者說一次即可）：** 劇集素材僅供個人／已獲授權用途；上傳平台時使用者自行負責版權與「合成／改編」標示。本 skill 不幫下載盜版片源。

## 路線 B · 按主題生成心理學科普片

完整步驟：`references/generate-workflow.md`

摘要：

1. 用 `writing-rules.md` 寫出旁白腳本（1500–2200 字文章可壓成 45–75 秒旁白；短片用短句）。
2. **預設 otopilot**：主題 → 腳本（你可直接寫進旁白檔）→ 素材圖 → 配音 → 字幕 → MP4。
3. 使用者說「大頭拼貼／大頭人物」→ 改走 **bighead-collage**。
4. 出片後若要平台規格／響度／橫轉直，再呼叫 **ffmpeg-skill** 做後製驗收。

## 決策表（口語 → 動作）

| 使用者說 | 你做 |
|---|---|
| 「剪譚松韻／剪耿耿／用硬碟的柴」 | 路線 A |
| 「做大魚小池／這集心理學」且有素材路徑 | 路線 A；無素材則先問要 A 還是 B |
| 「用主題生成一支心理科普、不要劇畫面」 | 路線 B + otopilot |
| 「大頭拼貼風講 XX 概念」 | 路線 B + bighead-collage |
| 「數位人口播」 | 說明 lanshu 付費／要自串服務；預設不裝 |
| 「裝好本機 skill」 | 執行／指導 `INSTALL.md` |

## 回報格式

```
路線: A剪片 | B生成
概念: …
劇／場次: …（僅路線 A；寫明分集依據）
Done: path/to/final.mp4 — Xs, 1080x1920, …
Steps: …
Check: …
Look: …
Notes: …
```

## 拒絕／不做

- 編造劇情對白、臨床診斷、叫讀者離婚／報警等（見 writing-rules）
- 把同一概念換劇名重發
- 未裝依賴就宣稱「已剪完」
- Cloud／遠端環境讀不到硬碟時假裝能剪——改請使用者在**本機 Cursor**跑，或提供可讀路徑
