{
  description = "home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in
      {
        packages.${system}.home = nixpkgs.legacyPackages.${system}.buildEnv {
          name = "home";
          paths = with nixpkgs.legacyPackages.${system}; [
            git
            curl
          ];
        };
      };
}
