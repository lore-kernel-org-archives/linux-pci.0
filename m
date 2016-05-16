Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 May 2016 23:19:48 +0200
Message-ID: <CAJZ5v0jqUmYoWw2gpm1QAzvd3QEx7jxmyfroCeMmkZ2kmR_mGw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v4.7-rc1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc1

to receive core ACPI code updates for v4.7-rc1 with top-most commit
fc723957801465c4a911d0a509709f0f8b91aa8a

 Merge branches 'acpi-pci', 'acpi-misc' and 'acpi-tools'

on top of commit 44549e8f5eea4e0a41b487b63e616cb089922b99

 Linux 4.6-rc7

The new features here are ACPI 6.1 support (and some previously
missing bits of ACPI 6.0 support) in ACPICA and two new drivers,
a driver for the ACPI Generic Event Device (GED) feature introduced
by ACPI 6.1 and the INT3406 thermal driver for display thermal
management.  Also the value returned by the _HRV (hardware revision)
ACPI object will be exported to user space via sysfs now.

In addition to that, ACPI on ARM64 will not depend on EXPERT any
more.

The rest is mostly fixes and cleanups and some code reorganization.

Specifics:

 - In-kernel ACPICA code update to the upstream release 20160422
   adding support for ACPI 6.1 along with some previously missing
   bits of ACPI 6.0 support, making a fair amount of fixes and
   cleanups and reducing divergences between the upstream ACPICA
   and the in-kernel code (Bob Moore, Lv Zheng, Al Stone, Aleksey
   Makarov, Will Miles).

 - ACPI Generic Event Device (GED) support and a fix for it (Sinan Kaya,
   Paul Gortmaker).

 - INT3406 thermal driver for display thermal management and ACPI
   backlight support code reorganization related to it (Aaron Lu,
   Arnd Bergmann).

 - Support for exporting the value returned by the _HRV (hardware
   revision) ACPI object via sysfs (Betty Dall).

 - Removal of the EXPERT dependency for ACPI on ARM64 (Mark Brown).

 - Rework of the handling of ACPI _OSI mechanism allowing the
   _OSI("Darwin") support to be overridden from the kernel command
   line among other things (Lv Zheng, Chen Yu).

 - Rework of the ACPI tables override mechanism to prepare it for
   the introduction of overlays support going forward (Lv Zheng,
   Rafael Wysocki).

 - Fixes related to the ECDT support and module-level execution
   of AML (Lv Zheng).

 - ACPI PCI interrupts management update to make it work better on
   ARM64 mostly (Sinan Kaya).

 - ACPI SRAT handling update to make the code process all entires
   in the table order regardless of the entry type (Lukasz Anaczkowski).

 - EFI power off support for full-hardware ACPI platforms that don't
   support ACPI S5 (Chen Yu).

 - Fixes and cleanups related to the ACPI core's sysfs interface
   (Dan Carpenter, Betty Dall).

 - acpi_dev_present() API rework to reduce possible confusion related
   to it (Lukas Wunner).

 - Removal of CLK_IS_ROOT from two ACPI drivers (Stephen Boyd).

Thanks!

---------------

Aaron Lu (4):
      video / backlight: add two APIs for drivers to use
      video / backlight: remove the backlight_device_registered API
      ACPI/video: export acpi_video_get_levels
      Thermal / ACPI / video: add INT3406 thermal driver

Al Stone (1):
      ACPICA: IORT: Add in support for the SMMUv3 subtable

Aleksey Makarov (1):
      ACPICA: Headers: Add new constants for the DBG2 ACPI table

Arnd Bergmann (1):
      ACPI / video: mark acpi_video_get_levels() inline

Betty Dall (3):
      ACPI / device_sysfs: Add sysfs support for _HRV hardware revision
      ACPI / device_sysfs: Change _SUN and _STA show functions error
return to EIO
      ACPI / device_sysfs: Clean up checkpatch errors

