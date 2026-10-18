{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        mullvad
        wireguard-tools
    ];

    networking.wireguard = {
        enable = true;
    };

    services.mullvad-vpn = {
        enable = true;
    };

    #n33r network, do not autoconnect
    systemd.services.wg-quick-n33r.enable = false;
    networking.wg-quick.interfaces.n33r = {
        address = [ "10.200.200.2/24" ];

        privateKeyFile = "/etc/wireguard/n33r-private.key";

        dns = [ "192.168.2.1" ];

        peers = [
            {
                publicKey = "9HBH8glzUhI7PhBtubICKCUE4w6cIXM0vir3mV26JBA=";
                presharedKeyFile = "/etc/wireguard/n33r-preshared.key";

                allowedIPs = [ "0.0.0.0/0" ];
                endpoint = "93.219.128.220:53280";
                persistentKeepalive = 21;
            }
        ];
    };
    # nebula network, do not autoconnect
    systemd.services.wg-quick-nebula.enable = false;
    networking.wg-quick.interfaces.nebula = {
        address = [
            "10.0.0.5/32"
            "fd30:5591:8deb::5/128"
        ];
        listenPort = 51280;

        privateKeyFile = "etc/wireguard/nebula-private.key";

        peers = [
            {
                publicKey = "l7PU/e+XVyDw97ELRMznB4WKbmUSMuoWE1B26OEN6lQ=";

                allowedIPs = [
                    "0.0.0.0"
                    "::/0"
                ];
                endpoint = "eepygothfoxgxrl.zone:51280";
            }
        ];
    };
}
