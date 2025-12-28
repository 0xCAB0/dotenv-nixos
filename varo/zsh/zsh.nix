{ config, pkgs, ... }:
{
programs.zsh = {
  enable = true ;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  defaultKeymap = "viins";
  envExtra = builtins.readFile(./envExtra.zsh);
  initContent = builtins.readFile(./initExtra.zsh);
  shellAliases = {
	copy = "xclip -selection clip";
	tree = "lsd --tree";
    gsudo = "sudo -E -u $(logname) git";
	};
};


} 
