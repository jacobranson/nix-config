{ self, inputs, lib, den, ... }:
{
  # required dependencies and module imports for any den
  flake-file.inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    darwin.url       = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    flake-parts.url  = "github:hercules-ci/flake-parts";
    flake-file.url   = "github:denful/flake-file";
    import-tree.url  = "github:denful/import-tree";
    den.url          = "github:denful/den/latest";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

  # enables angle brackets syntax in modules that pass __findFile as an arg
  _module.args.__findFile = den.lib.__findFile;

  # all users should use home manager by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # enable nh outputs
  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };

  # configs to apply to systems by default
  den.default = {
    # configs to apply to both darwin and nixos systems
    os = { pkgs, ... }: {
      # enable nix flakes and disable channels
      nix = {
        settings.experimental-features = "nix-command flakes";
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        channel.enable = false;
      };

      # enable zsh
      programs.zsh.enable = true;
      environment.shells = [ pkgs.zsh ];

      # state management
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };

    # configs to apply to only darwin systems
    darwin = {
      # state management
      system.stateVersion = 6;
    };

    # configs to apply to only nixos systems
    nixos = {
      # state management
      system.stateVersion = "26.05";
    };

    # configs to apply to user homes
    homeManager = {
      programs.zsh.enable = true;
      programs.nh.enable = true;

      # state management
      home.stateVersion = "26.05";
    };

    # default batteries
    includes = [
      den.batteries.hostname
      den.batteries.define-user
    ];
  };
}
