{ pkgs, ... }:
{
    environment.systemPackages = with pkgs [
        
        # DB
        sqlite
        # java
        jdk21
        #python
        uv

        # kubernetes
        #kind

        # fish
        fishPlugins.done
        fishPlugins.fzf-fish
        fishPlugins.forgit
        fishPlugins.hydro
        fzf
        fishPlugins.grc
        grc  

        vscodium # VS-Code

        # 3D-print
        openscad
        prusa-slicer

        ### FILE MANIPULATION
        # json
        jq
        # media
        ffmpeg
        exiftool
        pdftk

        android-tools

        # Flipper Zero
        qFlipper

        wget2

        # VM
        # gnome-boxes # VM management
        # dnsmasq # VM networking
        # phodav # (optional) share files with guest VMs
    ];

    programs.fish.shellAliases = {
        wget = "wget2";
    }
}
