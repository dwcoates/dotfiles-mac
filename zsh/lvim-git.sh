#!/bin/bash

# Check if inside a Git repository
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    # If inside a Git repository, get the top-level directory path
    git_root=$(git rev-parse --show-toplevel)
    # Launch LunarVim with the -S option followed by the Git root path, along with any other arguments
    lvim -S "$git_root/.nvim-session.vim" "$@" 
else
    # If not inside a Git repository, launch LunarVim with the original arguments only
    lvim "$@"
fi
