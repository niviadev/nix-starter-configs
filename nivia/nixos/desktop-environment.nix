{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # wayland
    waybar

    ### GTK
    # passphrase input
    pinentry-gtk2
    indicator-application-gtk2

    ### X11
    # screen manager
    arandr
    # clipboard
    xclip
    # utility to configure modifier keys to act as other keys
    xcape
    xcolor
    xdo
    xdotool
    # disc burner and iso image creator
    xfburn

    ### XFCE
    font-manager
    orage
    # file manager
    thunar
    thunar-archive-plugin
    thunar-vcs-plugin

    xfce4-appfinder
    xfce4-battery-plugin
    xfce4-clipman-plugin
    xfce4-cpufreq-plugin
    xfce4-cpugraph-plugin
    xfce4-dict
    xfce4-fsguard-plugin
    xfce4-genmon-plugin
    xfce4-netload-plugin
    xfce4-notifyd
    xfce4-panel
    xfce4-panel-profiles
    xfce4-pulseaudio-plugin
    xfce4-screenshooter
    xfce4-sensors-plugin
    xfce4-session
    xfce4-settings
    xfce4-systemload-plugin
    xfce4-taskmanager
    xfce4-terminal
    xfce4-timer-plugin
    xfce4-verve-plugin
    xfce4-whiskermenu-plugin
    xfce4-windowck-plugin
    xfce4-xkb-plugin
    xfconf
    xfdashboard

    # niri
    #niri

    # audio
    pavucontrol
  ];

  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true;
  };
}
