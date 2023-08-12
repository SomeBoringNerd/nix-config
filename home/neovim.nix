{ config, pkgs, ... } :

{
  programs.neovim = 
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    
    plugins = [
	pkgs.vimPlugins.coc-nvim
    ];

    extraConfig = ''
      set number

      call plug#begin('~/.vim/plugged')

      Plug 'OmniSharp/omnisharp-vim'
      
      call plug#end()

    '';
  };
}
