{
  description = "Introduction to Computational Literary Analysis, a Textbook";

  outputs = { self, nixpkgs }: {

    myGHC = (nixpkgs.legacyPackages.x86_64-linux.haskellPackages.ghcWithPackages
      (ps: with ps; [
        shake
        hlint
        hoogle
        turtle
      ]));

    defaultPackage.x86_64-linux = self.myGHC;

  };
}
