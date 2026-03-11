return {
  'nvim-java/nvim-java',
  config = function()
    require('java').setup {
      lombok = {
        enable = true,
      },
      java_test = {
        enable = false,
      },
      java_debug_adapter = {
        enable = false,
      },
      jdk = {
        auto_install = false,
      },
    }
    vim.lsp.enable 'jdtls'
  end,
}
