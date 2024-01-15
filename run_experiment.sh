#!/bin/bash

SESSION_NAME="servers"

# Start a new tmux session and window
tmux new-session -d -s $SESSION_NAME

# Split the window into three panes
tmux split-window -h
tmux split-window -h

# Select the first pane and start the first server
tmux select-pane -t 0
tmux send-keys "python -m src.server.task_controller -p 4000" C-m

# Select the second pane and start the second server
tmux select-pane -t 1
tmux send-keys "python -m src.start_task -p 4001 --controller http://0.0.0.0:4000/api" C-m

# Select the third pane and start the third server
tmux select-pane -t 2
tmux send-keys "python -m src.assigner" C-m

# Adjust the panes to provide equal spacing
tmux select-layout even-horizontal

# Attach to the session
tmux attach -t $SESSION_NAME
