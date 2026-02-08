{ config, pkgs, ... }:

{
  home.username = "derrick";
  home.homeDirectory = "/home/derrick";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    nitch
    (pkgs.writeShellApplication
    {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Derrick Southworth";
        email = "derricksouthworth@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
  programs.eza = {
    enable = true;
    icons = "always";
    colors = "always";
    enableFishIntegration = true;
  };
  gtk = {
    enable = true;
    theme = { name = "Adwaita-dark"; package = pkgs.adwaita-icon-theme; };
    iconTheme = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; };
    cursorTheme = { name = "Numix-Cursor"; package = pkgs.numix-cursor-theme; size = 16; };
    font = { name = "Sans"; size = 10; };
  };
  home.file.".config/emacs".source = ./config/emacs;
  home.file.".config/fish".source = ./config/fish;
  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/nushell".source = ./config/nushell;
  home.file.".config/nvim".source = ./config/nvim;
}
