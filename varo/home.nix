{ config, pkgs, ... }:

{
  home.username = "varo";
  home.homeDirectory = "/home/varo";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    lsd
    home-manager
    android-studio
    vscode
    asdf-vm
    wireshark
    postman
    terraform
    xclip
    texliveTeTeX
    nmap
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

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
    ./nvim/nvim.nix
    ./vscode/vscode.nix
    # ./zed/zed.nix
  ];	

}
