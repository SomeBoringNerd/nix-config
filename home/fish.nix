{ pkgs, libs, config, ... } :

{
	programs.fish = {
			enable = true;
			interactiveShellInit = ''
					set fish_greeting
					pridefetch -f bisexual
			'';

		shellAliases = {
			clear = "clear && echo \"\" && pridefetch -f bisexual";
			update = "sudo nixos-rebuild switch --flake /etc/nixos#MAIN";
			push = "git push -u origin Mommy";
		};

		functions = {
			fish_prompt = ''
					set_color $fish_color_cwd
					echo -n '   ╔╡'
					set_color cyan
					echo -n (whoami)@(prompt_hostname)
					set_color yellow
					echo -n ' ⌠λ⌡ '
					set_color 62A
					echo -n $(uname)
					set_color yellow
					echo -n ' ∞ '
					echo -n $PWD
					set_color $fish_color_cwd
					echo
					echo '   ║'
					echo -n '   ╚═► '
					set_color normal

			'';
		};
	};
}
