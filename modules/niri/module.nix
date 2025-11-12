{
  wlib,
  lib,
  ...
}:
wlib.wrapModule (
  { config, wlib, ... }:
  {
    options = {
      "config.kdl" = lib.mkOption {
        type = wlib.types.file config.pkgs;
        default.content = "";
      };
    };

    config.package = lib.mkDefault config.pkgs.niri;
    config.env = {
      NIRI_CONFIG = builtins.toString config."config.kdl".path;
    };
    config.meta.maintainers = [
      {
        name = "turbio";
        github = "turbio";
        githubId = 1428207;
      }
    ];
    config.meta.platforms = lib.platforms.linux;
  }
)
