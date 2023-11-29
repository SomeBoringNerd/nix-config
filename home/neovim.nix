{ pkgs, inputs, lib, ... } :

{
  programs.neovim = 
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    
    plugins = [
      pkgs.vimPlugins.coc-nvim
    ];
  };
}
