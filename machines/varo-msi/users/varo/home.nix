{ pkgs, ... }:

{


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "varo";
  home.homeDirectory = "/home/varo";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    ### CLI utilities
    lsd
    tree
    bat
    ripgrep
    nmap
    fzf

    ## Clipboard managers
    xclip
    wl-clipboard

    sherlock
    ## Languages
    nodejs
    gcc

    ## LSPs
    nil
    nixd
    gnumake
    ## Video and audio management
    obs-studio
    ffmpeg
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  #  home.file.".config/oh-my-posh/config.json" = {
  #    source = ./pxp9.json;
  #  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pxp9/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ## Editors

    ./programs/zed.nix
    ./programs/helix.nix

    ## CLI Tools
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/eza.nix
    ./programs/oh-my-posh.nix
    ./programs/direnv.nix
    ./programs/ssh.nix
    ## Terminal tooling
    ./programs/alacritty.nix
    ./programs/ghostty.nix
    ./programs/tmux.nix
  ];

}
