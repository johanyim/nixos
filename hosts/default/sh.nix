{config, pkgs, ... }:
let 
    aliases = {
        ls = "exa -al";
        ".." = "cd ..";
    }; in 
{
    programs.bash = {
        enable = true;
        shellAliases = aliases;
    };

    programs.zsh = {
        enable = true;
        shellAliases = aliases;
    };

}

