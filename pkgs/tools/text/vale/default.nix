{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "vale";
  version = "2.15.1";

  subPackages = [ "cmd/vale" ];
  outputs = [ "out" "data" ];

  src = fetchFromGitHub {
    owner = "errata-ai";
    repo = "vale";
    rev = "v${version}";
    sha256 = "sha256-akJgIS+jf2n9NC4A+/gNQR62BaJ6T9vvdxJggOTRHn8=";
  };

  vendorSha256 = "sha256-2vYe943HHybOLcP8nDJe7RimMRIJdND2UPwtwB2mttE=";

  postInstall = ''
    mkdir -p $data/share/vale
    cp -r styles $data/share/vale
  '';

  ldflags = [ "-s" "-w" "-X main.version=${version}" ];

  meta = with lib; {
    homepage = "https://docs.errata.ai/vale/about";
    description = "A syntax-aware linter for prose built with speed and extensibility in mind";
    license = licenses.mit;
    maintainers = [ maintainers.marsam ];
  };
}
