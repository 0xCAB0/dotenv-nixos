{ ... }:

{

  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;
    installVimSyntax = true;
    installBatSyntax = true;

    settings = {

      font-family = "Hack Nerd Font Mono Bold";
      font-size = 21;
      theme = "Monokai Classic";
      gtk-titlebar = false;
      background-opacity = 1;
      background-blur-radius = 20;
    };
  };

}
