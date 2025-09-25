{ ... }:

{

  ## Inspired on this
  ## https://blog.gitbutler.com/how-git-core-devs-configure-git/

  programs.git = {
    enable = true;
    userName = "Pepe Márquez Romero";
    userEmail = "pepe.marquezromero@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";

      core = {
        editor = "hx";
        fsmonitor = true;
        untrackedCache = true;
      };
      column.ui = "auto";
      branch.sort = "-committerdate";
      safe.directory = "/etc/nixos";

      diff = {

        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;

      };
      help.autocorrect = "prompt";
      merge.conflictstyle = "zdiff3";
      fetch = {

        prune = true;
        pruneTags = true;
        all = true;
      };

      push = {
        autoSetupRemote = true;
        default = "simple";
        followTags = true;
      };

      pull.rebase = true;
      commit.gpgsign = true;
      signing = {
        key = "0C67C336EDFAA32C";
        signByDefault = true;

      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };

    };
  };

}
