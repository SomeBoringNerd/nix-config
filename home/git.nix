{ pkgs, ... } :

{
  programs.git = {
    enable = true;
    userName = "SomeBoringNerd";
    userEmail = "someboringnerd@gmail.com";
  };
}
