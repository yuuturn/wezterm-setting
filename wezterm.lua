-- WezTerm 基本設定
-- https://wezfurlong.org/wezterm/config/lua/config/index.html
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ============================================================
-- 外観
-- ============================================================
-- Oh My Pi Titanium テーマ (https://cskwork.github.io/terminal-theme/)
config.color_schemes = {
  ['Oh My Pi Titanium'] = {
    foreground = '#e8ecf4',
    background = '#151820',
    cursor_bg = '#00b4ff',
    cursor_fg = '#0f1216',
    cursor_border = '#00b4ff',
    selection_fg = '#e8ecf4',
    selection_bg = '#0082b3',
    ansi = {
      '#0f1216', -- black
      '#ff4757', -- red
      '#00ff88', -- green
      '#ffb347', -- yellow
      '#0082b3', -- blue
      '#d4c090', -- magenta
      '#00b4ff', -- cyan
      '#9ca3b0', -- white
    },
    brights = {
      '#2a3038', -- bright black
      '#ff4757', -- bright red
      '#00ff88', -- bright green
      '#d4c090', -- bright yellow
      '#00b4ff', -- bright blue
      '#d4c090', -- bright magenta
      '#00b4ff', -- bright cyan
      '#e8ecf4', -- bright white
    },
  },
}
config.color_scheme = 'Oh My Pi Titanium'

-- フォントとサイズ (Explex 優先、Nerd Fontアイコン用フォールバック付き)
-- バリエーション: Explex / Explex Console / Explex35 / Explex35 Console
config.font = wezterm.font_with_fallback {
  'Explex',
  'JetBrainsMono Nerd Font Mono',
  'Menlo',
}
config.font_size = 13.0

-- カーソル
config.default_cursor_style = 'BlinkingBlock'

-- 行間 / 文字間
config.line_height = 1.1
config.audible_bell = 'Disabled'

-- ウィンドウ
config.window_background_opacity = 0.95
config.window_close_confirmation = 'NeverPrompt'
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

-- タイトルバーにカレントディレクトリを出す
config.window_decorations = 'RESIZE'

-- ============================================================
-- 動作
-- ============================================================
-- スクロールバック量
config.scrollback_lines = 10000

-- 初期ウィンドウサイズ (セル単位: 幅×高さ)
config.initial_cols = 120
config.initial_rows = 32

-- 既定シェル (ここでは zsh。変更する場合は下の行を有効化)
-- config.default_prog = { '/bin/zsh' }

-- タブ/ペインのタイトルをプロセスから推測
config.allow_win32_input_mode = false

-- ============================================================
-- キーバインド
-- ============================================================
config.keys = {
  -- コピー / ペースト
  { key = 'C', mods = 'SHIFT|CTRL', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'Clipboard' },

  -- フォントサイズ
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },

  -- ペイン分割
  { key = 'Enter', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'E', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- ペイン移動
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

  -- タブ
  { key = 'T', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.ActivateTabRelative(1) },

  -- 全画面
  { key = 'F11', mods = '', action = wezterm.action.ToggleFullScreen },

  -- クイックセレクト
  { key = 'Space', mods = 'CTRL|SHIFT', action = wezterm.action.QuickSelect },
}

-- マウス: ドラッグで選択したら自動コピー
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
}

-- ============================================================
-- 起動時 / 再読み込み時の注意
-- ============================================================
-- 設定を変更したら、WezTerm 内で `CTRL+SHIFT+R` で再読み込み。

return config
