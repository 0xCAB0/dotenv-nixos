{ pkgs, ... }:

{

  programs.neovim =

    let
      readFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in

    {
      enable = true;

      extraPackages = with pkgs; [
        # Lua lsp
        luajitPackages.lua-lsp
        # Nix language server
        nil

        # Rust language server
        # It is not installed because this should be installed by the rust project itself in a nix develop env
        #                rust-analyzer

        # save to the clipboard
        xclip
        wl-clipboard
      ];

      plugins = with pkgs.vimPlugins; [
        ########## LSP and completions ############
        {
          plugin = nvim-lspconfig;
          config = readFile ./plugins/lsp.lua;
        }

        {
          plugin = nvim-cmp;
          config = readFile ./plugins/cmp.lua;
        }
        cmp-nvim-lsp
        neodev-nvim

        {
          plugin = nvim-autopairs;
          config = readFile ./plugins/autopairs.lua;
        }

        #### Rust vim plugins ####
        rust-vim

        #### Lua snippets plugin ###
        cmp_luasnip
        luasnip
        lualine-nvim

        friendly-snippets

        ##### Markdown preview ####
        ############# Telescope ###############
        {
          plugin = telescope-nvim;
          config = readFile ./plugins/telescope.lua;
        }
        telescope-fzf-native-nvim

        ############# Treesitter ##############
        {
          plugin = (
            nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
              p.tree-sitter-rust
              p.tree-sitter-elixir
              p.tree-sitter-markdown
              p.tree-sitter-just
            ])
          );
          config = readFile ./plugins/treesitter.lua;
        }

        {
          plugin = nvim-treesitter-parsers.heex;
        }

        {
          plugin = nvim-treesitter-parsers.html;
        }

        {
          plugin = gruvbox-nvim;
          config = "colorscheme gruvbox";
        }

        {
          plugin = onedarkpro-nvim;
          #            config = "colorscheme onedark_vivid";
        }

      ];

      extraLuaConfig = ''${builtins.readFile ./options.lua}'';
    };

}
