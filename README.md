# nix-config

My personal [Nix](https://nixos.org/) configuration powered by [Den](https://github.com/denful/den).

## Onboarding

> [!NOTE] NOTE
> 
> This onboarding guide assumes you are on macOS.

Use the [official experimental Nix Installer](https://github.com/NixOS/nix-installer) to get Nix if you don't have it.

```bash
$ curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
```

Make a temporary Nix shell containing Git, NH, and an editor of your choice. I use Helix with Nil for Nix syntax highlighting.

```bash
$ nix-shell -p git helix nil nh
```

Then, prepare your Nix flake directory as such.

```bash
sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin
```

Now clone this repo directly into `/etc/nix-darwin`, NOT `/etc/nix-darwin/nix-config` (notice the `.` at the end). Make a fresh Git repo for yourself.

```bash
git clone https://github.com/jacobranson/nix-config.git .
rm -rf .git
git init .
```

Make whatever changes you need, at a minimum replacing my username and hostname with your own. My defaults should give you everything you need out of the box. Be sure to make your own Git repo instead of pushing to mine.

```bash
rm -rf .git
git init .
```

When done, apply the changes.

```bash
nh darwin switch .#replace-me-with-your-hostname
```

You'll no longer need to rely on that temporary Nix shell. Also, from now on, you can simply do `nh darwin switch` with no arguments, since `/etc/nix-darwin` is the default directory for a Nix flake on macOS.
