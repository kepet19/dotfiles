require("telescope").load_extension("git_worktree")
require("git-worktree").setup({
    autopush = false, -- default: false,
    update_on_change = true, -- default: true,
    clearjumps_on_change = true -- default: true,
    -- change_directory_command = "cd" -- default: "cd",
    -- update_on_change_command = "e ." -- default: "e .",
})
