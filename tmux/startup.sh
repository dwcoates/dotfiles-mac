#!/bin/zsh

SESSION="workspace"

tmux new-session -d -s $SESSION -c ~ -n scratch # Window 1

## NOTE: Automatic session saving & loading depends on package {dwcoates/project-session}:

function add_window {
    local name=$1
    local dir=$2
    local cmd1=$4
    local window=$3
    
    tmux new-window -t $SESSION:$window  -n $name 
    tmux send-keys -t $SESSION:$window "cd $dir && v" Enter # `v` is set by .zshrc to automatically load the lvim session. See dotfiles/zsh/lvim-git.sh.
    sleep 0.4
    tmux send-keys -t $SESSION:$window 'Escape' 'Space' 'e' Enter 

    if [[ -n $cmd1 ]]; then
      tmux send-keys -t $SESSION:$window $cmd1 Enter
    fi

    tmux split-window -v
    tmux select-pane -D
    tmux send-keys -t $SESSION:$window.2 "cd $dir" Enter # `v` is set by .zshrc to automatically load the lvim session. See dotfiles/zsh/lvim-git.sh.
    tmux resize-pane -y 25
    tmux send-keys -t $SESSION:$window "cd $dir && v" Enter # `v` is set by .zshrc to automatically load the lvim session. See dotfiles/zsh/lvim-git.sh.
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
  add_window 'ceac-clusters-proxy' $cp 11
  add_window 'cee-microservice' $cm 12
  add_window 'puzzlegen-service' $ps 13

  tmux attach -t $SESSION
