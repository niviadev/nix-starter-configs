{
    imports = [
        ./dns.nix
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