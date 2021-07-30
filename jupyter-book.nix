{ python3Packages }:

let
  inherit (python3Packages) buildPythonPackage fetchPypi;
  attrs20 = buildPythonPackage rec {
    pname = "attrs";
    version = "20.3.0";
    src = fetchPypi {
      inherit pname; inherit version;
      sha256 = "007pchhxk2nh6m2rgflkkij9xjwysq3fl7xr72cy8i4pw76s6al3";
    };
    propagatedBuildInputs = with python3Packages; [
      pytest
    ];
  };
  click = buildPythonPackage rec {
    pname = "click";
    version = "7.1";
    src = fetchPypi {
      inherit pname; inherit version;
      sha256 = "1qk0x1bh6pmn2al9kq6cbgvm7pchnzl6ahf4zzpbjljl5lpmabs8";
    };
  };
  jupytext = buildPythonPackage rec {
    pname = "jupytext";
    version = "1.10.3";
    src = fetchPypi {
      inherit pname; inherit version;
      sha256 = "09f0ra3ndq4sxb0q3pjx713pfyc731y6fkzx93481mc7qm2cym5x";
    };
    propagatedBuildInputs = with python3Packages; [
      toml
      pyyaml
      markdown-it-py
    ];
  };
  markdown-it-py = buildPythonPackage rec {
    pname = "markdown-it-py";
    version = "0.6.0";
    src = fetchPypi {
      inherit pname; inherit version;
      sha256 = "0nb6i1hqlipbcpdd7kad26sfhwjxaqnd6md7piaslyzg77gi650w";
    };
    propagatedBuildInputs = [
      attrs20
    ];
  };
  sphinxExternalTOC = buildPythonPackage rec {
    # https://pypi.org/project/sphinx-comments/
    pname = "sphinx-external-toc";
    version = "0.2.2";
    src = fetchPypi {
      pname = "sphinx_external_toc";
      inherit version;
      sha256 = "a72c5861f670f1c7a1b92f2159fc9c7c5370e079cad1e3a7be4b269fa8048e8a";
    };
    propagatedBuildInputs = [
      python3Packages.sphinx
      attrs20
      python3Packages.click
      python3Packages.pyyaml
    ];
  };
  sphinxComments = buildPythonPackage rec {
    # https://pypi.org/project/sphinx-comments/
    pname = "sphinx-comments";
    version = "0.0.3";
    src = fetchPypi {
      inherit version; inherit pname;
      sha256 = "00170afff27019fad08e421da1ae49c681831fb2759786f07c826e89ac94cf21";
    };
    propagatedBuildInputs = with python3Packages; [
      sphinx
    ];
  };
in buildPythonPackage rec {
  pname = "jupyter-book";
  version = "0.11.2";
  src = fetchPypi {
    inherit version; inherit pname;
    sha256 = "e32298e03c19f514c745062891143693c5e001a098bae9d59d2e4434b2099c54";
  };
  propagatedBuildInputs = [
    # click
    attrs20
    python3Packages.linkify-it-py
    python3Packages.sphinx
    sphinxComments
    sphinxExternalTOC
    jupytext
  ];
}
