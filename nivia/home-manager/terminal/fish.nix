{ pkgs, ... }:
{
    programs.fish = {
        enable = true;
        # interactiveShellInit = ''
        #     hyfetch
        #     set fish_greeting #don't do default greeting
        # '';
        functions = {
            # default function override
            fish_greeting = "hyfetch";
            # custom functions
            meow = ''
                echo "meow! :3"
            '';
        };
        plugins = [
            # Enable a plugin (here grc for colorized command output) from nixpkgs
            { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        ];
    };
}