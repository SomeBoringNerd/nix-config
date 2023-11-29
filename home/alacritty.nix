{ pkgs, inputs, lib, ... } :

{
  programs.alacritty = 
  {
    enable = true;

    settings = 
    {
      env = {
        "TERM" = "xterm-256color";
      };

      font = {
        size = 10.0;
        AppleFontSmoothing = true;
    
        normal.family = "JetBrainsMonoNL Nerd Font";
        bold.family = "JetBrainsMonoNL Nerd Font";
        italic.family = "JetBrainsMonoNL Nerd Font";
      };

      window = {
        opacity = 0.85;
      };

      colors = {
        # Default colors
        primary = {
          background = "0x330038";
          foreground = "0xc1d9d9";
        };
    
        normal = {
          black =    "0x0e0d0d";
          red =      "0xdc0109";
          green =    "0x1eda72";
          yellow =   "0xc8b35b";
          blue =     "0x1468df";
          magenta =  "0x7a14df";
          cyan =     "0x009dff";
          white =    "0xd6d6d6";
        };
        # Bright colors
        bright = {
          black =    "0x86763a";
          red =      "0xa89861";
          green =    "0xdb3940";
          yellow =   "0xd74c51";
          blue =     "0x29913b";
          magenta =  "0x7c9fda";
          cyan =     "0x63b56d";
          white =    "0x64a3a2";
        };
      };
    };
  };
}