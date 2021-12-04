{ pkgs, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
      # required for a proper working of remote-ssh vscode on nix:
      # bbenoist.Nix
      # ms-python.python
      # ms-azuretools.vscode-docker
      # ms-vscode-remote.remote-ssh

      # TODO: (builtins.fromJSON (builtins.readFile ../config/vscode-extensions.json));
    ]);

  vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };

in {
  config = {
    environment.systemPackages = [
      vscode-with-extensions
    ];
  };

}
