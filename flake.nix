{
	description = "NixOS Flake";


	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		# my-input.url = "github:username/repo-name/branch-name";
	};


	outputs = { self, nixpkgs, ... }@inputs: { # ,my-input

		# hostname = nixos  vvvvv
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";

			# allows for 'my-input' to be used in submodules
			# specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
			];
		};

	};

}
