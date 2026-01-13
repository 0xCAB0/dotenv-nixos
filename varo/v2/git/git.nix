{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "0xCAB0";
        email = "info@alvarocabo.com";
      };
      init.defaultBranch = "main";
      core.editor = "nvim";
      safe.directory = "/etc/nixos";
      push.autoSetupRemote = true;
      pull.rebase = false;
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingKey = "~/.ssh/id_github_signing_key.pub";
    };
  };
}
