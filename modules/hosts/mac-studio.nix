{ __findFile, ... }: {
  den.aspects.mac-studio = {
    includes = [
      <features/homebrew>
      <features/fastfetch>
    ];
  };
}

