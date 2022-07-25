{
  description = "Introduction to Computational Literary Analysis, a Textbook";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {

    myPython = (nixpkgs.legacyPackages.${system}.python3.withPackages
      (ps: with ps; [
        jupyter
        jupyterlab
        pandas
        nltk
        # spacy
      ]));

    emacsEnv = (nixpkgs.emacsWithPackages (epkgs: with nixpkgs.emacsPackages; [
      org
      org-babel
     ]));

    haskellEnv = (nixpkgs.haskellPackages.ghcWithPackages (ps: with ps; [
       # pandoc-citeproc
       shake         # Build tool
       hlint         # Required for spacemacs haskell-mode
     ]));

    defaultPackage.${system} = self.myPython;
  };

}
