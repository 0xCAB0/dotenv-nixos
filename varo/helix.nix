{ lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "dark_plus_plus";
      editor = {
        lsp.auto-signature-help = false;
        clipboard-provider = "x-clip";
        auto-format = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        whitespace = {
          character.tab = "	";
          render = {
            space = "all";
            tab = "all";
            newline = "none";
          };
        };
        soft-wrap = {
          enable = true;
          wrap-indicator = "";
        };
        inline-diagnostics = {
          cursor-line = "warning";
        };
      };
      keys.normal = {
        P = "paste_after";
        p = "paste_before";
      };
      keys.insert = {
        tab = "insert_tab";
      };
    };
    themes = {
      dark_plus_plus = {
        "inherits" = "dark_plus";
        "ui.background" = "black";
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "${lib.getExe pkgs.nixfmt-rfc-style}";
            args = [ ];
          };
          language-servers = [
            "nil"
            "nixd"
          ];
        }
        {
          name = "typst";
          formatter = {
            command = "${lib.getExe pkgs.typstyle}";
            args = [ ];
          };
          language-servers = [
            "tinymist"
            "typst-lsp"
          ];
        }
        {
          name = "markdown";
          formatter = {
            command = "${lib.getExe pkgs.comrak}";
            args = [
              "--gfm"
              "--width"
              "80"
              "--to"
              "commonmark"
            ];
          };
        }
        {
          name = "latex";
          language-servers = [
            "texlab"
            "ltex"
          ];
        }
        {
          name = "zig";
          formatter = {
            command = "${lib.getExe pkgs.zig}";
            args = [
              "fmt"
              "--stdin"
            ];
          };
        }
        {
          name = "elixir";
          formatter = {
            command = "${lib.getExe' pkgs.elixir "mix"}";
            args = [
              "format"
              "-"
            ];

          };
        }
      ];
      language-server.nil.command = "${lib.getExe pkgs.nil}";
      language-server.nixd.command = "${lib.getExe pkgs.nixd}";
      language-server.marksman.command = "${lib.getExe pkgs.marksman}";
      language-server.tinymist.command = "${lib.getExe pkgs.tinymist}";
      language-server.texlab.command = "${lib.getExe pkgs.texlab}";
      language-server.ltex = {
        command = "${lib.getExe' pkgs.ltex-ls "ltex-ls"}";
        config.ltex.language = "en-GB";
      };
      language-server.elixir.command = "${lib.getExe pkgs.elixir-ls}";
      language-server.zig.command = "${lib.getExe pkgs.zls}";
      language-server.typescript-language-server.command = "${lib.getExe pkgs.nodePackages.typescript-language-server}";
    };
  };
}
