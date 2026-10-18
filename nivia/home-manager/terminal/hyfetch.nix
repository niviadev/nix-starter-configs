{ pkgs, ... }:
{
    home.packages = with pkgs; [
        hyfetch
        fastfetch
    ];

    programs.hyfetch = {
        enable = true;
        settings = {
            auto_detect_light_dark = true;
            backend = "fastfetch";
            color_align.mode = "horizontal";
            light_dark = "dark";
            lightness = 0.65;
            mode = "rgb";
            preset = [
                # have weighted flags so that some flags show up more often than others
                # transgender x30
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                "transgender"
                # nonbinary x20
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                "nonbinary"
                # plural x5
                "plural"
                "plural"
                "plural"
                "plural"
                "plural"
                # agender x3
                "agender"
                "agender"
                "agender"
                # caninekin x1
                "caninekin"
                # pansexual x10
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                "pansexual"
                # lesbian x10
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                "lesbian"
                # sapphic x5
                "sapphic"
                "sapphic"
                "sapphic"
                "sapphic"
                "sapphic"
                # transbian X10
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                "transbian"
                #polyam x5
                "polyam"
                "polyam"
                "polyam"
                "polyam"
                "polyam"
                #interprogress x1
                "interprogress"
                #autism x1
                "autism"
            ];
            pride_month_disable = false;
        };
    };
}
