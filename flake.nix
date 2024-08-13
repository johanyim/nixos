{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		# reduce desk space usage by inheriting a previous channel
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

	};



	# the most used packages can be in the braces, also inputs are available to the block beneath
	outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
	{
		nixosConfigurations = {
			default = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./hosts/default/configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};
		};
	};
}
