{ config, lib, ... } : 

{
  home.stateVersion = "23.05";
  imports = [
    ./git.nix
    ./fish.nix
    ./vscode.nix
  ];
}
