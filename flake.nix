{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        config = {
          allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
            # list of all packages which are allowed to be unfree
            "code"
            "vscode"
            "vscode-with-extensions"
            "vscode-extension-MS-python-vscode-pylance"
          ];
        };
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          vscode
          alloy6
          jdk
          #nusmv
        ];
        
        shellHook = ''
          echo "Welcome to the dev-shell!"
        '';
      };
    });
}
