#!/bin/zsh

# Define the session name
SESSION="workspace"

# Create a new detached session for the first project (scratch)
tmux new-session -d -s $SESSION -c ~ -n scratch

# Create new windows for each subsequent project
tmux new-window -t $SESSION -c "lvim ${CHESSCOM_PATH}/explanation-engine" -n cee-microservice
tmux new-window -t $SESSION -c "lvim ${CHESSCOM_PATH}/ceac" -n ceac
tmux new-window -t $SESSION -c "lvim ${WORKSPACE_PATH}/lua/project-term" -n project-term
tmux new-window -t $SESSION -c "lvim ${CHESSCOM_PATH}/explanation-engine" -n explanation-engine
tmux new-window -t $SESSION -c "lvim ${HOME}/.config/lvim/" -n lunarvim
tmux new-window -t $SESSION -c "lvim ${WORKSPACE_PATH}/dotfiles" -n dotfiles

# tmux new-window -t $SESSION -c "cd ${WORKSPACE_PATH}/dotfiles && lvim" -n dotfiles
# tmux new-window -t $SESSION -c "cd ${WORKSPACE_PATH}/dotfiles && lvim" -n dotfiles

# Attach to the session
tmux attach -t $SESSION

echo ${CHESSCOM_PATH}
