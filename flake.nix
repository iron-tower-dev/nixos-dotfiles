{
    description = "NixOS Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
        noctalia = {
	    url = "github:noctalia-dev/noctalia-shell";
	    inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
	nixosConfigurations.iron-nix = nixpkgs.lib.nixosSystem {
	    specialArgs = { inherit inputs; };
	    system = "x86_64-linux";
	    modules = [
		./configuration.nix
		home-manager.nixosModules.home-manager
		{
		    home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			users.derrick = import ./home.nix;
			backupFileExtension = "backup";
		    };
                }
		./noctalia.nix
	    ];
	};
    };
}
