{
	description = "first flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			# nixpkgs and home manager are synchronised
			inputs.nixpkgs.follows = "nixpkgs";
		};

		xremap-flake.url = "github:xremap/nix-flake";
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: 
	let 
		system = "x86_64-linux";
	in {
		nixosConfigurations.testpad = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; }; # allow 'inputs' variable to be used as an arg in all modules
			modules = [ ./hosts/default/configuration.nix ];
		};

		nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; };
			modules = [ ./hosts/default/configuration.nix ];
		};

		homeConfigurations.johan = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages.${system};
			modules = [ ./home.nix ];
		};
	};
}
