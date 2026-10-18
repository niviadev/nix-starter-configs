{ pkgs, ... }:
{
  imports = [
    ./functions
    ./functions-override
  ];

  #environment.systemPackages = with pkgs; [
  #    fishPlugins.done
  #    fishPlugins.fzf-fish
  #    fishPlugins.forgit
  #    fishPlugins.hydro
  #    fzf
  #    fishPlugins.grc
  #    grc

  #];

  programs.fish = {
    enable = true;
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
    shellAliases = {
      ll = "ls -Altrh --time-style=long-iso"; # all (except . ..) list time-sorted reverse (latest on bottom) human (file size). TODO: Set time style as default instead
      rm = "rm -I";
      clip = "xclip -selection clipboard";
      grep = "grep --color=auto";
      c = "clear";
      calc = "qalculate-gtk";
      pgp = "gpg";
      
      codeine = "codium";
      
      librewolf = "librewolf --name librewolf";
      # TODO adapt nixrebuild = "sudo nixos-rebuild switch"; #might want to run --upgrade with that
    };
  };
}
