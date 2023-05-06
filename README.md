Darcula_dark.nvim
# Darcula_dark.nvim
A color-scheme that was heavily inspired by Jetbrains Dark theme, but was carefully refined to bring a more pleasant, aesthetic, and contrasting experience to our beloved Neovim. It uses `rktjmp/lush.nvim` and was created by heavily modifying `briones-gabriel/darcula-solid.nvim`.

## ✨ Features
* [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) support
* [NvimTree](https://github.com/kyazdani42/nvim-tree.lua) support
* 256 colors
* Beautiful contrasting (IntelliJ like) colors
* LSP token support for Go

## ⚡ Requirements
* `termguicolors` enabled for true color support
* (recommended) [Neovim 0.8](https://github.com/neovim/neovim/releases)
* (recommended) [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## 📦 Instalation
With [Packer](https://github.com/wbthomason/packer.nvim)
```lua
use { "vermdeep/darcula_dark.nvim", requires = "rktjmp/lush.nvim" }
```
With [Plug](https://github.com/junegunn/vim-plug)
```lua
Plug 'vermdeep/darcula_dark.nvim'
Plug 'rktjmp/lush.nvim'
```

With [Lazy](https://github.com/folke/lazy.nvim)
```lua
  {
    'vermdeep/darcula_dark.nvim'
    lazy = false,
    priority = 1002,
    config = function(_, opts)
      -- enable colorscheme
      vim.cmd 'set termguicolors'
      vim.cmd([[colorscheme darcula_dark]])
    end
  },
  {
    'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
      'vermdeep/darcula_dark.nvim'
    },
  },
```

Or you can use your favorite plugin manager.

## 🔧 Configuration
In your `init.vim`:
```vim
colorscheme darcula_dark
set termguicolors
```

Or in `init.lua`:
```lua
vim.cmd 'colorscheme darcula_dark'
vim.cmd 'set termguicolors'
```
And because the plugin is build with [Lush](https://github.com/rktjmp/lush.nvim), you can freely copy and edit the color-scheme to fit your needs.

## How to customize
1. Create a `colors` directory if it doesn't exist at `~/.config/nvim/colors`.
2. Create a file for the modified theme: e.g `~/.config/nvim/colors/darcula_dark-custom`.
3. Set your modifications:
```lua
vim.opt.background = 'dark'
vim.g.colors_name = 'darcula_dark-custom'

local lush = require('lush')
local darcula_dark = require('lush_theme.darcula_dark')
local spec = lush.extends({darcula_dark}).with(function()
  -- Your modifications go here...
  -- Pallete copied from https://github.com/vermdeep/darcula_dark.nvim/blob/main/lua/lush_theme/darcula_dark.lua
  local yellow  = lush.hsl(37, 100, 71)

  return {
    Type { fg = yellow },
    Function { fg = darcula_solid.Normal.fg },
  }
end)

lush(spec)
```
4. In your config file (e.g. ~/.config/nvim/init.lua) set the theme to your custom one as follows:
```lua
vim.cmd("colorscheme darcula_dark-custom")
```

## Preview
![darcula_dark](https://raw.githubusercontent.com/vermdeep/darcula_dark.nvim/main/resources/darcula_dark-example.png)
