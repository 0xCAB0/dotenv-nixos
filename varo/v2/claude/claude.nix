{ ... }:

{
  programs.claude-code = {
    enable = true;
    rulesDir = ./rules;
    commandsDir = ./commands;
    memory.source = ./claude.md;
  };
}
