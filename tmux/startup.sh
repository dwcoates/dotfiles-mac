#!/bin/zsh

SESSION="workspace"

tmux new-session -d -s $SESSION -c ~ -n scratch # Window 1

function add_window {
    local name=$1
    local dir=$2
    local window=$3
    local cmd1=$4
    
    tmux new-window -t $SESSION:$window  -n $name 
    tmux send-keys -t $SESSION:$window "cd $dir && lvim" Enter

    if [[ -n $cmd1 ]]; then
      tmux send-keys -t $SESSION:$window $cmd1 Enter
    fi
}

add_window 'ceac' $ce 2 
add_window 'dotfiles' $dt 3 ':e ./lvim/config.lua' 
add_window 'explanation-engine' $ee 4 
add_window 'engine-services' $es 5 
add_window 'clue' $cl 6 
add_window 'cee-interface' $ei 7 
add_window 'platform' $pl 8 
add_window 'definitions' $df 9 
add_window 'game-state-cache' "${CHESSCOM_PATH}/gametree" 10 
add_window ceac-clusters-proxy $cp 11
add_window project-term $pt 12

tmux attach -t $SESSION
