# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
    inputs,
    lib,
    config,
    pkgs,
    ...
}:
{
    # You can import other NixOS modules here
    imports = [
        # If you want to use modules from other flakes (such as nixos-hardware):
        # inputs.hardware.nixosModules.common-cpu-amd
        # inputs.hardware.nixosModules.common-ssd
        ./backup
        ./dev
        ./gaming
        ./networking
        ./messengers
        ./apps.nix
        ./browser.nix
        ./desktop-environment.nix
        ./fonts.nix
        ./hardware-configuration.nix
        ./home-manager.nix
        ./locale.nix
        ./media.nix
        ./toki-pona.nix
        ./torrent.nix
        ./treefmt.nix
        ./utils.nix
    ];

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        #nix
        niv
        nix-tree
    ];

    # Configure console keymap
    console.keyMap = "de(qwerty)";

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
                #"electron-39.8.10" # FIXME: this comes from an old obsidian package
                "electron-41.9.1"
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
        bash = {
            # FIXME see if this is movable to home-manager/fish.nix
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
            plugins = with pkgs; [
                thunar-archive-plugin
                thunar-media-tags-plugin
                thunar-volman
            ];
        };
        dconf.enable = true;
    };

    # FIXME: Add the rest of your current configuration

    #enable blutooth gui
    services.blueman.enable = true;

    users.users = {
        nivia = {
            isNormalUser = true;
            description = "bark bark bark";
            openssh.authorizedKeys.keys = [
                # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
            ];
            extraGroups = [
                "networkmanager"
                "wheel"
            ];
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
