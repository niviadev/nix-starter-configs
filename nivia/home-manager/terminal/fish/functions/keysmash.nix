{
    programs.fish.functions = {
        keysmash_generic = ''
            set -l charset $argv[1]
            set -l length  50

            if test (count $argv) -ge 2; and test (count $argv[2]) -lt 10000
                set length $argv[2]
            end

            set -l out ""
            for i in (seq 1 $length)
                set -l index_char (random 1 (string length -- $charset))
                set -l char (string sub -s $index_char -l 1 -- $charset)
                set out "$out$char"
            end
            echo $out 
        '';
        keysmash = ''
            keysmash_generic 0123456789abcdefghijklmnopqrstuvwxyz $argv
        '';
        "0bkeysmash" = "keysmash_generic 01 $argv";
        "0okeysmash" = "keysmash_generic 01234567 $argv";
        "0xkeysmash" = "keysmash_generic 0123456789abcdef $argv";
        awawa = ''
            set -l awawawa (keysmash_generic 0123456789abcdef,, $argv)
            echo $awawawa 
            printf '%s' "$awawawa" | xclip -selection clipboard
        '';
    };
}