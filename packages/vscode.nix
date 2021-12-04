{ pkgs, lib, ... }:

let
  extensions = (with pkgs.vscode-extensions; [
      # required for a proper working of remote-ssh vscode on nix:
      # bbenoist.Nix
      # ms-python.python
      # ms-azuretools.vscode-docker
      # ms-vscode-remote.remote-ssh

      13xforever.language-x86-64-assembly
      4ops.terraform
      aaron-bond.better-comments
      abusaidm.html-snippets
      adpyke.codesnap
      alefragnani.Bookmarks
      alefragnani.project-manager
      alexcvzz.vscode-sqlite
      AndersEAndersen.html-class-suggestions
      Anjali.clipboard-history
      atlassian.atlascode
      austenc.tailwind-docs
      batisteo.vscode-django
      bbenoist.Nix
      bencoleman.armview
      bierner.emojisense
      bierner.markdown-checkbox
      bmuskalla.vscode-tldr
      bradlc.vscode-tailwindcss
      christian-kohler.path-intellisense
      ckolkman.vscode-postgres
      codespaces-contrib.codeswing
      codezombiech.gitignore
      CoenraadS.bracket-pair-colorizer-2
      cstrap.python-snippets
      cweijan.vscode-office
      damienaicheh.azure-devops-snippets
      dbaeumer.vscode-eslint
      DotJoshJohnson.xml
      dr-rockso.theme-nosferatu
      dunstontc.vscode-docker-syntax
      dzhavat.git-cheatsheet
      eamodio.gitlens
      ecmel.vscode-html-css
      EFanZh.graphviz-preview
      erd0s.terraform-autocomplete
      esbenp.prettier-vscode
      firefox-devtools.vscode-firefox-debug
      formulahendry.auto-close-tag
      formulahendry.docker-explorer
      frhtylcn.pythonsnippets
      GitHub.codespaces
      GitHub.copilot
      GitHub.remotehub
      golang.go
      Gruntfuggly.todo-tree
      guyskk.language-cython
      hashicorp.terraform
      hbenl.vscode-test-explorer
      hediet.vscode-drawio
      hex-ci.stylelint-plus
      heybourn.headwind
      HookyQR.beautify
      hoovercj.vscode-power-mode
      humao.rest-client
      IBM.output-colorizer
      ionutvmi.reg
      James-Yu.latex-workshop
      jpoissonnier.vscode-styled-components
      justusadam.language-haskell
      Keno.uikit-3-snippets
      KevinRose.vsc-python-indent
      littlefoxteam.vscode-python-test-adapter
      lostintangent.vsls-whiteboard
      magicstack.MagicPython
      marp-team.marp-vscode
      matklad.rust-analyzer
      MaxChamps.django-commands
      mechatroner.rainbow-csv
      mgmcdermott.vscode-language-babel
      mhutchie.git-graph
      mikestead.dotenv
      mkaufman.HTMLHint
      mohsen1.prettify-json
      ms-azure-devops.azure-pipelines
      ms-azuretools.vscode-azureappservice
      ms-azuretools.vscode-azureresourcegroups
      ms-azuretools.vscode-azureterraform
      ms-azuretools.vscode-docker
      MS-CEINTL.vscode-language-pack-de
      ms-dotnettools.csharp
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-wsl
      ms-vscode-remote.vscode-remote-extensionpack
      ms-vscode.azure-account
      ms-vscode.cpptools
      ms-vscode.hexeditor
      ms-vscode.test-adapter-converter
      ms-vsliveshare.vsliveshare
      ms-vsliveshare.vsliveshare-audio
      ms-vsliveshare.vsliveshare-pack
      mtxr.sqltools
      mtxr.sqltools-driver-pg
      mtxr.sqltools-driver-sqlite
      Mukundan.python-docs
      njpwerner.autodocstring
      octref.vetur
      pancho111203.vscode-ipython
      PKief.material-icon-theme
      ptweir.python-string-sql
      pynickle.useful-python-snippets
      qwtel.sqlite-viewer
      redhat.vscode-commons
      redhat.vscode-xml
      redhat.vscode-yaml
      reflog.vscode-bucket-explorer
      run-at-scale.terraform-doc-snippets
      rust-lang.rust
      ryu1kn.partial-diff
      ryuta46.multi-command
      shamanu4.django-intellisense
      skyapps.fish-vscode
      SonarSource.sonarlint-vscode
      srmeyers.git-prefix
      stkb.rewrap
      stylelint.vscode-stylelint
      sysoev.language-stylus
      theumletteam.umlet
      tht13.rst-vscode
      tidalcycles.vscode-tidalcycles
      tootone.org-mode
      Tyriar.luna-paint
      uctakeoff.vscode-counter
      usernamehw.errorlens
      vadimcn.vscode-lldb
      vector-of-bool.gitflow
      VisualStudioExptTeam.vscodeintellicode
      vsls-contrib.codetour
      vsls-contrib.gistfs
      vvzen.vscode-foxdot
      wmaurer.vscode-jumpy
      yzane.markdown-pdf
      Zignd.html-css-class-completion

    ]);
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };
in {
  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];
  config = {
    environment.systemPackages = [
      vscode-with-extensions
    ];
  };
}
