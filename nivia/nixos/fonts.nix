{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    atkinson-hyperlegible-next
    atkinson-hyperlegible-mono
  ];
} 
