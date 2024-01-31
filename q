[4mnixos-rebuild[24m(8)                      System Manager's Manual                    [4mnixos-rebuild[24m(8)

[1mNAME[0m
       nixos-rebuild — reconfigure a NixOS machine

[1mSYNOPSIS[0m
       [1mnixos-rebuild  [22m{[1mswitch  [22m|  [1mboot  [22m| [1mtest [22m| [1mbuild [22m| [1mdry-build [22m| [1mdry-activate [22m| [1medit [22m| [1mrepl [22m|
                     [1mbuild-vm [22m| [1mbuild-vm-with-bootloader [22m| [1mlist-generations [22m[[1m--json[22m]}
                     [[1m--upgrade [22m| [1m--upgrade-all[22m] [[1m--install-bootloader[22m] [[1m--no-build-nix[22m] [[1m--fast[22m]
                     [[1m--rollback[22m] [[1m--builders [4m[22mbuilder-spec[24m]
                     [[1m--flake [4m[22mflake-uri[24m] [[1m--no-flake[22m] [[1m--override-input [4m[22minput-name[24m [4mflake-uri[24m]
                     [[1m--profile-name [22m| [1m-p [4m[22mname[24m] [[1m--specialisation [22m| [1m-c [4m[22mname[24m]
                     [[1m--build-host [4m[22mhost[24m] [[1m--target-host [4m[22mhost[24m] [[1m--use-remote-sudo[22m]
                     [[1m--show-trace[22m]  [[1m-I  [4m[22mNIX_PATH[24m]  [[1m--verbose  [22m|  [1m-v[22m]   [[1m--accept-flake-config[22m]
                     [[1m--impure[22m] [[1m--max-jobs [22m| [1m-j [4m[22mnumber[24m] [[1m--keep-failed [22m| [1m-K[22m] [[1m--keep-going [22m| [1m-k[22m]

[1mDESCRIPTION[0m
       This  command  updates the system so that it corresponds to the configuration specified in
       [4m/etc/nixos/configuration.nix[24m or [4m/etc/nixos/flake.nix[24m. Thus, every time you modify the con‐
       figuration or any other NixOS module, you must run [1mnixos-rebuild [22mto make the changes  take
       effect.  It  builds the new system in [4m/nix/store[24m, runs its activation script, and stop and
       (re)starts any system services if needed. Please  note  that  user  services  need  to  be
       started manually as they aren't detected by the activation script at the moment.

       This  command has one required argument, which specifies the desired operation. It must be
       one of the following:

       [1mswitch  [22mBuild and activate the new configuration, and make it the boot default.  That  is,
               the  configuration  is  added  to the GRUB boot menu as the default menu entry, so
               that subsequent reboots will boot the system into the new configuration.  Previous
               configurations  activated  with  [1mnixos-rebuild switch [22mor [1mnixos-rebuild boot [22mremain
               available in the GRUB menu.

               Note that if you are using specializations, running just [1mnixos-rebuild switch [22mwill
               switch you back to the unspecialized, base system — in that case, you  might  want
               to use this instead:

                     $ nixos-rebuild switch --specialisation your-specialisation-name

               This command will build all specialisations and make them bootable just like regu‐
               lar [1mnixos-rebuild switch [22mdoes — the only thing different is that it will switch to
               given  specialisation  instead  of  the base system; it can be also used to switch
               from the base system into a specialised one, or to switch between specialisations.

       [1mboot    [22mBuild the new configuration and make it the boot default  (as  with  [1mnixos-rebuild[0m
               [1mswitch[22m), but do not activate it. That is, the system continues to run the previous
               configuration until the next reboot.

       [1mtest    [22mBuild and activate the new configuration, but do not add it to the GRUB boot menu.
               Thus,  if  you reboot the system (or if it crashes), you will automatically revert
               to the default configuration (i.e. the configuration resulting from the last  call
               to [1mnixos-rebuild switch [22mor [1mnixos-rebuild boot[22m).

               Note  that  if you are using specialisations, running just [1mnixos-rebuild test [22mwill
               activate the unspecialised, base system — in that case, you might want to use this
               instead:

                     $ nixos-rebuild test --specialisation your-specialisation-name

               This command can be also used to switch from the base system  into  a  specialised
               one, or to switch between specialisations.

       [1mbuild   [22mBuild  the  new configuration, but neither activate it nor add it to the GRUB boot
               menu. It leaves a symlink named [4mresult[24m in the current directory, which  points  to
               the  output  of the top-level “system” derivation. This is essentially the same as
               doing

                     $ nix-build /path/to/nixpkgs/nixos -A system

               Note that you do not need to be root to run [1mnixos-rebuild build[22m.

       [1mdry-build[0m
               Show what store paths would be built or downloaded by any of the operations above,
               but otherwise do nothing.

       [1mdry-activate[0m
               Build the new configuration, but instead of activating it, show what changes would
               be performed by the activation (i.e. by [1mnixos-rebuild test[22m).  For  instance,  this
               command will print which systemd units would be restarted.  The list of changes is
               not guaranteed to be complete.

       [1medit    [22mOpens [4mconfiguration.nix[24m in the default editor.

       [1mrepl    [22mOpens the configuration in [1mnix repl[22m.

       [1mbuild-vm[0m
               Build a script that starts a NixOS virtual machine with the desired configuration.
               It   leaves  a  symlink  [4mresult[24m  in  the  current  directory  that  points  (under
               ‘result/bin/run-[4mhostname[24m-vm’) at the script that starts the VM. Thus,  to  test  a
               NixOS configuration in a virtual machine, you should do the following:

                     $ nixos-rebuild build-vm
                     $ ./result/bin/run-*-vm

               The  VM  is implemented using the ‘qemu’ package. For best performance, you should
               load the ‘kvm-intel’ or ‘kvm-amd’ kernel modules to get hardware virtualisation.

               The VM mounts the Nix store of the host through the 9P file system. The  host  Nix
               store is read-only, so Nix commands that modify the Nix store will not work in the
               VM.  This  includes  commands such as [1mnixos-rebuild[22m; to change the VM’s configura‐
               tion, you must halt the VM and re-run the commands above.

               The VM has its own ext3 root file system, which is automatically created when  the
               VM  is  first started, and is persistent across reboots of the VM. It is stored in
               ‘./[4mhostname[24m.qcow2’.

       [1mbuild-vm-with-bootloader[0m
               Like [1mbuild-vm[22m, but boots using the regular boot loader of your configuration (e.g.
               GRUB 1 or 2), rather than booting directly into the kernel and initial ramdisk  of
               the  system. This allows you to test whether the boot loader works correctly. How‐
               ever, it does not guarantee that your NixOS configuration will  boot  successfully
               on the host hardware (i.e., after running [1mnixos-rebuild switch[22m), because the hard‐
               ware  and  boot  loader configuration in the VM are different.  The boot loader is
               installed on an automatically generated virtual disk containing a [4m/boot[24m partition.

       [1mlist-generations [22m[[1m--json[22m]
               List the available generations in a similar manner to the  boot  loader  menu.  It
               shows  the  generation  number, build date and time, NixOS version, kernel version
               and the configuration revision.  There is also a json version of output available.

[1mOPTIONS[0m
       [1m--upgrade[22m, [1m--upgrade-all[0m
               Update the root user's channel named ‘nixos’ before rebuilding the system.

               In addition to the ‘nixos’ channel, the root user's channels  which  have  a  file
               named ‘.update-on-nixos-rebuild’ in their base directory will also be updated.

               Passing [1m--upgrade-all [22mupdates all of the root user's channels.

       [1m--install-bootloader[0m
               Causes the boot loader to be (re)installed on the device specified by the relevant
               configuration options.

       [1m--no-build-nix[0m
               Normally,  [1mnixos-rebuild  [22mfirst builds the ‘nixUnstable’ attribute in Nixpkgs, and
               uses the resulting instance of the Nix package manager to  build  the  new  system
               configuration. This is necessary if the NixOS modules use features not provided by
               the currently installed version of Nix. This option disables building a new Nix.

       [1m--fast  [22mEquivalent to [1m--no-build-nix[22m. This option is useful if you call [1mnixos-rebuild [22mfre‐
               quently (e.g. if you’re hacking on a NixOS module).

       [1m--rollback[0m
               Instead     of     building     a    new    configuration    as    specified    by
               [4m/etc/nixos/configuration.nix[24m, roll back to the previous configuration. (The previ‐
               ous configuration is defined as the one before the “current” generation of the Nix
               profile [4m/nix/var/nix/profiles/system[24m.)

       [1m--builders [4m[22mbuilder-spec[0m
               Allow ad-hoc remote builders for building the new system. This requires  the  user
               executing  [1mnixos-rebuild  [22m(usually root) to be configured as a trusted user in the
               Nix daemon. This can be achieved by using the [4mnix.settings.trusted-users[24m NixOS op‐
               tion. Examples values for that option are described in the “Remote builds” chapter
               in the Nix manual, (i.e.  ‘--builders "ssh://bigbrother x86_64-linux"’). By speci‐
               fying an empty string existing builders specified in [4m/etc/nix/machines[24m can be  ig‐
               nored: ‘--builders ""’ for example when they are not reachable due to network con‐
               nectivity.

       [1m--profile-name [4m[22mname[24m, [1m-p [4m[22mname[0m
               Instead of using the Nix profile [4m/nix/var/nix/profiles/system[24m to keep track of the
               current        and        previous        system        configurations,        use
               [4m/nix/var/nix/profiles/system-profiles/name[24m. When you use GRUB 2, for every  system
               profile created with this flag, NixOS will create a submenu named “NixOS - Profile
               [4mname[24m”  in  GRUB’s boot menu, containing the current and previous configurations of
               this profile.

               For instance, if you want to test a configuration file named [4mtest.nix[24m without  af‐
               fecting the default system profile, you would do:

                     $ nixos-rebuild switch -p test -I nixos-config=./test.nix

               The new configuration will appear in the GRUB 2 submenu “NixOS - Profile 'test'”.

       [1m--specialisation [4m[22mname[24m, [1m-c [4m[22mname[0m
               Activates given specialisation; when not specified, switching and testing will ac‐
               tivate the base, unspecialised system.

       [1m--build-host [4m[22mhost[0m
               Instead  of building the new configuration locally, use the specified host to per‐
               form the build. The host needs to be accessible with [1mssh[22m, and must be able to per‐
               form Nix builds. If the option [1m--target-host [22mis not set, the build will be  copied
               back to the local machine when done.

               Note  that, if [1m--no-build-nix [22mis not specified, Nix will be built both locally and
               remotely. This is because the configuration will always be evaluated locally  even
               though the building might be performed remotely.

               You  can include a remote user name in the host name ([4muser@host[24m). You can also set
               ssh options by defining the NIX_SSHOPTS environment variable.

       [1m--target-host [4m[22mhost[0m
               Specifies the NixOS target host. By setting this to something other than an  empty
               string,  the system activation will happen on the remote host instead of the local
               machine. The remote host needs to be accessible over [1mssh[22m,  and  for  the  commands
               [1mswitch[22m, [1mboot [22mand [1mtest [22myou need root access.

               If [1m--build-host [22mis not explicitly specified or empty, building will take place lo‐
               cally.

               You  can include a remote user name in the host name ([4muser@host[24m). You can also set
               ssh options by defining the NIX_SSHOPTS environment variable.

               Note that [1mnixos-rebuild [22mhonors the [4mnixpkgs.crossSystem[24m setting of the  given  con‐
               figuration  but  disregards  the  true  architecture of the target host. Hence the
               [4mnixpkgs.crossSystem[24m setting has to match the target platform  or  else  activation
               will fail.

       [1m--use-substitutes[0m
               When set, nixos-rebuild will add [1m--use-substitutes [22mto each invocation of nix-copy-
               closure.  This  will only affect the behavior of nixos-rebuild if [1m--target-host [22mor
               [1m--build-host [22mis also set. This  is  useful  when  the  target-host  connection  to
               cache.nixos.org is faster than the connection between hosts.

       [1m--use-remote-sudo[0m
               When set, nixos-rebuild prefixes activation commands that run on the [1m--target-host[0m
               system with [1msudo[22m. Setting this option allows deploying as a non-root user.

       [1m--flake [4m[22mflake-uri[24m[[4m#name[24m]
               Build the NixOS system from the specified flake. It defaults to the directory con‐
               taining  the  target  of the symlink [4m/etc/nixos/flake.nix[24m, if it exists. The flake
               must contain an output named ‘nixosConfigurations.[4mname[24m’. If [4mname[24m  is  omitted,  it
               default to the current host name.

       [1m--no-flake[0m
               Do  not imply [1m--flake [22mif [4m/etc/nixos/flake.nix[24m exists. With this option, it is pos‐
               sible to build non-flake NixOS configurations even if the  current  NixOS  systems
               uses flakes.

       In  addition,  [1mnixos-rebuild  [22maccepts various Nix-related flags, including [1m--max-jobs[22m, [1m-j[22m,
       [1m-I[22m, [1m--accept-flake-config[22m, [1m--show-trace[22m, [1m--keep-failed[22m, [1m--keep-going[22m, [1m--impure[22m, [1m--verbose[22m,
       and [1m-v[22m. See the Nix manual for details.

[1mENVIRONMENT[0m
       NIXOS_CONFIG
               Path    to    the    main    NixOS    configuration    module.     Defaults     to
               [4m/etc/nixos/configuration.nix[24m.

       NIX_PATH
               A  colon-separated list of directories used to look up Nix expressions enclosed in
               angle brackets (e.g. <nixpkgs>). Example:

                     nixpkgs=./my-nixpkgs

       NIX_SSHOPTS
               Additional options to be passed to [1mssh [22mon the command line.

       NIXOS_SWITCH_USE_DIRTY_ENV
               Expose the the current environment variables to post activation scripts. Will skip
               usage of [1msystemd-run [22mduring system activation. Possibly  dangerous,  specially  in
               remote environments (e.g.: via SSH). Will be removed in the future.

[1mFILES[0m
       [4m/etc/nixos/flake.nix[0m
               If  this  file exists, then [1mnixos-rebuild [22mwill use it as if the [1m--flake [22moption was
               given. This file may be a  symlink  to  a  [4mflake.nix[24m  in  an  actual  flake;  thus
               [4m/etc/nixos[24m need not be a flake.

       [4m/run/current-system[0m
               A symlink to the currently active system configuration in the Nix store.

       [4m/nix/var/nix/profiles/system[0m
               The Nix profile that contains the current and previous system configurations. Used
               to generate the GRUB boot menu.

[1mBUGS[0m
       This command should be renamed to something more descriptive.

[1mAUTHORS[0m
       Eelco Dolstra and the Nixpkgs/NixOS contributors

Nixpkgs                                  January 1, 1980                         [4mnixos-rebuild[24m(8)
