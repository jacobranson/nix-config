{ __findFile, ... }: {
  den.aspects.mac-studio = {
    includes = [
      <features/homebrew>
      <features/fastfetch>
      <features/ghostty>
      <features/vscode>
      <features/godot>
    ];
  };
}
