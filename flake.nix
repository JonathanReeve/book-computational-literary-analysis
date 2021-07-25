{
  description = "Introduction to Computational Literary Analysis, a Textbook";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    jupyterBook = pkgs.callPackage ./jupyter-book.nix {};

    myPython = (nixpkgs.legacyPackages.${system}.python3.withPackages
      (ps: with ps; [
        # pip
        jupyter
        jupyterlab
        self.jupyterBook
        pandas
        nltk
        # spacy
      ]));

    defaultPackage.${system} = self.myPython;
  };
}
