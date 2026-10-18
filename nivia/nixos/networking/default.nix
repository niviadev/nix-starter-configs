{ pkgs, ... }:
{
    imports = [
        ./dns.nix
        ./vpn.nix
    ];

    environment.systemPackages = with pkgs; [

    ];

    networking = {
        networkmanager.enable = true;
        hostName = "Override";
        # wlp3s0
        interfaces = {
            wlp3s0.useDHCP = true;
        };
    };
}
