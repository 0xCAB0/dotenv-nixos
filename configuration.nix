# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader = {
  efi = {
    canTouchEfiVariables = false;
    efiSysMountPoint = "/boot/EFI";
  };
  grub = {
     efiInstallAsRemovable = true;
     efiSupport = true;
     useOSProber = true;
     device = "nodev";
     extraEntriesBeforeNixOS = true;
     theme = "/etc/nixos/assests/fallout-grub-theme";
  };
};
 
  networking.hostName = "nixos"; # Define your hostname.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  # Wireguard
  networking.firewall = {
    allowedUDPPorts = [ 63314 ];
    allowedTCPPorts = [ 8001 ];
  };

networking.wg-quick.interfaces = {
        wg0 = {
        configFile = "/etc/wireguard/wg0.conf";
        };
        # wg1 = {
        # configFile = "/etc/wireguard/wg1.conf";
        # };
  };
  # Set your time zone.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  epiphany # web browser
geary # email reader
  evince # document viewer
  gnome-characters
  gnome-contacts
  gnome-weather
]);

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.varo = {
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
   users."varo" = import ./varo/home.nix;

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
    libreoffice-qt
    hunspell
    unzip
    zip
  ## Browsers
   firefox
   brave

  ## Social Network
    discord
    tdesktop
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
