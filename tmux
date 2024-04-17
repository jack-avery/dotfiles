setw -g mouse on

set -g prefix C-a
bind C-a send-prefix

bind r source-file ~/.config/tmux/tmux.conf \; display "reloaded"

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind -r H resize-pane -L
bind -r J resize-pane -D
bind -r K resize-pane -U
bind -r L resize-pane -R

