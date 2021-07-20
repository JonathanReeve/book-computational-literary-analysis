{
  description = "Introduction to Computational Literary Analysis, a Textbook";

  outputs = { self, nixpkgs }: with nixpkgs.legacyPackages.x86_64-linux.python3Packages; {

    jupyterBook = import ./jupyter-book.nix;

    myPython = (nixpkgs.legacyPackages.x86_64-linux.python3.withPackages
      (ps: with ps; [
        # pip
        jupyter
        jupyterlab
        self.jupyterBook
        pandas
        nltk
        # spacy
      ]));

    defaultPackage.x86_64-linux = self.myPython;

  };
}
