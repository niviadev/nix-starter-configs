{ pkgs, ... }:
{
    # https://github.com/neroist/sitelen-pona-ucsur-guide

    fonts.packages = with pkgs; [
        nasin-nanpa
        nasin-nanpa-helvetica
    ];

    # firefox
    /*
      "font.name-list.cursive.x-western" = "cursive, nasin-nanpa";
      "font.name-list.monospace.x-western" = "monospace, nasin-nanpa";
      "font.name-list.sans-serif.x-western" = "sans-serif, nasin-nanpa";
      "font.name-list.serif.x-western = "serif, nasin-nanpa";
    */
    # FIXME add option to type tokipona https://github.com/dec32/Ajemi
}
