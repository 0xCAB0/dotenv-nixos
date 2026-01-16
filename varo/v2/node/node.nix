{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_22
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  # Configure npm to use user-local global directory
  home.sessionVariables = {
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  # Add npm global bin to PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];

  # Create npmrc with global prefix configuration
  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm-global
  '';
}
