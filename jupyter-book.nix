{ config, lib, pkgs, ... }:

let
  sphinxExternalTOC = pkgs.python3Packages.buildPythonPackage rec {
    # https://pypi.org/project/sphinx-comments/
    pname = "sphinx-external-toc";
    version = "0.2.2";
    src = pkgs.fetchPypi {
      inherit version; inherit pname;
      sha256 = "a72c5861f670f1c7a1b92f2159fc9c7c5370e079cad1e3a7be4b269fa8048e8a";
    };
    propagatedBuildInputs = with pkgs.python3Packages; [
      sphinx
    ];
  };
  sphinxComments = pkgs.python3Packages.buildPythonPackage rec {
    # https://pypi.org/project/sphinx-comments/
    pname = "sphinx-comments";
    version = "0.0.3";
    src = pkgs.fetchPypi {
      inherit version; inherit pname;
      sha256 = "00170afff27019fad08e421da1ae49c681831fb2759786f07c826e89ac94cf21";
    };
    propagatedBuildInputs = with pkgs.python3Packages; [
      sphinx
    ];
  };
in pkgs.python3Packages.buildPythonPackage rec {
  pname = "jupyter-book";
  version = "0.11.2";
  src = pkgs.fetchPypi {
    inherit version; inherit pname;
    sha256 = "e32298e03c19f514c745062891143693c5e001a098bae9d59d2e4434b2099c54";
  };
  propagatedBuildInputs = with pkgs.python3Packages; [
    # click
    linkify-it-py
    sphinx
    self.sphinxComments
    self.sphinxExternalTOC
  ];
}
