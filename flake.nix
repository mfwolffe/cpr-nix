{
  description = "Nix env for MusicCPR";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    # 2.7.18.7 release
    python_dep.url = "github:NixOS/nixpkgs/a9858885e197f984d92d7fe64e9fff6b2e488d40#python312";
  };

  outputs = {
    self,
    flake-utils,
    python_dep,
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      python_dep = inputs.python_dep.legacyPackages.${system};
    in {
      devShells.default = python_dep.mkShell {
        packages = [
          python_dep.python2
        ];

        shellHook = ''
          python --version
        '';
      };
    });
}