Bob Moore (23):
      ACPICA: Headers: Minor update for SPCR ACPI table
      ACPICA: ACPI 6.1: Updates for the HEST ACPI table
      ACPICA: ACPI 6.1: Update NFIT table for additional new fields
      ACPICA: Headers: Update DMAR table for October 2014 I/O spec
      ACPICA: Tables: Update FADT handling
      ACPICA: ACPI 6.1: Add full support for this version of ACPI spec
      ACPICA: iASL/Headers: Fix incorrect definition of FPDT table
      ACPICA: Intepreter: Add object extensions to Concatenate operand
      ACPICA: Interpreter: Update some function headers, no functional change
      ACPICA: iASL: Cleanup/optimization for ToPLD macro support
      ACPICA: Cleanup some invocation indentations, no functional change
      ACPICA: Headers: Update generation of the ACPICA library
      ACPICA: Utilities: Update for strtoul64 merger
      ACPICA: All: const keyword changes across the ACPICA source
      ACPICA: iASL/Disassembler: Improve handling of unresolved methods
      ACPICA: Update version to 20160318
      ACPICA: Refactor evaluate_object to reduce nesting
      ACPICA: ACPI 6.1: Support for new PCCT subtable
      ACPICA: ACPI 6.0: Update _BIX support for new package element
      ACPICA: ACPI 6.0, tools/iasl: Add support for new resource descriptors
      ACPICA: Renamed some #defined flag constants for clarity
      ACPICA: Move all ASCII utilities to a common file
      ACPICA: Update version to 20160422

Chen Yu (2):
      ACPI / PM: Introduce efi poweroff for HW-full platforms without _S5
      ACPI / osi: Fix default _OSI(Darwin) support

Dan Carpenter (1):
      ACPI / sysfs: fix error code in get_status()

Lukas Wunner (3):
      ACPI / utils: Rename acpi_dev_present()
      eeepc-wmi: Use acpi_dev_found()
      acer-wmi: Use acpi_dev_found()

Lukasz Anaczkowski (1):
      ACPI / SRAT: fix SRAT parsing order with both LAPIC and X2APIC present

Lv Zheng (29):
      ACPICA: Linuxize: reduce divergences for 20160212 release
      ACPICA: Linuxize: Remove useless platform headers
      ACPICA: Utilities: Add ACPI_IS_POWER_OF_TWO()
      Utilities: Fix missing parentheses in ACPI_GET_BITS()/ACPI_SET_BITS()
      ACPICA: Hardware: Enhance acpi_hw_validate_register() with
access_width/bit_offset awareness
      ACPICA: Interpreter: Fix wrong conditions for
acpi_ev_install_region_handlers() invocation
      ACPICA: Tables: Fix wrong MLC condition for dynamic table loading
      ACPICA: Events: Fix an issue that _REG association can happen
before namespace is initialized
      ACPICA: Namespace: Reorder \_SB._INI to make sure it is
evaluated before _REG evaluations
      ACPI 2.0 / ECDT: Split EC_FLAGS_HANDLERS_INSTALLED
      ACPI 2.0 / ECDT: Remove early namespace reference from EC
      ACPI 2.0 / ECDT: Enable correct ECDT initialization order
      ACPI 2.0 / AML: Improve module level execution by moving the
If/Else/While execution to per-table basis
      tools/power/acpi: close file only if it is open
      ACPI / tables: Move table override mechanisms to tables.c
      ACPI / x86: Cleanup initrd related code
      ACPI / tables: Convert initrd table override to table upgrade mechanism
      ACPI / osi: Fix an issue that acpi_osi=!* cannot disable ACPICA
internal strings
      ACPI / osi: Cleanup _OSI("Linux") related code before
introducing new support
      ACPI / osi: Add acpi_osi=!! to allow reverting acpi_osi=!
      ACPI / osi: Cleanup OSI handling code to use bool
      ACPI / osi: Cleanup coding style issues before creating a
separate OSI source file
      ACPI / osi: Collect _OSI handling into one single file
      ACPICA: Divergence: remove unwanted spaces for typedef
      ACPICA: Utilities: Add ACPI_IS_ALIGNED() macro
      ACPICA: Hardware: Add optimized access bit width support
      ACPICA: Executer: Introduce a set of macros to handle bit width
mask generation
      ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support
in acpi_hw_read()
      ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support
for acpi_hw_write()

Mark Brown (3):
      ACPI / ARM64: Don't enable ACPI by default on ARM64
      ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
      arm64: defconfig: Enable ACPI

Paul Gortmaker (1):
      ACPI / GED: make evged.c explicitly non-modular

Rafael J. Wysocki (1):
      ACPI / tables: Fix DSDT override mechanism

Sinan Kaya (5):
      ACPI: implement Generic Event Device
      ACPI,PCI,IRQ: reduce resource requirements
      ACPI,PCI,IRQ: reduce static IRQ array size to 16
      ACPI,PCI,IRQ: remove redundant code in acpi_irq_penalty_init()
      ACPI,PCI,IRQ: remove SCI penalize function

Stephen Boyd (2):
      ACPI / APD: Remove CLK_IS_ROOT
      ACPI / amba: Remove CLK_IS_ROOT

Will Miles (1):
      ACPICA: Add support for QNX 6.6 platform

