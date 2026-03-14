return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      -- vim
      -- 'vim',
      -- 'vimdoc',
      'lua',
      'luadoc',
      -- web
      -- 'html',
      -- 'css',
      -- 'javascript',
      -- 'typescript',
      -- 'tsx',
      --
      'python',
      'rust',
      --
      'c',
      'cpp',
      'cmake',
      -- 'cuda',
      --
      'markdown',
      'markdown_inline',
      'yaml',
      'toml',
      'bash',
      -- 'dockerfile',
      -- 'terraform',
      'just',
      'java',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    package.loaded['nvim-treesitter.configs'] = {
      is_enabled = function(module, lang, bufnr)
        if module ~= 'highlight' then
          return true
        end

        local config = opts.highlight or {}
        if config.enable == false then
          return false
        end

        local disabled = config.disable
        if type(disabled) == 'function' then
          return not disabled(lang, bufnr)
        end
        if type(disabled) == 'table' then
          return not vim.tbl_contains(disabled, lang)
        end

        return true
      end,
      get_module = function(module)
        if module == 'highlight' then
          return opts.highlight or {}
        end
        return {}
      end,
    }
    local ok_parsers, parsers = pcall(require, 'nvim-treesitter.parsers')
    if ok_parsers and parsers.ft_to_lang == nil then
      -- Telescope 0.1.x still calls this helper, but newer nvim-treesitter relies
      -- on Neovim's built-in filetype-to-language mapping API instead.
      parsers.ft_to_lang = function(ft)
        return vim.treesitter.language.get_lang(ft) or ft
      end
    end
    if ok_parsers and parsers.get_parser == nil then
      parsers.get_parser = function(bufnr, lang)
        return vim.treesitter.get_parser(bufnr, lang)
      end
    end
    ---@diagnostic disable-next-line: missing-fields
    local ok, ts = pcall(require, 'nvim-treesitter')
    if ok then
      ts.setup(opts)
      return
    end
    -- Backward compatibility for older nvim-treesitter releases.
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
