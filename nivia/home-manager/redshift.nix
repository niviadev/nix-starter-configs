{ pkgs, ... }:
{
    home.packages = with pkgs; [
        redshift
    ];

    # https://wiki.nixos.org/wiki/Redshift
    services.redshift = {
        enable = true;
        provider = "manual";
        latitude = "51";
        longitude = "7";
        # Tray Icon
        tray = true;
        settings = {

            # Display temperature settings (in Kelvin)
            temperature = {
                day = 5500;
                night = 3000;
            };

            # Brightness
            brightness = {
                day = "1";
                night = "0.8";
            };

        };
    };
}
