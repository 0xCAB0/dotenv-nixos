{ config, pkgs, ... }:

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
    # Desktop application
    protonvpn-gui
    discord
    telegram-desktop
    vscode
  ];

  home.file = {
  };
  
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts.fontconfig.enable = true;

  programs.neovim = {
  	viAlias = true;
  	vimAlias = true;
  };

  home.shellAliases = {
	cd = "z";
        nixos-update = "just -f /etc/nixos/justfile switch";
        create_flake = "$ echo \"use flake\" >> .envrc && direnv allow";
  };

  programs.home-manager.enable = true;
  programs.home-manager.path = /etc/nixos/varo/home.nix;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.options = [
  "--cmd cd"
  ];
  
  imports = [
    ./zsh/zsh.nix
    ./oh-my-posh/oh-my-posh.nix
    ./direnv/direnv.nix
    ./nvim.nix
    ./vscode/vscode.nix
    ./git.nix
    ./tmux.nix
    ./alacritty.nix
    ./helix.nix
    ./zed/zed.nix
  ];	

}
