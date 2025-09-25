{ ... }:

{

  programs.oh-my-posh = {
    enable = true;

    enableZshIntegration = true;
    enableBashIntegration = false;
    enableFishIntegration = false;

    settings = builtins.fromJSON (builtins.readFile (./oh-my-posh/pxp9.json));
  };

}
