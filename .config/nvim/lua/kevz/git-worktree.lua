require("telescope").load_extension("git_worktree")
require("git-worktree").setup({
    autopush = false,
    update_on_change = true, -- default: true,
    clearjumps_on_change = true -- default: true,
})
