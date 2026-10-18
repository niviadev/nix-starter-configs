{ pkgs, ... }:
{
    environment.systemPackages = [
                libreoffice-qt

        # notes
        obsidian
        
        # calculator
        qalculate-gtk



        # password
        keepassxc
        yubico-pam

        # video calls
        jitsi

        # video recording
        obs-studio
        
        gimp2-with-plugins

        # pdf
        poppler-utils
        pdftk
        
        gnome-disk-utility
    ];

    # obsidian uses insecure electron yay yippie
    nixpkgs.config.permittedInsecurePackages = [ "electron-41.9.1" ];
}
