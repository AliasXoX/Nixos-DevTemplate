let
  nixpkgs =
    import (builtins.fetchTarball {
      url = https://github.com/NixOS/nixpkgs/archive/ee4a6e0f566fe5ec79968c57a9c2c3c25f2cf41d.tar.gz;
    }) { };
  nixpkgs-ruby =
    import (builtins.fetchTarball {
      url = https://github.com/bobvanderlinden/nixpkgs-ruby/archive/c1ba161adf31119cfdbb24489766a7bcd4dbe881.tar.gz;
    });

  targetRuby = nixpkgs-ruby.packages.x86_64-linux."ruby-x.x.x";


  myBundler = nixpkgs.bundler.override {
    ruby = targetRuby;
  };

  gems =
    nixpkgs.bundlerEnv {

      name     = "rails-gems";
      ruby = targetRuby;
      bundler  = myBundler;
      gemfile  = ./Gemfile;
      lockfile = ./Gemfile.lock;
      gemset   = ./gemset.nix;
    };

in
  nixpkgs.mkShell {
    buildInputs = [
      targetRuby
      gems
      gems.wrappedRuby
      nixpkgs.bundler
      nixpkgs.bundix
      nixpkgs.nodejs
      nixpkgs.yarn
      nixpkgs.postgresql
    ];
  }

