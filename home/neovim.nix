{ pkgs, ... } :

{
  programs.neovim = 
  {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set number
    '';
  };
}
