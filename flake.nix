{
  description = "Introduction to Computational Literary Analysis, a Textbook";

  outputs = { self, nixpkgs }: {

    myPython = (nixpkgs.legacyPackages.x86_64-linux.python3.withPackages
      (ps: with ps; [
        pip
        jupyter
        jupyterlab
        jupyter-book
        pandas
        nltk
        spacy
      ]));

    defaultPackage.x86_64-linux = self.myPython;

  };
}
