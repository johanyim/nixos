# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		inputs.home-manager.nixosModules.default
	];

	

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos";
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

	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	users.users.johan = {
		isNormalUser = true;
		description = "Johan";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			hyprland
			kitty
		];
	};

	programs.hyprland.enable = true;

	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
		};
	};

	home-manager = {
		extraSpecialArgs = {inherit inputs; };
		users = {
			"johan" = import ./home.nix;
		};

	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim 
		wget
		git
		firefox
	];

	services.openssh.enable = true;

	# networking.firewall.enable = false;

	system.stateVersion = "23.11"; # Did you read the comment?

}
