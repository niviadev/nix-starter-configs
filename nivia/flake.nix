{
    description = "my new nix config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        treefmt-nix.url = "github:numtide/treefmt-nix";
        systems.url = "github:nix-systems/default";
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        treefmt-nix,
        systems,
        ...
    }@inputs: 
    let
        # Small tool to iterate over each systems
        eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

        # Eval the treefmt modules from ./treefmt.nix
        treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
        # NixOS configuration entrypoint
        # Available through 'nixos-rebuild --flake .#your-hostname'
        nixosConfigurations = {
            Override = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                # > Our main nixos configuration file <
                modules = [ ./nixos/configuration.nix ];
            };
        };

        # for `nix fmt`
        formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
        # for `nix flake check`
        checks = eachSystem (pkgs: {
            formatting = treefmtEval.${pkgs.system}.config.build.check self;
        });
    };
}
