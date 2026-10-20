{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      system = "x86_64-linux";
    in
    {
      packages.${system}.default = pkgs.python312Packages.buildPythonApplication {
        name = "alienfx";
        version = "2.4.3";
        src = ./.;
        pyproject = true;
        build-system = with pkgs.python312Packages; [ setuptools ];

        propagatedBuildInputs = [
          pkgs.python312Packages.pyusb
          pkgs.python312Packages.pycairo
          pkgs.python312Packages.future
          pkgs.python312Packages.setuptools_80

          pkgs.python312Packages.pygobject3
          pkgs.gtk3
        ];
        nativeBuildInputs = [
          pkgs.wrapGAppsHook3
          pkgs.gobject-introspection
        ];
      };
    };
}
