{ stdenv }:
{
  deathstar-sddm-theme = stdenv.mkDerivation rec {
    pname = "deathstar-sddm-theme";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/deathstar-sddm-theme
    '';
    src = sddm/themes/deathstar-sddm-theme;
  };
}
