return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "neogen comment",
      },
      opts = { snippet_engine = "luasnip" },
    },
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
}
