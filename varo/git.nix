{... }:

{

  programs.git = {
    enable = true;
    userName = "0xCAB0";
    userEmail = "alvarocaboac2@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      safe.directory = "/etc/nixos";
      push.autoSetupRemote = true;
      pull.rebase = false;
      commit.gpgsign = true;
      gpg.format = "ssh";
      signing = {

        key = "/home/varo/.ssh/id_github_signing_key.pub";
        signByDefault = true;

      };
    };
  };

}
