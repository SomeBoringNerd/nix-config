{ pkgs, ... } :

{
  programs.git = {
    enable = true;
    userName = "SomeBoringNerd";
    userEmail = "someboringnerd@gmail.com";

    aliases = {
	gpush = "git push -u origin Mommy";
    };
  };
}
