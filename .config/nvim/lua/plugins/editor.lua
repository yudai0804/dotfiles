return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignore = false,
        },
        hide_by_name = {
          ".DS_Sore",
          "thumbs.db",
        },
        never_show = {},
      },
    },
  },
}
