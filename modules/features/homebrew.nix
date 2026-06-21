{ inputs, ... }: {
  flake-file.inputs = {
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };
  
  features.homebrew = {
    darwin = { config, ... }: {
      imports = [
        inputs.nix-homebrew.darwinModules.nix-homebrew
      ];

      environment.variables.HOMEBREW_NO_ANALYTICS = "1";

      nix-homebrew = {
        enable = true;
        mutableTaps = false;
        user = config.system.primaryUser;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
        };
      };

      homebrew = {
        enable = true;
        enableZshIntegration = true;
        taps = builtins.attrNames config.nix-homebrew.taps;

        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
          upgrade = true;
        };
      };
    };
  };
}
