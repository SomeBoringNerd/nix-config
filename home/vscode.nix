{ pkgs, libs, config, ... } :

{

    programs.vscode = {
	enable = true;
	package = pkgs.vscodium;
	extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
	nonylene.dark-molokai-theme
	wakatime.vscode-wakatime
      ];
    };
}
