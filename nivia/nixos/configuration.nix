# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./home-manager.nix
  ];

    ##############
    ### LOCALE ###
    ##############

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
    };


  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-39.8.10" # FIXME: this comes from an old obsidian package
      ];
    };
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
    };
    # Opinionated: disable channels
    channel.enable = false;
  };

  programs = {
    bash = { #FIXME see if this is movable to home-manager/fish.nix
        # fish is not posix compliant, thus only use fish when in interactive mode https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
        interactiveShellInit = ''
            if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
            then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
            fi
        '';
    };
    firefox.enable = true;
    partition-manager.enable = true;
    gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
	    pinentryPackage = pkgs.pinentry-gtk2;
    };
    thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
            thunar-archive-plugin
            thunar-media-tags-plugin
            thunar-volman
        ];
    };
    dconf.enable = true;
  };

  # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [ #FIXME these might be home packages
        # editor
        vim
        # nano comes by default

        # browser
        ungoogled-chromium

        #fish
        fishPlugins.done
        fishPlugins.fzf-fish
        fishPlugins.forgit
        fishPlugins.hydro
        fzf
        fishPlugins.grc
        grc

        # VM
        gnome-boxes # VM management
        dnsmasq # VM networking
        phodav # (optional) share files with guest VMs

        # dev
        vscodium # VS-Code
        qFlipper # FlipperZero
        kubectl
        jdk21
        openscad

        # messenger
        fluffychat # matrix client
        signal-desktop
        deltachat-desktop
        telegram-desktop

        # xfce
        xfce.catfish
        xfce.gigolo
        xfce.orage
        xfce.xfburn
        xfce.xfce4-appfinder
        xfce.xfce4-clipman-plugin
        xfce.xfce4-dict
        xfce.xfce4-fsguard-plugin
        xfce.xfce4-genmon-plugin
        xfce.xfce4-netload-plugin
        xfce.xfce4-panel
        xfce.xfce4-pulseaudio-plugin
        xfce.xfce4-systemload-plugin
        xfce.xfce4-whiskermenu-plugin
        xfce.xfce4-session
        xfce.xfce4-xkb-plugin
        xfce.xfdashboard
        xfce.xfce4-battery-plugin
        xfce.xfce4-panel-profiles
        xfce.xfce4-cpugraph-plugin
        xfce.xfce4-timer-plugin
        xfce.xfce4-fsguard-plugin
        xfce.xfce4-cpufreq-plugin
        xfce.xfce4-windowck-plugin
        xfce.xfce4-sensors-plugin
        indicator-application-gtk2
        xfce.xfconf
        xfce.xfce4-xkb-plugin
        xfce.xfce4-verve-plugin
        xfce.xfce4-terminal
        xfce.xfce4-taskmanager
        xfce.xfce4-settings
        xfce.xfce4-screenshooter
        xfce.xfce4-notifyd
        xfce.thunar-vcs-plugin
        xfce.thunar-archive-plugin
        xfce.thunar
        font-manager
        xclip
        xcolor
        xdo
        xdotool
        xcape

        # python
        uv

        #games
        openttd
        celestegame
        vbam

	    # media
	    x264 # H264/AVC video
	    vlc # vlc media player
	    ffmpeg
	    obs-studio
        kdePackages.okular # epub reader
        ebook_tools
        calibre

        # contact management using vcard (.vcf, .cvard)

        khard

        # unspecified
        age #encryption
        borgbackup
        exiftool
        pdftk
        nix-tree
        poppler-utils
        zip
        p7zip
        niv
        arandr
        kind
        sqlite
        wget
        libreoffice-qt
        obsidian
        keepassxc
        prusa-slicer
        waybar
        niri
        gimp2-with-plugins
        gnome-disk-utility
        qalculate-gtk
        unzip
        android-tools
        pavucontrol
	    pass
	    pinentry-gtk2
	    yubico-pam
        jitsi
        nextcloud-client
    ];

  # FIXME: Add the rest of your current configuration


    networking = {
      networkmanager.enable = true;
      hostName = "Override";
      # wlp3s0
      interfaces = {
          wlp3s0.useDHCP = true;
      };
  };

  users.users = {
    nivia = {
      isNormalUser = true;
      description = "bark bark bark";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
            kdePackages.kate
        ];
    };
  };

  /*
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  */

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
