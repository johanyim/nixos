{ config, pkgs, ... }: {
	home = {
		username = "johan";
		homeDirectory = "/home/johan";
		stateVersion = "23.11";
		packages = with pkgs; [
			neofetch
			ripgrep
			jq
			# yq-go
			eza
			fzf
			bottom
		];
	};
	programs.bash = {
		enable  =true;
		shellAliases = {
			rebuild = "sudo cp /home/johan/nix/configuration.nix /etc/nixos/configuration.nix ; sudo nixos-rebuild switch";
		};
	};

	programs.git = {
		enable = true;
		userName = "johanyim";
		userEmail = "37012949+johanyim@users.noreply.github.com";
		extraConfig =  {
			init.defaultBranch = "main"; 
			core = {
				editor = "nvim";
				pager = "bat --decorations=never";
			};
			help.autocorrect = 10;
		};
	};

	programs.home-manager.enable = true;
}


