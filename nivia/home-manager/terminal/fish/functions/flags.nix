{
  programs.fish.functions = {
    hex_color = ''
      set -l hexcode $argv[1] 
      set hexcode (string trim -l -c \# $hexcode)

      echo (set_color $hexcode)#$hexcode
    '';
    flag = ''
      set -l kind $argv[1]| xclip -selection clipboard

      switch $kind
          case trans
              hex_color 5BCFFB
              hex_color F5ABB9
              hex_color FFFFFF
              hex_color F5ABB9
              hex_color 5BCFFB
          case lesbian
              hex_color D52D00
              hex_color EF7627
              hex_color FF9A56
              hex_color FFFFFF
              hex_color D162A4
              hex_color B55690
              hex_color A30262
              case '*'
              echo "error: flag does not exist" >&2
              return 1
      end
    '';
  };
}
