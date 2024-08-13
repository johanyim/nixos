{config, pkgs, lib, ...} :
{
	programs.git =  {
		enable = true;

		userName = "johanyim";
		userEmail = "johanjyyim@gmail.com";
		aliases = {
			s = "status";
		};
		extraConfig = {
			core = {
				editor = "vim";
			};
			url = {
				"git@github.com" = { 
					insteadOf = "otherhost"; 
				};
			};
		};
	};

}
