final: prev: {
  fetch = prev.stdenv.mkDerivation {
    name = "fetch";
    src = ./.;

    buildInputs = [prev.lsb-release prev.xorg.xprop];

    installPhase = ''
      mkdir -p $out/bin
      cp ${./bin/fetch.sh} $out/bin/fetch
      chmod +x $out/bin/fetch
    '';

    meta = {
      description = "lorem ipsum dolor sit amer";
      license = prev.lib.licenses.gpl3;
      maintainers = with prev.lib.maintainers; ["meow the meowtastic"]; 
    };
  };
}
