{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        nextcloud-client
        borgbackup
    ];

    services.borgbackup.jobs.home-nivia-test = {
        paths = "/home/nivia/projects";
        encryption.mode = "none";
        environment.BORG_RSH = "ssh -i /home/danbst/.ssh/id_ed25519";
        repo = "ssh://user@example.com:23/home/nivia/backups/nivia-laptop";
        compression = "auto,zstd";
        startAt = "daily";
    };
}
