local theme = {
    theme = "dropdown",
    border = true,
    layout_strategy = "vertical",
    layout_config = { width = 120, height = 30 },
    borderchars = {
        prompt = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
        results = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
        preview = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
    }
}

require('telescope').setup({
    defaults = {
        border = true,
    },
    pickers = {
        find_files = theme,
        grep_string = theme,
        live_grep = theme,
        buffers = theme,
    },
})
