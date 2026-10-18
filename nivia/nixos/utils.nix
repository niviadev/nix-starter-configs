{ pkgs, ... }:
{
    environment.systemPackages = [
        # file search
        catfish

        # remote file systems
        gigolo

        # contact management using vcard (.vcf, .cvard)
        khard

        # network discovery
        nmap

        # zip
        zip
        p7zip
        unzip

        age # encryption

        # pdf
        poppler-utils
        pdftk
    ];
}
