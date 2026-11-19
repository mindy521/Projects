# 工具堆疊（本對話整理）

## 你專用的路由 skill

| | |
|---|---|
| **mindy-drama-psych** | 本目錄。決定走剪片還是生成，並套用譚松韻心理學寫作規則 |

## 依賴（外部開源）

| Skill | Repo | 角色 | 本機？ | 費用 |
|---|---|---|---|---|
| **ffmpeg-skill** | https://github.com/kajisho5/ffmpeg-skill | 剪既有素材：裁切、9:16、字幕、響度、平台匯出 | 是 | 免費（需本機 FFmpeg） |
| **otopilot** | https://github.com/wj-sidiss/otopilot | 主題 → 完整短影音（腳本／圖／配音／字幕） | 是 | 免費路線可不需 key；自動腳本可選 Claude／vidIQ |
| **bighead-collage** | https://github.com/HeyChengC/bighead-collage | 9:16 大頭拼貼人物短片 | 是 | edge-tts 免費；生圖需自備方式／key；首次 Whisper ~3GB |
| **lanshu 口播** | https://github.com/cclank/lanshu-infinite-stream-koubo | 數位人母帶複用口播 | 控制端本機 | 模型／修圖計費；預設不安裝 |
| lanshu presenter | https://github.com/cclank/lanshu-create-ai-presenter-video | 數位人／12 風格講解 | 同上 | 同上 |

## 怎麼搭配

```
使用者一句話
    │
    ├─ 有劇集柴要剪 ─────────────► ffmpeg-skill（A）
    │                                 ▲
    │                                 │ 後製／驗收也可接
    ├─ 主題生成、無劇畫面 ───────► otopilot（B）───┘
    │
    ├─ 大頭拼貼風 ───────────────► bighead-collage（B′）
    │
    └─ 數位人 ───────────────────► lanshu（C，暫緩）
```

## 與「產片 vs 剪片」

- otopilot／bighead／lanshu：**從無到有產畫面**
- ffmpeg-skill：**剪你已經有的檔案**
- mindy-drama-psych：**內容與路由**（概念、場次、禁寫、交片規格）
