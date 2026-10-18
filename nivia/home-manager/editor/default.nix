{ pkgs, ... }:




{
  imports = [
    ./neovim.nix
  ];

  home.packages = wih pkgs [
    nixfmt
  ];
}
