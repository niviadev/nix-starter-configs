{ pkgs, ... }:
{
  environment.systemPackages = with pkgs [
    fluffychat # matrix client
    signal-desktop
    deltachat-desktop
    telegram-desktop
  ];

  programs.fish.shellAliases = {
    matrix = "fluffychat";
  };
}
