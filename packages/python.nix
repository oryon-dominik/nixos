# TODO: install pyenv, poetry, and pipx (+ piptools?)

# default packages: httpx, gitfame, rich
# virtualenvwrapper
# fish
# fish virtualfish
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
    # other python packages you want
  ]; 
  python-with-my-packages = python3.withPackages my-python-packages;
in ...