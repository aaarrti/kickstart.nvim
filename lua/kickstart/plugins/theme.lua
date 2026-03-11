return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('github-theme').setup({
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath 'cache' .. '/github-theme',
        compile_file_suffix = '_compiled',
        hide_end_of_buffer = true,
        hide_nc_statusline = true,
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        styles = {
          comments = 'NONE',
          functions = 'NONE',
          keywords = 'NONE',
          variables = 'NONE',
          conditionals = 'NONE',
          constants = 'NONE',
          numbers = 'NONE',
          operators = 'NONE',
          strings = 'NONE',
          types = 'NONE',
        },
        inverse = {
          match_paren = false,
          visual = false,
          search = false,
        },
        darken = {
          floats = true,
          sidebars = {
            enable = true,
            list = {},
          },
        },
      },
    })

    vim.cmd 'colorscheme github_dark_default'
  end,
}
