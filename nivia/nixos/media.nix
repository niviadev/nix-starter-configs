{ pkgs, ... }: 
{
    environment.systemPackages = with pkgs [
         # H264/AVC video
        x264
        
        # vlc media player
        vlc
        
        # youtube
        freetube

        # books
        ebook_tools
        calibre
        # epub reader
        kdePackages.okular 
    ];
}
