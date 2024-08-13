{config, pkgs, lib, ...} :
{
	programs.git =  {
		enable = true;
		userName = "johanyim";
		userEmail = "johanjyyim@gmail.com";
		aliases = {
			s = "status";
		};
	};

}
