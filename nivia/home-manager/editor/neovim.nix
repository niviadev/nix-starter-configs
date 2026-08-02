{ pkgs, ... }: 
{
    home.packages = with pkgs; [
        jq #TODO move this somewhere
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
