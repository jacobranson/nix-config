{ __findFile, ... }: {
  den.aspects.jacobranson = {
    homeManager.programs.git.settings.user = {
      name = "Jacob Ranson";
      email = "code@jacobranson.dev";
    };

    includes = [
      <den/primary-user>
      # (<den/user-shell> "zsh") TODO https://github.com/denful/den/discussions/618

      <features/starship>
      <features/helix>
      <features/git>
    ];
  };
}
