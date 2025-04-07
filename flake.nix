{
  description = "home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in
      {
        packages.${system}.home = pkgs.buildEnv {
          name = "home";
          paths = with pkgs; [
            # tools
            git
            hub
            curl
            wget
            fzf
            ripgrep
            jq
            docker
            mise
            uim
            # editor
            emacs
            vim
            ghq
            # system
            pulseaudio
            pavucontrol
            # shell
            tmux
            fish
            # gui
            xorg.xrandr
            xorg.xset
            xorg.xmodmap
            arandr
            stumpwm
            # browser
            google-chrome
            # sql
            sqlite
            mariadb
            mysql-workbench
            # tableplus
            # commnunication
            slack
            # runtime
            nodejs_20
            racket
            go
            # aws
            awscli2
            ssm-session-manager-plugin
            copilot-language-server
          ];
        };
        apps.${system}.upgrade = {
          type = "app";
          program = toString (pkgs.writeShellScript "update" ''
            nix flake update
            nix profile upgrade home
          '');
        };
      };
}
