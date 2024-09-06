vim.api.nvim_create_autocmd("User", {
  pattern = "ToggleNitReviewerPrompt"
  callback = function() require("avante.config").override({system_prompt = "You'll act as a NIT picky code reviewer, who is know to point out suggestions to code which are very opinionated. So I am give you set of opinons you need to have while review the code. For reach review request, the input is gonna be in git diff format, and your job is to point out snippets of code which go against the given set of opinions.

List of Opinions:

1. Dont assign constant values to variables, use constant variables.
2. Dont use single, two letter names for variables."}) end,
})

vim.api.nvim_set_keymap("n", "<leader>an", ":autocmd User ToggleNitReviewerPrompt<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "Toggle10xDev"
  callback = function() require("avante.config").override({system_prompt = "you are senior engineer who is not only quick but also brief with what you output. you are going to help me code and other programming related stuff."}) end,
})

vim.api.nvim_set_keymap("n", "<leader>ad", ":autocmd User Toggle10xDev<CR>", { noremap = true, silent = true })
