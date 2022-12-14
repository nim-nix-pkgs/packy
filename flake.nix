{
  description = ''Library to pack dependencies in the compiled binary. Supports .dll files'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."packy-master".dir   = "master";
  inputs."packy-master".owner = "nim-nix-pkgs";
  inputs."packy-master".ref   = "master";
  inputs."packy-master".repo  = "packy";
  inputs."packy-master".type  = "github";
  inputs."packy-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."packy-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}