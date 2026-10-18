{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        openttd
        #celestegame
    ];

    programs.fish.shellAliases = {
        factorio = "steam-run games/factorio2.1.17/factorio/bin/x64/factorio";
        cracktorio = "factorio";
    }
}
