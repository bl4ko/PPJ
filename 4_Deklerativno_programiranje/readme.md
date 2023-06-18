# Install

```bash
brew install ocaml
brew install opam # Ocaml package manager
```

Run `opam init` to initialize opam.

```bash
opam init
# Select version 4.13.0
opam switch create 4.13.0
eval $(opam env)
```

install OCaml kernel for Jupyter

```bash
opam install jupyter
pip install jupyter
ocaml-jupyter-opam-genspec
jupyter kernelspec install --user --name ocaml-jupyter "$(opam config var share)/jupyter"
```