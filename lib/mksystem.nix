# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{
  nixpkgs,
  overlays,
  inputs,
}:

name:
{
  system,
  users,
  darwin ? false,
  wsl ? false,
}:

let
  # True if this is a WSL system.
  isWSL = wsl;
  isLinux = !darwin && !wsl;

  # The config files for this system.

  machineConfig = ../machines/${name}/configuration.nix;
  user_names = nixpkgs.lib.attrNames users;
  usersHMConfig = nixpkgs.lib.lists.foldr (
    user: acc: acc // { ${user} = import ../machines/varo-msi/users/${user}/home.nix; }
  ) { } user_names;

  # NixOS vs nix-darwin functionst
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager =
    if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
in
systemFunc {
  inherit system;

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    { nixpkgs.overlays = overlays; }

    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }

    {users.users = users;}

    (if isLinux then {networking.hostName = name;}  else {}) 

    # Bring in WSL if this is a WSL build
    (if isWSL then inputs.nixos-wsl.nixosModules.wsl else { })

    machineConfig
    home-manager.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users = usersHMConfig;
    }
  ];
}