---------------

 Documentation/acpi/initrd_table_override.txt       |  65 ++-
 Documentation/kernel-parameters.txt                |   2 +
 arch/arm64/configs/defconfig                       |   1 +
 arch/x86/kernel/acpi/boot.c                        |   1 -
 arch/x86/kernel/setup.c                            |  12 +-
 arch/x86/pci/acpi.c                                |   1 -
 arch/x86/platform/efi/quirks.c                     |   2 +-
 drivers/acpi/Kconfig                               |  12 +-
 drivers/acpi/Makefile                              |   3 +-
 drivers/acpi/acpi_amba.c                           |   3 +-
 drivers/acpi/acpi_apd.c                            |   3 +-
 drivers/acpi/acpi_video.c                          |  83 ++--
 drivers/acpi/acpica/Makefile                       |   2 +
 drivers/acpi/acpica/acdebug.h                      |  10 +-
 drivers/acpi/acpica/acevents.h                     |   3 +-
 drivers/acpi/acpica/acglobal.h                     |  11 +
 drivers/acpi/acpica/acinterp.h                     |   4 +-
 drivers/acpi/acpica/aclocal.h                      |  62 +--
 drivers/acpi/acpica/acmacros.h                     |  21 +-
 drivers/acpi/acpica/acnamesp.h                     |   5 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |  14 +-
 drivers/acpi/acpica/acresrc.h                      |  12 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 -
 drivers/acpi/acpica/acutils.h                      |  58 ++-
 drivers/acpi/acpica/dbcmds.c                       |   4 +-
 drivers/acpi/acpica/dbconvert.c                    |   8 +-
 drivers/acpi/acpica/dbexec.c                       |   2 +-
 drivers/acpi/acpica/dbinput.c                      |  19 +-
 drivers/acpi/acpica/dbnames.c                      |   4 +-
 drivers/acpi/acpica/dbutils.c                      |   9 +-
 drivers/acpi/acpica/dbxface.c                      |   4 +-
 drivers/acpi/acpica/dscontrol.c                    |   4 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsutils.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   4 +-
 drivers/acpi/acpica/dswload2.c                     |   4 +-
 drivers/acpi/acpica/dswstate.c                     |  10 +-
 drivers/acpi/acpica/evgpe.c                        |   4 +-
 drivers/acpi/acpica/evgpeblk.c                     |   4 +-
 drivers/acpi/acpica/evgpeutil.c                    |   4 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   3 +-
 drivers/acpi/acpica/evregion.c                     |  74 +--
 drivers/acpi/acpica/evrgnini.c                     |   3 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/exconcat.c                     | 439 +++++++++++++++++
 drivers/acpi/acpica/exconfig.c                     |   4 +-
 drivers/acpi/acpica/exconvrt.c                     |   8 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdump.c                       |  15 +-
 drivers/acpi/acpica/exfield.c                      |   4 +-
 drivers/acpi/acpica/exfldio.c                      |  14 +-
 drivers/acpi/acpica/exmisc.c                       | 290 ------------
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   8 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exregion.c                     |   6 +-
 drivers/acpi/acpica/exresnte.c                     |   4 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   4 +-
 drivers/acpi/acpica/exstorob.c                     |   4 +-
 drivers/acpi/acpica/exutils.c                      |  12 +-
 drivers/acpi/acpica/hwgpe.c                        |   6 +-
 drivers/acpi/acpica/hwregs.c                       | 291 ++++++++++--
 drivers/acpi/acpica/hwxface.c                      |  11 +-
 drivers/acpi/acpica/nsaccess.c                     |   7 +-
 drivers/acpi/acpica/nsconvert.c                    |   9 +-
 drivers/acpi/acpica/nsdump.c                       |   9 +-
 drivers/acpi/acpica/nsinit.c                       |  76 ++-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsnames.c                      |   2 +-
 drivers/acpi/acpica/nsobject.c                     |   4 +-
 drivers/acpi/acpica/nsprepkg.c                     |  92 ++++
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   6 +-
 drivers/acpi/acpica/nsutils.c                      |   8 +-
 drivers/acpi/acpica/nsxfeval.c                     | 113 +++--
 drivers/acpi/acpica/nsxfname.c                     |   6 +-
 drivers/acpi/acpica/nsxfobj.c                      |   6 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   4 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rscalc.c                       |  90 ++--
 drivers/acpi/acpica/rscreate.c                     |   2 +-
 drivers/acpi/acpica/rsdump.c                       |  50 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |   9 +-
 drivers/acpi/acpica/rsmisc.c                       |   2 +-
 drivers/acpi/acpica/rsserial.c                     |  21 +-
 drivers/acpi/acpica/rsutils.c                      |  14 +-
 drivers/acpi/acpica/rsxface.c                      |   6 +-
 drivers/acpi/acpica/tbdata.c                       |  15 +-
 drivers/acpi/acpica/tbfadt.c                       |  28 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   6 +-
 drivers/acpi/acpica/tbutils.c                      |  33 +-
 drivers/acpi/acpica/tbxface.c                      |   6 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   8 +-
 drivers/acpi/acpica/utalloc.c                      |   5 +-
 drivers/acpi/acpica/utascii.c                      | 140 ++++++
 drivers/acpi/acpica/utbuffer.c                     |  24 +-
 drivers/acpi/acpica/utcache.c                      |   7 +-
 drivers/acpi/acpica/utcopy.c                       |  16 +-
 drivers/acpi/acpica/utdebug.c                      |  47 +-
 drivers/acpi/acpica/utdecode.c                     |  30 +-
 drivers/acpi/acpica/uteval.c                       |   4 +-
 drivers/acpi/acpica/utglobal.c                     |  48 ++
 drivers/acpi/acpica/utids.c                        |   8 +-
 drivers/acpi/acpica/utmath.c                       |   4 +-
 drivers/acpi/acpica/utmisc.c                       |   2 +-
 drivers/acpi/acpica/utnonansi.c                    |  67 +--
 drivers/acpi/acpica/utobject.c                     |  18 +-
 drivers/acpi/acpica/utosi.c                        |   4 +-
 drivers/acpi/acpica/utownerid.c                    |   6 +-
 drivers/acpi/acpica/utprint.c                      |  19 +-
 drivers/acpi/acpica/utstring.c                     |  71 +--
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utxface.c                      |   4 +-
 drivers/acpi/blacklist.c                           | 196 +-------
 drivers/acpi/bus.c                                 |  39 +-
 drivers/acpi/device_sysfs.c                        |  44 +-
 drivers/acpi/ec.c                                  | 241 +++++-----
 drivers/acpi/evged.c                               | 154 ++++++
 drivers/acpi/internal.h                            |   3 +-
 drivers/acpi/numa.c                                |  16 +-
 drivers/acpi/osi.c                                 | 522 +++++++++++++++++++++
 drivers/acpi/osl.c                                 | 505 +-------------------
 drivers/acpi/pci_link.c                            | 131 +++---
 drivers/acpi/sleep.c                               |   7 +
 drivers/acpi/sysfs.c                               |   7 +-
 drivers/acpi/tables.c                              | 316 ++++++++++++-
 drivers/acpi/utils.c                               |   6 +-
 drivers/acpi/video_detect.c                        |   2 +-
 drivers/platform/x86/acer-wmi.c                    |  16 +-
 drivers/platform/x86/eeepc-wmi.c                   |  24 +-
 drivers/thermal/Kconfig                            |  28 +-
 drivers/thermal/int340x_thermal/Kconfig            |  42 ++
 drivers/thermal/int340x_thermal/Makefile           |   1 +
 drivers/thermal/int340x_thermal/int3406_thermal.c  | 236 ++++++++++
 drivers/video/backlight/backlight.c                |  39 +-
 include/acpi/acpi_bus.h                            |   2 +-
 include/acpi/acpi_drivers.h                        |   1 -
 include/acpi/acpiosxf.h                            |  10 +-
 include/acpi/acpixf.h                              |  25 +-
 include/acpi/acrestyp.h                            |   1 +
 include/acpi/actbl.h                               |   4 +-
 include/acpi/actbl1.h                              |  74 ++-
 include/acpi/actbl2.h                              |  39 +-
 include/acpi/actbl3.h                              |  66 ++-
 include/acpi/actypes.h                             |  48 +-
 include/acpi/platform/acenv.h                      |  44 +-
 include/acpi/platform/acmsvcex.h                   |  54 ---
 include/acpi/platform/acwinex.h                    |  49 --
 include/acpi/video.h                               |  20 +
 include/linux/acpi.h                               |  13 +-
 include/linux/apple-gmux.h                         |   2 +-
 include/linux/backlight.h                          |   3 +-
 sound/pci/hda/thinkpad_helper.c                    |   2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c       |   2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c            |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |  47 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |  24 +-
 tools/power/acpi/tools/acpidbg/acpidbg.c           |   4 +-
 tools/power/acpi/tools/acpidump/Makefile           |   1 +
 tools/power/acpi/tools/acpidump/apdump.c           |  13 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   3 +-
 172 files changed, 3639 insertions(+), 2363 deletions(-)
