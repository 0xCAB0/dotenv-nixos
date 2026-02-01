{ config, pkgs, inputs, system, ... }:

{
  home.username = "varo";
  home.homeDirectory = "/home/varo";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    home-manager
    # Binaries
    act
    lsd
    xclip
    just
    zoxide
    copyq
    hugo
    # Desktop application
    protonvpn-gui
    discord
    telegram-desktop
    vscode
    obsidian
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  fonts.fontconfig.enable = true;

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };

  home.shellAliases = {
    edit = "nvim";
    cd = "z";
  };

  programs.home-manager.enable = true;
  programs.home-manager.path = /etc/nixos/varo/home.nix;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = [
    "--cmd cd"
  ];

  imports = [
    ./v2/zsh/zsh.nix
    ./v2/oh-my-posh/oh-my-posh.nix
    ./v2/direnv/direnv.nix
    ./v2/nvim/nvim.nix
    ./v2/vscode/vscode.nix
    ./v2/git/git.nix
    ./v2/tmux/tmux.nix
    ./v2/alacritty/alacritty.nix
    ./v2/claude/claude.nix
    ./v2/node/node.nix
  ];

}
