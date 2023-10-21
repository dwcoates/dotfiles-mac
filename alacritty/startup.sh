#!/bin/zsh

# Define the session name
SESSION="workspace"

# Create a new detached session for the first project (scratch)
tmux new-session -d -s $SESSION -c ~ -n scratch

# Create new windows for each subsequent project
tmux new-window -t $SESSION -c ${CHESSCOM_PATH}/explanation-engine -n cee-microservice
tmux send-keys -t $SESSION:cee-microservice 'lvim' C-m

tmux new-window -t $SESSION -c ${CHESSCOM_PATH}/ceac -n ceac
tmux send-keys -t $SESSION:ceac 'lvim' C-m

tmux new-window -t $SESSION -c ${WORKSPACE_PATH}/lua/project-term -n project-term
tmux send-keys -t $SESSION:project-term 'lvim' C-m

tmux new-window -t $SESSION -c ${CHESSCOM_PATH}/explanation-engine -n explanation-engine
tmux send-keys -t $SESSION:explanation-engine 'lvim' C-m

tmux new-window -t $SESSION -c ${HOME}/.config/lvim/ -n lunarvim
tmux send-keys -t $SESSION:lunarvim 'lvim' C-m

tmux new-window -t $SESSION -c ${WORKSPACE_PATH}/dotfiles -n dotfiles
tmux send-keys -t $SESSION:dotfiles 'lvim' C-m

# Attach to the session
tmux attach -t $SESSION

echo ${CHESSCOM_PATH}
