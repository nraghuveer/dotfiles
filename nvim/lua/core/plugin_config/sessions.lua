require("sessions").setup({
    events = { "BufEnter" },
    session_filepath = vim.fn.stdpath("data") .. "/sessions",
    absolute = true,
})
-- autoload and setup autosave
require("sessions").load()
require("sessions").start_autosave()
