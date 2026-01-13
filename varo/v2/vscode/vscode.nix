{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Themes
        dracula-theme.theme-dracula
        # Editors
        jnoortheen.nix-ide
        yzhang.markdown-all-in-one
        # Rust
        fill-labs.dependi
        tamasfe.even-better-toml
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
        mkhl.direnv
      ];
    };
  };
}
