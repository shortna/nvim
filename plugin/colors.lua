require("catppuccin").setup({
  flavour = "latte",
  transparent_background = true,
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = { enabled = false },
  no_italic = true,
  no_bold = false,
  no_underline = true,
  styles = {
    comments = {},
    conditionals = {},
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    treesitter = true,
    telescope = {
      enabled = true,
    }
  },
})

vim.cmd.colorscheme "catppuccin"
