final: prev: {
  fetch = prev.stdenv.mkDerivation {
    name = "fetch";
    src = ./.; # Assuming fetch.sh is in the same directory

    buildInputs = [prev.lsb-release prev.xorg.xprop];

    installPhase = ''
      mkdir -p $out/bin
      cp ${./fetch.sh} $out/bin/fetch
      chmod +x $out/bin/fetch
    '';

    meta = {
      description = "A shell script to fetch WM info and system details.";
      license = prev.lib.licenses.gpl3;
      maintainers = with prev.lib.maintainers; ["meow the meowtastic"]; # Add your nixos username here
    };
  };
}
