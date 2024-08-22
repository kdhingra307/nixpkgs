{
  lib,
  postgresql,
  buildPgrxExtension,
  fetchFromGitHub,
  stdenv,
  darwin
}:

buildPgrxExtension rec {
  inherit postgresql;
  pname = "pgvectorscale";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "timescale";
    repo = "pgvectorscale";
    rev = "${version}";
    hash = "sha256-zG2dAd+F4ChG2HFXH3AHQba/5RcQwrqWPlo6LW2SBq0=";
  };
  cargoHash = "sha256-jtBw4ahSl88L0iuCXxQgZVm1EcboWRJMNtjxLVTtptd=";
  # as by default HOME is a dummy directory
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';
  postBuild = ''
    export HOME=$(pwd)
  '';
  cargoLock = {
    lockFile = ./Cargo.lock;
  };
  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks. SystemConfiguration
  ];
  doCheck = false;

  vendorHash = "sha256-g6YtayaXntIhtPvKfbNlL08f6yL4u3hU8ZRyeSSD0=";
  sourceRoot = "${src.name}/pgvectorscale";

  meta = with lib; {
    description = "pgvectorscale Extension";
    homepage = "https://github.com/timescale/pgvectorscale";
    license = licenses.asl20;
    maintainers = [ maintainers.kdhingra307 ];
    mainProgram = "pgvectorscale";
  };
}