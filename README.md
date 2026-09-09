# WezTerm 設定 (Oh My Pi Titanium テーマ)

macOS 向け WezTerm の基本設定です。テーマは [Oh My Pi Titanium](https://cskwork.github.io/terminal-theme/) をベースにしています。

## ファイル構成

```
WezTerm-setting/
├── wezterm.lua   # WezTerm 設定本体
└── README.md     # この手順書
```

`wezterm.lua` を `~/.wezterm.lua` にシンボリックリンクして使います。

## 必要なもの

- macOS
- [Homebrew](https://brew.sh/)
- WezTerm
- フォント2種（Explex / JetBrains Mono Nerd Font）

## インストール手順（新しい Mac での再現手順）

### 1. Homebrew

未導入ならインストール:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. WezTerm

```bash
brew install --cask wezterm
```

### 3. フォント

**JetBrains Mono Nerd Font**（Nerd Font アイコン用フォールバック）

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

**Explex**（プライマリフォント。日本語対応のプログラミング用等幅フォント）

1. [yuru7/Explex のリリースページ](https://github.com/yuru7/Explex/releases/latest) を開く
2. Assets 内の zip ファイル（例: `Explex_v0.0.3.zip`）をダウンロード
   - 通常版（半角1:全角2）を使う場合は `Explex_v0.0.3.zip`
   - Nerd Font 合成版が必要な場合は `Explex_NF_v0.0.3.zip`（Console 系のみ収録）
3. 展開し、使うバリエーションの TTF を `~/Library/Fonts/` にコピー（標準は `Explex/` 内の4ファイル）:

```bash
mkdir -p ~/Library/Fonts
cp Explex_v0.0.3/Explex/Explex-Regular.ttf \
   Explex_v0.0.3/Explex/Explex-Bold.ttf \
   Explex_v0.0.3/Explex/Explex-Italic.ttf \
   Explex_v0.0.3/Explex/Explex-BoldItalic.ttf \
   ~/Library/Fonts/
ls ~/Library/Fonts/Explex*
```

> Explex にはバリエーション（`Explex` / `Explex Console` / `Explex35` / `Explex35 Console`）があります。
> 切り替える場合は TTF を入れ替えた上で、`wezterm.lua` の `config.font` のファミリー名を変更してください。
> 例: `'Explex'` → `'Explex Console'`
> 非NF版の Explex には Nerd Font アイコンが含まれないため、
> プロンプトや `eza` / `starship` 等のアイコン表示用に JetBrains Mono Nerd Font のフォールバックは残しています。

> Explex は SIL Open Font License 1.1 で商用・非商用どちらも利用可能です。

### 4. 設定の配置

このリポジトリをクローンしてシンボリックリンク:

```bash
git clone https://github.com/<あなたのユーザー名>/WezTerm-setting.git
ln -sfn "$(pwd)/WezTerm-setting/wezterm.lua" ~/.wezterm.lua
```

> リポジトリをクローンせずにファイルだけ持ってくる場合は、`wezterm.lua` を
> `~/work/WezTerm-setting/wezterm.lua` などに置いてからリンクしてください。

### 5. 反映と確認

WezTerm を起動し、`CTRL+SHIFT+R` で設定を再読み込みします。

フォントが正しく当たっているか確認:

```bash
# Explex から描画されていること、半角=1セル・全角=2セルであることを確認
wezterm --config-file ~/.wezterm.lua ls-fonts --text "あいう ABC 01"
ls ~/Library/Fonts/Explex*
```

期待結果の目安: `wezterm.font("Explex", ...)` と表示され、全角 `あ` の `x_adv` が半角 `A` の約2倍になること。

## 設定内容

| 項目 | 値 |
| --- | --- |
| カラースキーム | Oh My Pi Titanium（背景 `#151820` / 前景 `#e8ecf4`） |
| フォント | Explex（優先）→ JetBrainsMono Nerd Font Mono → Menlo |
| フォントサイズ | 13.0pt |
| カーソル | 点滅ブロック |
| 初期ウィンドウサイズ | 120 列 × 32 行（セル単位） |
| スクロールバック | 10000 行 |
| ウィンドウ | 背景透明度 0.95、パディング 4px |
| ベルの音 | 無効 |

## キーバインド

### コピー / ペースト
- `CTRL+SHIFT+C` / `CTRL+SHIFT+V`

### フォントサイズ
- `CTRL+=` 拡大 / `CTRL+-` 縮小 / `CTRL+0` リセット

### ペイン分割
- `CTRL+SHIFT+ENTER` 左右分割
- `CTRL+SHIFT+E` 上下分割
- `CTRL+SHIFT+矢印` ペイン移動

### タブ
- `CTRL+SHIFT+T` 新規タブ
- `CTRL+SHIFT+ALT+←/→` タブ移動

### その他
- `F11` 全画面
- `CTRL+SHIFT+SPACE` クイックセレクト
- 左ドラッグ選択で自動コピー

## GitHub での管理

初回のみ:

```bash
cd WezTerm-setting
git init
git add .
git commit -m "Initial WezTerm config"
git branch -M main
git remote add origin https://github.com/<あなたのユーザー名>/WezTerm-setting.git
git push -u origin main
```

以降は `wezterm.lua` を編集してコミット／プッシュするだけです。

## カスタマイズ

- フォントサイズ: `wezterm.lua` の `config.font_size` を変更
- ウィンドウサイズ: `config.initial_cols` / `config.initial_rows` を変更
- テーマ色: `config.color_schemes` の各色を変更
- キーバインド: `config.keys` を追加／変更

設定変更後は WezTerm 内で `CTRL+SHIFT+R` で再読み込みしてください。
