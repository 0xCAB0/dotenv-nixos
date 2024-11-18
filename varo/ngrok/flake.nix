{
  inputs = {
    ngrok.url = "github:ngrok/ngrok-nix";
  };

  outputs = { self, ngrok, ... }@inputs: {
    nixosConfigurations."<YOUR_HOSTNAME>" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ngrok.nixosModules.ngrok
        ({ pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          services.ngrok = {
            enable = true;
            authtoken = "2p1CWO1fjNQZk72fMwa9ul1LK4I_3gCCwWTBKD5aVUsyBVsf8";
            extraConfig = { };
            extraConfigFiles = [
              # reference to files containing `authtoken` and `api_key` secrets
              # ngrok will merge these, together with `extraConfig`
            ];
            tunnels = {
              # ...
            };
          };
        })
      ];
    };
  };
}
