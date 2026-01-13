{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    defaultKeymap = "viins";
    envExtra = builtins.readFile (./envExtra.zsh);
    initContent = builtins.readFile (./initExtra.zsh);
    shellAliases = {
      nixos-update = "just -f /etc/nixos/justfile switch";
      copy = "xclip -selection clip";
      tree = "lsd --tree";
      gsudo = "sudo -E -u $(logname) git";
    };
    siteFunctions = {
      create_flake = ''
        nix flake init --template \"https://flakehub.com/f/the-nix-way/dev-templates/*#"$1"\" && \
        echo \"use flake\" >> .envrc && \
        direnv allow
      '';
    };
  };

}
