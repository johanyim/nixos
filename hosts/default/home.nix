{inputs, outputs, lib, config, pkgs, ...}: {

	imports = [
		./../../modules/home-manager/git.nix
		./../../modules/home-manager/terminals/kitty.nix
	];

	home = {
		username = "johan";
		homeDirectory = "/home/johan";
	};

	programs.home-manager.enable = true;

# reload system units when switching configs
#	system.user.startServices = "sd-switch";

	home.stateVersion = "23.05";


}
