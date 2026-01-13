# Laptop-specific configuration
{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  # Enable mDNS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot/EFI";
    };
    grub = {
      enable = true;
      copyKernels = true;
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
      fsIdentifier = "label";
      extraEntriesBeforeNixOS = true;
      theme = "/etc/nixos/assets/fallout-grub-theme";
    };
  };

  # Wireguard
  networking.firewall = {
    checkReversePath = "loose";
    allowedUDPPorts = [ 63314 ];
    allowedTCPPorts = [ 8001 ];
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (
    with pkgs;
    [
      baobab
      epiphany
      gnome-text-editor
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-system-monitor
      gnome-weather
      loupe
      papers
      gnome-connections
      showtime
      simple-scan
      snapshot
      yelp
    ]
  );

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.fira-code
    ];
  };

  # Laptop-specific packages
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    firefox
    brave
    nixfmt
  ];
}
