sw:
 sudo nixos-rebuild switch --flake /etc/nixos#varo-msi

delete-old:
  sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old && home-manager expire-generations now 

l_system:
    sudo nix-env --profile /nix/var/nix/profiles/system --list-generations

[positional-arguments]
@seq *args='':
    seq -s " " $1 1 $2

l:
    nix-env --list-generations

l_home:
    home-manager generations

update:
  sudo nix flake update

gc:
  nix store gc
