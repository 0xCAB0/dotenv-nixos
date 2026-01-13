# WSL-specific configuration
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-wsl.nixosModules.default
  ];

  networking.hostName = "nixos-wsl";

  wsl.enable = true;
  wsl.defaultUser = "varo";

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
  ];

  # WSL-specific packages
  environment.systemPackages = with pkgs; [
    kmod
  ];
}
