{ config, lib, ... } : 

{
  home.stateVersion = "23.05";
  imports = [
    ./home/git.nix
    ./home/fish.nix
    ./home/vscode.nix
  ];
}
