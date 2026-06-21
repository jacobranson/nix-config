{ inputs, ... }:
{
  imports = [
    (inputs.den.namespace "features" false)
  ];
}
