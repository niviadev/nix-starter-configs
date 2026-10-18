{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #neovim
    jq # TODO copy! to own tooling file or something
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      #vim-nix # github.com/LnL7/vim-nix/
      jq-vim
    ];
  };
}
