{ config, pkgs, ... }:

{
home.packages = with pkgs; [
    pandoc
    (pkgs.texlive.withPackages (ps: [
            #ps.titlesec
            #ps.silence
            #ps.newunicodechar
  ]))
];
}

