{ 
  allowUnfree = true;
  allowUnsupportedSystem = true;
  packageOverrides = pkgs: with pkgs; rec {
    myProfile = writeText "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH
      export MANPATH=$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:$MANPATH
    '';
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        firefox
        qutebrowser
        zoom
      ];
      pathsToLink = [ "/share/man" "/share/doc" "/bin" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
