{
  wlib,
  lib,
  ...
}:
wlib.wrapModule (
  { config, wlib, ... }:
  let
    jsonFmt = config.pkgs.formats.json { };
    conf = jsonFmt.generate "waybar-config" config.settings;
  in
  {
    options = {
      settings = lib.mkOption {
        type = jsonFmt.type;
        default = {
        };
      };
      style = lib.mkOption {
        type = wlib.types.file config.pkgs;
        default.content = "";
      };
    };

    config.package = lib.mkDefault config.pkgs.waybar;
    config.env = {
      XDG_CONFIG_HOME = builtins.toString (
        config.pkgs.linkFarm "waybar-merged-config" [
          {
            name = "waybar/config";
            path = conf;
          }
          {
            name = "waybar/style.css";
            path = config.style.path;
          }
        ]
      );
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
