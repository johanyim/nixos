{ config, pkgs, ... }:

{
	imports =
		[ 
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; 

	nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/London";

	i18n.defaultLocale = "en_GB.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};


	services.xserver = {
		enable = true;
		desktopManager = {
			xfce.enable = true;
		};
		
		
	};

	services.displayManager.defaultSession = "xfce";

	users.users.johan = {
		isNormalUser = true;
		description = "Johan Yim";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
		shell = pkgs.zsh;
	};

	nixpkgs.config.allowUnfree = true;


	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	programs.zsh = {
		enable = true;
	};


	environment.systemPackages = with pkgs; [
		neovim
		git
		hyprland
		alacritty
		kitty
		home-manager

		firefox
	
	];


# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
	networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
