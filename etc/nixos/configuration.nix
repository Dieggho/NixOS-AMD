# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "a475"; # Define your hostname.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "br";
  #  variant = "thinkpad";
  #};

    # Enable services
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
       command = "${pkgs.cage}/bin/cage -d -s -- gtkgreet -b /home/void/.local/share/backgrounds/NixOS.png";
       user = "void";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  services.logind.lidSwitchExternalPower = "ignore";
  zramSwap.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
  amdvlk
  ];

  hardware.amdgpu.initrd.enable = true;

  hardware.amdgpu.amdvlk.settings = {
  AllowVkPipelineCachingToDisk = 1;
  EnableVmAlwaysValid = 1;
  IFH = 0;
  IdleAfterSubmitGpuMask = 1;
  ShaderCacheMode = 1;
  };

  hardware.cpu.amd.updateMicrocode = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.void = {
    isNormalUser = true;
    description = "void";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "storage" "optical" "input"];
    packages = with pkgs; [
        hyprlandPlugins.hyprbars
        flat-remix-gtk
        flat-remix-icon-theme
    ];
  };

 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable doas instead of sudo
  # security.doas.enable = true;
  # security.sudo.enable = false;

  # Configure doas
  # security.doas.extraRules = [{
  #	users = [ "void" ];
  #	keepEnv = true;
  #     persist = true;
  #}];

  # Enable packages
  programs.firefox.enable = true;
  programs.waybar.enable = true;
  programs.regreet.enable = true;

  hardware.amdgpu.amdvlk.package = true;

  programs.hyprland = {
  enable = true;
  }; 

  # Default shell
  # users.defaultUserShell = pkgs.mksh;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  audacity
  cage
  dunst
  deadbeef
  swww
  fastfetch
  gsimplecal
  lm_sensors
  greetd.gtkgreet
  wofi
  foot
  wf-recorder
  hyprpicker
  libnotify
  simple-mtpfs
  dconf-editor
  galculator
  lxtask
  imv
  grim
  slurp
  gucharmap
  ffmpeg-full
  gimp
  transmission_3
  telegram-desktop
  unrar
  unzip
  p7zip
  dash
  pavucontrol
  pcmanfm
  python3
  swaylock
  waypaper
  xfce.mousepad
  shotcut
  udevil
  ];

# Set session environment
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    # Not officially in the specification
    DRI_PRIME = "1";
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

  programs.bash.shellAliases = {
  ls = "ls --color=auto";
  myip = "curl ident.me;echo";
  weather = "curl -4 http://wttr.in/Sao-Paulo";
  mynix = "clear; fastfetch; lsblk -f;";
  nixed = "sudo nano /etc/nixos/configuration.nix";
  nixup = "sudo nixos-rebuild switch --upgrade";
  nixrm = "sudo nix-collect-garbage --delete-old;sudo /run/current-system/bin/switch-to-configuration boot";
  nixs = "nix-env -qaP";
  nixsh = "nix-shell -p";
  nixr = "nix-collect-garbage";
  nixlsg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
  hyprc = "nano /home/void/.config/hypr/hyprland.conf";
  Nix = "clear ; fastfetch";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
