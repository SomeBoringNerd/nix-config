{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.max-jobs = "auto";

  imports =
  [
    ./hardware-configuration.nix
    ./pipewire.nix
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
  services.xserver = {
    enable = true;
  
    displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];

    };
  };

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

    extraPackages = [ pkgs.mesa.drivers ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) 
    [
      "nvidia-x11"
      "nvidia-settings"
    ];

  services.xserver.videoDrivers = ["nvidia"];

  services.gvfs.enable = true;

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

  profiles.pipewire.enable = true;
	
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.someboringnerd = 
  {
    isNormalUser = true;
    description = "SomeBoringNerd";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "audio" ];
    packages = with pkgs; 
    [
      firefox
      kate
    ];
  };

  services.udev.packages = [ pkgs.dolphinEmu ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8096 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8100; }
    ];
  };


  services.jellyfin.enable = true;


  systemd.user.services.root = {
    description = "Startup script";
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      flameshot
      qbittorrent
      sudo systemctl start jellyfin.service
      # jellyfin need to regain permission to my video folder each time it is reseted
      set MYGROUP users
      sudo usermod -a -G $MYGROUP jellyfin 
      sudo chown $USER:$MYGROUP /home/someboringnerd/ 
      sudo chmod 750 /home/$USER 
      sudo setfacl -m g:$MYGROUP:rwx /home/$USER

      sudo systemctl restart jellyfin.service
    '';
    wantedBy = [ "multi-user.target" ]; # starts after login
  };


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  services.tailscale.enable = true;


  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
	
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.sessionVariables = 
  {
  	DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
  ];

  environment.systemPackages = with pkgs; 
  [
  	# dev tools
    jetbrains.idea-community
    
    # software
    vlc
    audacity
    qbittorrent
    prismlauncher
    gimp
    aseprite
    gparted
    obs-studio
    lmms
    kdenlive
    virt-manager
    blockbench-electron
    yuzu-mainline
    dolphin-emu
    onlyoffice-bin
    anytype
    minetest
    obsidian
    zrythm
    nitrogen
    polybar
    cinnamon.nemo
    flameshot
    blender
    jellyfin-media-player
    davinci-resolve
    lxappearance
  

    # plugins / other
    mediainfo
    freetype
    wine
    winetricks
    glaxnimate
    glfw
    glxinfo
    openssl
    xorg.libX11
    xorg.libXext
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libX11.dev
    xorg.libxcb.dev
    libpulseaudio
    libGL
    openal
    stdenv.cc.cc.lib

    #cli
    htop
    neofetch
    pridefetch
    xclip
    libnotify
    zip
    git-lfs

    #cli dev tools
    python3
    python310Packages.pip
    gccgo13
    pango
    pkgconfig
    glib
    dotnet-sdk
    omnisharp-roslyn
    cmake
    gcc12
    ninja
    gnumake
    mono
    jq
    nodejs
    clang_12
    raylib
    openjdk17
    temurin-jre-bin-17
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
