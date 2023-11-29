{ config, lib, ... } : 

{
  home.stateVersion = "23.05";
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./vscode.nix
  ];
}
