#!/bin/zsh

SESSION="workspace"

tmux new-session -d -s $SESSION -c ~ -n scratch

tmux new-window -t $SESSION:1  -n cee-microservice
tmux send-keys -t $SESSION:1 'cd $cm && lvim' Enter

tmux new-window -t $SESSION:2  -n ceac
tmux send-keys -t $SESSION:2 'cd $ce && lvim' Enter

tmux new-window -t $SESSION:3  -n dotfiles
tmux send-keys -t $SESSION:3 'cd $dt && lvim' Enter
tmux send-keys -t $SESSION:3 ':e ./lvim/config.lua' Enter

tmux new-window -t $SESSION:4  -n explanation-engine
tmux send-keys -t $SESSION:4 'cd $ee && lvim' Enter

tmux new-window -t $SESSION:5  -n engine-services
tmux send-keys -t $SESSION:5 'cd $es && lvim' Enter

tmux new-window -t $SESSION:6  -n clue
tmux send-keys -t $SESSION:6 'cd $cl && lvim' Enter

tmux new-window -t $SESSION:7  -n cee-interface
tmux send-keys -t $SESSION:7 'cd $ei && lvim' Enter

tmux new-window -t $SESSION:8  -n platform
tmux send-keys -t $SESSION:8 'cd $pl && lvim' Enter

tmux new-window -t $SESSION:9  -n definitions 
tmux send-keys -t $SESSION:9 'cd $df && lvim' Enter

tmux new-window -t $SESSION:10  -n game-state-cache
tmux send-keys -t $SESSION:10 'cd ${CHESSCOM_PATH}/gametree && lvim' Enter

tmux new-window -t $SESSION:11  -n ceac-clusters-proxy 
tmux send-keys -t $SESSION:11 'cd $cp && lvim' Enter

tmux new-window -t $SESSION:12  -n project-term
tmux send-keys -t $SESSION:12 'cd $pt && lvim' Enter

tmux attach -t $SESSION
