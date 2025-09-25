{ pkgs, ... }:

{

  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 10;
    baseIndex = 1;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    focusEvents = true;
    mouse = true;

    # Vim like move around split windows
    customPaneNavigationAndResize = true;
    plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];

    extraConfig = "
# Easy config reload
bind-key R source-file ~/.config/tmux/tmux.conf \\; display-message 'tmux.conf reloaded.'
    
# style tmux status

set -g status-bg '#393f3f'
set -g status-fg white
set-window-option -g window-status-style fg='#858585'
set-window-option -g window-status-current-style bright
set -g status-right '%H:%M %p  %a %d %b #{?client_prefix,  ,  }'

## Clipboard

bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

";
  };
}
