{ pkgs, libs, config, ... } :

{
	programs.fish = 
	{
		enable = true;
		interactiveShellInit = ''
				set fish_greeting
				pridefetch -f bisexual
		'';

		shellAliases = 
		{
			clear = "clear && echo \"\" && pridefetch -f bisexual";
			update = "sudo nixos-rebuild switch --flake /etc/nixos#MAIN && reset-jelly";
			push = "git push -u origin Mommy";
			reset-jelly = "set MYGROUP users && sudo usermod -a -G $MYGROUP jellyfin && sudo chown $USER:$MYGROUP /home/someboringnerd/ && sudo chmod 750 /home/$USER && sudo setfacl -m g:$MYGROUP:rwx /home/$USER && sudo systemctl restart jellyfin.service";
		};

		functions = 
		{
			fish_prompt = ''
					set_color $fish_color_cwd
					echo -n '   ╔╡'
					set_color cyan
					echo -n (whoami) \ue771 (prompt_hostname)
					set_color yellow
					echo -n ' ⌠'\uf489 '⌡ '
					set_color 62A
					echo -n 'C.D :'
					set_color yellow
					echo -n ' '\uebac' '
					echo -n $PWD
					set_color $fish_color_cwd
					echo
					echo -n '   ╚═' \uf120 ' '
					set_color normal
			'';
		};
	};
}
