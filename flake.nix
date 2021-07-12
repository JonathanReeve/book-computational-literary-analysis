{
  description = "Introduction to Computational Literary Analysis, a Textbook";

  outputs = { self, nixpkgs }: {

    myGHC = (nixpkgs.pkgs.haskellPackages.ghcWithPackages (ps: with ps; [
      shake
      hlint
      hoogle
      turtle
    ]));

    defaultPackage.x86_64-linux = self.myGHC;

  };
}
