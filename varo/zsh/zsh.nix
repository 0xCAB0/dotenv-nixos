{ config, pkgs, ... }:
{
programs.zsh = {
  enable = true ;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  defaultKeymap = "viins";
  envExtra = builtins.readFile(./envExtra.zsh);
  initExtra = builtins.readFile(./initExtra.zsh);
  shellAliases = {
	tree = "lsd --tree";
	};
};


}
