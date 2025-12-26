{ config, pkgs, ... }:
{
  programs.vscode = {
  enable = true;
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
}
