{
    description = "Default flake for pascal";

    inputs= {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs@{
        self, 
        nixpkgs,
        home-manager
    }: {
        nixosConfigurations = {
            pascal = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.beardedtek = import ./home.nix;
                    }
                ];
            };
        };
    };
}