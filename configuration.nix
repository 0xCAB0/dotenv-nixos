# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
        <nixos-wsl/modules>
	./hardware-configuration.nix
	inputs.home-manager.nixosModules.default
    ];
 
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  networking.hostName = "nixos"; # Define your hostname.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixos = {
    isNormalUser = true;
    description = "0xCAB0";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  }; 

  fonts.packages = with pkgs; [
        nerd-fonts.hack
        nerd-fonts.fira-code
  ];

  home-manager = {
   extraSpecialArgs = {inherit inputs;};  
   users."nixos" = import ./varo/home.nix;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker = {
    enable = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    iw
    gnumake
    gnupg
    libgccjit
    vim
    wget
    curl
    postgresql
    git
    just 
    tree
    neovim
    #libreoffice-qt
    #hunspell
    unzip
    zip
    flatpak
    kmod
    ## Browsers
    #firefox
    #brave

  ## Social Network
    #discord
    #tdesktop
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [

    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages

    ## Core libraries most linux have
    glib
    nss
    nspr
    util-linux
    alsa-lib
    dbus.lib
    systemd
    llvmPackages.bintools
    # gtk3-x11
    # pango
    # atk
    # cairo
    # gdk-pixbuf
    # xorg.libX11
    # xorg.libxcb
    # xorg.libXcomposite
    # xorg.libXcursor
    # xorg.libXdamage
    # xorg.libXext
    # xorg.libXfixes
    # xorg.libXi
    # xorg.libXrender
    # xorg.libxshmfence
    # xorg.libXtst
    # xorg_sys_opengl
    # xorg.libXrandr
    # xorg.libXScrnSaver
    # at-spi2-atk
    # at-spi2-core
    # libpulseaudio
    # vivaldi-ffmpeg-codecs
    # libxkbcommon
    # mesa
  ];
}
