{ config, pkgs, ... }: {
	home = {
		username = "johan";
		homeDirectory = "/home/johan";
		stateVersion = "23.11";
		packages = with pkgs; [
			neofetch
		];
	};
	programs.bash = {
		enable  =true;
		shellAliases = {
			rebuild = "sudo cp /home/johan/nix/configuration.nix /etc/nixos/configuration.nix ; sudo nixos-rebuild switch";
		};
	};
}


