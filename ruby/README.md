# Ruby Development Shell

## Changes

Use this template to create your own ruby nix development shell.
After changing the version of ruby you want to use run the following command :
``` nix-shell ```

## Details

You need to have a Gemfile, Gemfile.lock and gemset.nix in order for this to work.
If you have the first two install bundix and run
``` bundix -l ``` 
in your gem directory to create a gemset.nix
