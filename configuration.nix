{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.max-jobs = "auto";

  imports =
  [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  networking.hostName = "waifuware"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = 
  {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = 
  {
    layout = "fr";
    xkbVariant = "";
  };
  # ------- Driver support for my rtx 2070 -------
  hardware.opengl = 
  {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) 
    [
      "nvidia-x11"
      "nvidia-settings"
    ];

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = 
  {

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ------- END GPU DRIVER -------

  # virt-manager & libvirt
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  boot.kernelModules = [ "kvm-amd" "vfio-pci" ];

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = 
  {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
	
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.someboringnerd = 
  {
    isNormalUser = true;
    description = "SomeBoringNerd";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; 
    [
      firefox
      kate
    ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
  [
  	# dev tools
    unityhub
    jetbrains.rider
    jetbrains.idea-community
    
    # software
    vlc
    qbittorrent
    prismlauncher
    gimp
    aseprite
    gparted
    obs-studio
    kdenlive
    virt-manager

    # plugins / other
    mediainfo
    glaxnimate

    #cli
    htop
    neofetch
    pridefetch
    xclip
    libnotify

    #cli dev tools
    gccgo13
    pango
    pkgconfig
    glib
    dotnet-sdk
    cmake
    gcc12
    ninja
    gnumake
    mono
    clang_12
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.copySystemConfiguration = false;

  system.stateVersion = "23.05"; # Did you read the comment?

}
