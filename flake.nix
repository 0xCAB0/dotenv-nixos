{

  description = "Alvaro's Nixos systems and tools";

  inputs = {

    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Master nixpkgs is used for really bleeding edge packages. Warning
    # that this is extremely unstable and shouldn't be relied on. Its
    # mostly for testing.
    nixpkgs-master.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jujutsu.url = "github:martinvonz/jj";
    zig.url = "github:mitchellh/zig-overlay";

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      darwin,
      ...
    }@inputs:
    let
      overlays = [
        inputs.jujutsu.overlays.default
        inputs.zig.overlays.default
      ];

      mkSystem = import ./lib/mksystem.nix {
        inherit overlays nixpkgs inputs;
      };

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {

      nixosConfigurations.varo-msi = mkSystem "varo-msi" {
        inherit system;
        ## User specification should like usual Nixos User
        # Or Darwin if it is MacOS
        users = {
          varo = {
            isNormalUser = true;
            description = "0xCAB0";
            extraGroups = [
              "networkmanager"
              "wheel"
              "docker"
            ];
            packages = with pkgs; [
              zsh
            ];
            shell = pkgs.zsh;
          };
        };
      };

    };

}
