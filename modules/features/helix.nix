{
  features.helix = {
    homeManager = { pkgs, ... }: {
      programs.helix = {
        enable = true;
        extraPackages = [ pkgs.nil ];
        settings.theme = "base16_transparent";
      };
    };
  };
}

