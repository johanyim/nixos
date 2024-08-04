{ config, pkgs, inputs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		inputs.xremap-flake.nixosModules.default
		inputs.home-manager.nixosModules.default
        ./sh.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

    environment.shells = with pkgs; [ zsh ];

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nix.settings.warn-dirty = false;

	networking.hostName = "testpad"; # Define your hostname.
	networking.networkmanager.enable = true;

	### PUT THIS BACK ON WHEN NOT CONFIGURING
	networking.firewall.enable = false;

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


	services.xserver.enable = true;


	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	services.printing.enable = true;

	hardware.bluetooth.enable = true;

	services.xremap = {
		userName = "johan";
		config = {
			keymap = [
				{
					name = "main remaps";
					remap = {
						"CapsLock" = "esc";
						"esc" = "CapsLock";
					};
				}
			];
		};
	};



	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		#jack.enable = true;
		#media-session.enable = true;
	};


	users.users.johan = {
		isNormalUser = true;
		description = "johan";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			firefox
			neovim
			zsh
			wezterm
			rustup
			cargo
			bat
			gleam
		];
	};

	security.sudo.extraRules = [{
		users = ["johan"];
		commands = [
			{command = "ALL"; options = ["NOPASSWD"];}
		];
	}];


	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		wget
		git
	];


	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"johan" = import ./home.nix;
		};
	};

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 14d";
	};

	services.openssh.enable = true;

	system.stateVersion = "23.11";

}
