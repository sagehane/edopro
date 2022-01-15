{
  description = "A script engine for \"yu-gi-oh!\" and sample gui (former \"ygopro\")";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , ...
    } @ inputs:
    let
      overlays = [
        # Other overlays
        (final: prev: {
          zigpkgs = inputs.zig.packages.${prev.system};
        })
      ];

      # Our supported systems are the same supported systems as the Zig binaries
      systems = builtins.attrNames inputs.zig.packages;
    in
    flake-utils.lib.eachSystem systems (
      system:
      let
        pkgs = import nixpkgs { inherit overlays system; };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            zigpkgs.master

            curl
            flac
            #fmt_8
            freetype
            libevent
            libgit2
            libvorbis
            nlohmann_json
            openal
            sqlite
            wayland
            xorg.libX11

            # For NO_IRR_WAYLAND_DYNAMIC_LOAD_
            libxkbcommon

            # For NO_IRR_DYNAMIC_OPENGL_
            libGL

            # For Lua
            readline

            # For fmt
            cmake

            # For Irrlicht
            libGL
            libxkbcommon
            wayland
            xorg.libX11
            xorg.libXxf86vm
          ];
        };
      }
    );
}
