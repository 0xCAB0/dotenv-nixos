{ config, ... }:

{

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # vi insert keymap
    defaultKeymap = "viins";
    shellAliases = {
      # substituted with eza aliases
      #            ll = "lsd -l";
      #            la = "lsd -la";
      #            tree = "lsd --tree";
      update = "sudo nixos-rebuild switch";
     gsudo = "sudo -E -u $(logname) git";
    };
    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };

    envExtra = builtins.readFile ./zsh/envExtra.zsh;
    initContent = builtins.readFile ./zsh/initExtra.zsh;
  };
}
