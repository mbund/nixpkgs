{ lib, systemdUtils }:

with systemdUtils.lib;
with systemdUtils.unitOptions;
with lib;

rec {
  units = with types;
    attrsOf (submodule ({ name, config, ... }: {
      options = concreteUnitOptions;
      config = { unit = mkDefault (systemdUtils.lib.makeUnit name config); };
    }));

  services = with types; attrsOf (submodule [ stage2ServiceOptions unitConfig stage2ServiceConfig ]);
  initrdServices = with types; attrsOf (submodule [ stage1ServiceOptions unitConfig stage1ServiceConfig ]);

  targets = with types; attrsOf (submodule [ stage2CommonUnitOptions unitConfig ]);
  initrdTargets = with types; attrsOf (submodule [ stage1CommonUnitOptions unitConfig ]);

  sockets = with types; attrsOf (submodule [ stage2SocketOptions unitConfig ]);
  initrdSockets = with types; attrsOf (submodule [ stage1SocketOptions unitConfig ]);

  timers = with types; attrsOf (submodule [ stage2TimerOptions unitConfig ]);
  initrdTimers = with types; attrsOf (submodule [ stage1TimerOptions unitConfig ]);

  paths = with types; attrsOf (submodule [ stage2PathOptions unitConfig ]);
  initrdPaths = with types; attrsOf (submodule [ stage1PathOptions unitConfig ]);

  slices = with types; attrsOf (submodule [ stage2SliceOptions unitConfig ]);
  initrdSlices = with types; attrsOf (submodule [ stage1SliceOptions unitConfig ]);

  mounts = with types; listOf (submodule [ stage2MountOptions unitConfig mountConfig ]);
  initrdMounts = with types; listOf (submodule [ stage1MountOptions unitConfig mountConfig ]);

  automounts = with types; listOf (submodule [ stage2AutomountOptions unitConfig automountConfig ]);
  initrdAutomounts = with types; attrsOf (submodule [ stage1AutomountOptions unitConfig automountConfig ]);
}
