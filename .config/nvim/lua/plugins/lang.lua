return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          keys = {
            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          --   root_dir = function(fname)
          --             return require("lspconfig.util").root_pattern(
          --               "Makefile",
          --               "configure.ac",
          --               "configure.in",
          --               "config.h.in",
          --               "meson.build",
          --               "meson_options.txt",
          --               "build.ninja"
          --             )(fname) or require("lspconfig.util").root_pattern(
          --               ".clangd",
          --               "compile_commands.json",
          --               "compile_flags.txt"
          --             )(fname) or require("lspconfig.util").find_git_ancestor(fname)
          --   return require("lspconfig.util").root_pattern(".clangd", "compile_commands.json")(fname)
          --  or require("lspconfig.util").find_git_ancestor(fname)
          -- end,
          -- capabilities = {
          -- offsetEncoding = { "utf-16" },
          -- },
          cmd = {
            --  "clangd",
            "/home/yudai/llvm-project/build/bin/clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--query-driver=/home/yudai/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-gcc,/home/yudai/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-g++,xtensa-esp32-elf-gcc*,xtensa-esp32-elf-g++",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },
  {
    import = "lazyvim.plugins.extras.lang.python",
  },
  {
    import = "lazyvim.plugins.extras.lang.markdown",
  },
}
