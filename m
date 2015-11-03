Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34208 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbKCDq2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 22:46:28 -0500
MIME-Version: 1.0
Date: Tue, 3 Nov 2015 04:46:27 +0100
Message-ID: <CAJZ5v0iRdtu7MYU7NaoYneyO+m9EfR7fcfUAbiTx7Ftv+wmjNg@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI updates for v4.4-rc1, part 1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.4-rc1-1

to receive the first batch of power management and ACPI updates for
v4.4-rc1 with top-most commit 1ab68460b1d0671968b35e04f21efcf1ce051916

 Merge branches 'pm-avs', 'pm-clk' and 'powercap'

on top of commit 32b88194f71d6ae7768a29f87fbba454728273ee

 Linux 4.3-rc7

Quite a new features are included this time.

First off, the Collaborative Processor Performance Control interface
(version 2) defined by ACPI will now be supported on ARM64 along
with a cpufreq frontend for CPU performance scaling.

Second, ACPI gets a new infrastructure for the early probing of
IRQ chips and clock sources (along the lines of the existing
similar mechanism for DT).

Next, the ACPI core and the generic device properties API will
now support a recently introduced hierarchical properties
extension of the _DSD (Device Specific Data) ACPI device
configuration object.  If the ACPI platform firmware uses
that extension to organize device properties in a hierarchical
way, the kernel will automatically handle it and make those
properties available to device drivers via the generic device
properties API.

It also will be possible to build the ACPICA's AML interpreter
debugger into the kernel now and use that to diagnose AML-related
problems more efficiently.  In the future, this should make it
possible to single-step AML execution and do similar things.
Interesting stuff, although somewhat experimental at this point.

Finally, the PM core gets a new mechanism that can be used by
device drivers to distinguish between suspend-to-RAM (based on
platform firmware support) and suspend-to-idle (or other variants
of system suspend the platform firmware is not involved in) and
possibly optimize their device suspend/resume handling accordingly.

In addition to that, some existing features are re-organized
quite substantially.

First, the ACPI-based handling of PCI host bridges on x86 and ia64
is unified and the common code goes into the ACPI core (so as to
reduce code duplication and eliminate non-essential differences
between the two architectures in that area).

Second, the Operating Performance Points (OPP) framework is
reorganized to make the code easier to find and follow.

Next, the cpufreq core's sysfs interface is reorganized to
get rid of the "primary CPU" concept for configurations in
which the same performance scaling settings are shared
between multiple CPUs.

Finally, some interfaces that aren't necessary any more are
dropped from the generic power domains framework.

On top of the above we have some minor extensions, cleanups
and bug fixes in multiple places, as usual.

Specifics:

 - ACPICA update to upstream revision 20150930 (Bob Moore, Lv Zheng).

   The most significant change is to allow the AML debugger to be
   built into the kernel.  On top of that there is an update related
   to the NFIT table (the ACPI persistent memory interface)
   and a few fixes and cleanups.

 - ACPI CPPC2 (Collaborative Processor Performance Control v2)
   support along with a cpufreq frontend (Ashwin Chaugule).

   This can only be enabled on ARM64 at this point.

 - New ACPI infrastructure for the early probing of IRQ chips and
   clock sources (Marc Zyngier).

 - Support for a new hierarchical properties extension of the ACPI
   _DSD (Device Specific Data) device configuration object allowing
   the kernel to handle hierarchical properties (provided by the
   platform firmware this way) automatically and make them available
   to device drivers via the generic device properties interface
   (Rafael Wysocki).

 - Generic device properties API extension to obtain an index of
   certain string value in an array of strings, along the lines of
   of_property_match_string(), but working for all of the supported
   firmware node types, and support for the "dma-names" device
   property based on it (Mika Westerberg).

 - ACPI core fix to parse the MADT (Multiple APIC Description Table)
   entries in the order expected by platform firmware (and mandated
   by the specification) to avoid confusion on systems with more than
   255 logical CPUs (Lukasz Anaczkowski).

 - Consolidation of the ACPI-based handling of PCI host bridges
   on x86 and ia64 (Jiang Liu).

 - ACPI core fixes to ensure that the correct IRQ number is used to
   represent the SCI (System Control Interrupt) in the cases when
   it has been re-mapped (Chen Yu).

 - New ACPI backlight quirk for Lenovo IdeaPad S405 (Hans de Goede).

 - ACPI EC driver fixes (Lv Zheng).

 - Assorted ACPI fixes and cleanups (Dan Carpenter, Insu Yun, Jiri
   Kosina, Rami Rosen, Rasmus Villemoes).

 - New mechanism in the PM core allowing drivers to check if the
   platform firmware is going to be involved in the upcoming system
   suspend or if it has been involved in the suspend the system is
   resuming from at the moment (Rafael Wysocki).

   This should allow drivers to optimize their suspend/resume
   handling in some cases and the changes include a couple of users
   of it (the i8042 input driver, PCI PM).

 - PCI PM fix to prevent runtime-suspended devices with PME enabled
   from being resumed during system suspend even if they aren't
   configured to wake up the system from sleep (Rafael Wysocki).

 - New mechanism to report the number of a wakeup IRQ that woke up
   the system from sleep last time (Alexandra Yates).

 - Removal of unused interfaces from the generic power domains
   framework and fixes related to latency measurements in that
   code (Ulf Hansson, Daniel Lezcano).

 - cpufreq core sysfs interface rework to make it handle CPUs that
   share performance scaling settings (represented by a common
   cpufreq policy object) more symmetrically (Viresh Kumar).

   This should help to simplify the CPU offline/online handling among
   other things.

 - cpufreq core fixes and cleanups (Viresh Kumar).

 - intel_pstate fixes related to the Turbo Activation Ratio (TAR)
   mechanism on client platforms which causes the turbo P-states
   range to vary depending on platform firmware settings (Srinivas
   Pandruvada).

 - intel_pstate sysfs interface fix (Prarit Bhargava).

 - Assorted cpufreq driver (imx, tegra20, powernv, integrator) fixes
   and cleanups (Bai Ping, Bartlomiej Zolnierkiewicz, Shilpasri G
   Bhat, Luis de Bethencourt).

 - cpuidle mvebu driver cleanups (Russell King).

 - OPP (Operating Performance Points) framework code reorganization
   to make it more maintainable (Viresh Kumar).

 - Intel Broxton support for the RAPL (Running Average Power Limits)
   power capping driver (Amy Wiles).

 - Assorted power management code fixes and cleanups (Dan Carpenter,
   Geert Uytterhoeven, Geliang Tang, Luis de Bethencourt, Rasmus
   Villemoes).

Thanks!


PS
Please note that commit

  3722ed2380ad ("clocksource: cosmetic: Drop OF 'dependency' from symbols")

included here will clash with commit

  9821e545c5e0 ("ARM: mediatek: enable gpt6 on boot up to make arch
timer working")

leading to a build failure that may be addressed by the appended patch from
Stephen Rothwell.


---------------

Alexandra Yates (1):
      PM / sleep: Report interrupt that caused system wakeup

Amy Wiles (1):
      powercap / RAPL: Enable Broxton RAPL support

Ashwin Chaugule (6):
      ACPI: Introduce CPU performance controls using CPPC
      ACPI / CPPC: Add a CPUFreq driver for use with CPPC
      ACPI: Add weak routines for ACPI CPU Hotplug
      CPPC: Probe for CPPC tables for each ACPI Processor object
      ACPI: Allow selection of the ACPI processor driver for ARM64
      ACPI / CPPC: Fix potential memory leak

Bai Ping (1):
      cpufreq: imx: update the clock switch flow to support imx6ul

Bartlomiej Zolnierkiewicz (1):
      cpufreq: tegra20: remove superfluous CONFIG_PM ifdefs

Bob Moore (8):
      ACPICA: Remove unnecessary conditional compilation
      ACPICA: iASL: Add symbolic operator support for Index() operator
      ACPICA: Update exception code for "file not found" error
      ACPICA: Debugger: Update mutexes used for multithreaded debugger
      ACPICA: Update NFIT table to rename a flags field
      ACPICA: Improve typechecking, both compile-time and runtime
      ACPICA: iASL: General cleanup of the file suffix #defines
      ACPICA: Update version to 20150930

Chen Yu (3):
      ACPI: Use correct IRQ when uninstalling ACPI interrupt handler
      ACPI: Using correct irq when waiting for events
      ACPI / PM: Fix incorrect wakeup IRQ setting during suspend-to-idle

Dan Carpenter (3):
      PM / OPP: passing NULL to PTR_ERR()
      ACPI / tables: test the correct variable
      ACPI / CPPC: signedness bug in register_pcc_channel()

Daniel Lezcano (1):
      PM / Domains: Remove cpuidle attach

Geert Uytterhoeven (1):
      PM / clk: Fix broken build due to non-matching code and header #ifdefs

Geliang Tang (1):
      PM / hibernate: fix a comment typo

Hans de Goede (1):
      ACPI / video: Add a quirk to force native backlight on Lenovo IdeaPad S405

Insu Yun (1):
      ACPI / sysfs: correctly check failing memory allocation

Jiang Liu (7):
      ACPI/PCI: Enhance ACPI core to support sparse IO space
      ia64/PCI/ACPI: Use common ACPI resource parsing interface for host bridge
      ia64/PCI: Use common struct resource_entry to replace struct
iospace_resource
      PCI/ACPI: Add interface acpi_pci_root_create()
      ACPI/PCI: Reset acpi_root_dev->domain to 0 when pci_ignore_seg is set
      x86/PCI/ACPI: Use common interface to support PCI host bridge
      ia64/PCI/ACPI: Use common interface to support PCI host bridge

Jiri Kosina (1):
      ACPI / PAD: power_saving_thread() is not freezable

Luis de Bethencourt (2):
      cpufreq: integrator: Fix module autoload for OF platform driver
      PM / AVS: rockchip-io: Fix module autoload for OF platform driver

Lukasz Anaczkowski (2):
      ACPI / tables: Add acpi_subtable_proc to ACPI table parsers
      x86, ACPI: Handle apic/x2apic entries in MADT in correct order

Lv Zheng (8):
      ACPI / EC: Fix query handler related issues
      ACPI / EC: Fix a race issue in acpi_ec_guard_event()
      ACPICA: Linuxize: Export debugger files to Linux
      ACPICA: Debugger: Fix "quit/exit" command by cleaning up user
commands termination logic
      ACPICA: Debugger: Fix "terminate" command by cleaning up
subsystem shutdown logic
      ACPICA: Debugger: Add thread ID support so that single step mode
can only apply to the debugger thread
      ACPI: Enable build of AML interpreter debugger
      ACPICA: Debugger: Fix dead lock issue ocurred in single stepping mode

Marc Zyngier (7):
      ACPI: Add early device probing infrastructure
      irqchip / ACPI: Add probing infrastructure for ACPI-based irqchips
      irqchip / GIC: Convert the GIC driver to ACPI probing
      clocksource / ACPI: Add probing infrastructure for ACPI-based clocksources
      clocksource: Add new CLKSRC_{PROBE,ACPI} config symbols
      clocksource / arm_arch_timer: Convert to ACPI probing
      clocksource: cosmetic: Drop OF 'dependency' from symbols

Mika Westerberg (2):
      device property: Add fwnode_property_match_string()
      acpi-dma: Add support for "dma-names" device property

Prarit Bhargava (1):
      cpufreq: intel_pstate: Fix intel_pstate powersave min_perf_pct value

Rafael J. Wysocki (13):
      ACPI / property: Add routine for extraction of _DSD properties
      ACPI / property: Add support for data-only subnodes
      ACPI / property: Expose data-only subnodes via sysfs
      ACPI / property: Extend fwnode_property_* to data-only subnodes
      ACPI / gpio: Split acpi_get_gpiod_by_index()
      ACPI / property: Extend device_get_next_child_node() to data-only nodes
      PM / domains: Drop unused label
      PCI / PM: Avoid resuming more devices during system suspend
      PM / sleep: Drop pm_request_idle() from pm_generic_complete()
      PM / sleep: Add flags to indicate platform firmware involvement
      PM / PCI / ACPI: Kick devices that might have been reset by firmware
      input: i8042: Avoid resetting controller on system suspend/resume
      ACPI / property: Fix subnode lookup scope for data-only subnodes

Rami Rosen (3):
      ACPI: change init_acpi_device_notify() to return void
      ACPI: change acpi_sleep_proc_init() to return void
      ACPI / Documentation: add copy_dsdt to ACPI format options

Rasmus Villemoes (4):
      ACPI / scan: constify first argument of struct acpi_scan_handler::match
      ACPI / scan: constify struct acpi_hardware_id::id
      ACPI / scan: use kstrdup_const() in acpi_add_id()
      PM / wakeup: wakeup_source_create: use kstrdup_const

Russell King (2):
      cpuidle: mvebu: clean up multiple platform drivers
      cpuidle: mvebu: disable the bind/unbind attributes and use
builtin_platform_driver

Shilpasri G Bhat (1):
      cpufreq : powernv: Report Pmax throttling if capped below
nominal frequency

Srinivas Pandruvada (5):
      cpufreq: intel_pstate: get P1 from TAR when available
      cpufreq: intel-pstate: Use separate max pstate for scaling
      cpufreq: intel_pstate: Use ACPI perf configuration
      Documentation: kernel_parameters for Intel P state driver
      cpufreq: intel_pstate: Avoid calculation for max/min

Ulf Hansson (8):
      PM / Domains: Remove name based API for genpd
      PM / Domains: Remove in_progress counter from struct generic_pm_domain
      soc: dove: Let genpd deal with disabling of unused PM domains
      PM / Domains: Remove pm_genpd_poweroff_unused() API
      PM / Domains: Remove pm_genpd_poweron() API
      PM / Domains: Rename *pm_genpd_poweron|poweroff()
      PM / Domains: Don't measure ->start|stop() latency in system PM callbacks
      PM / Domains: Merge measurements for PM QoS device latencies

Viresh Kumar (13):
      PM / OPP: reuse of_parse_phandle()
      PM / OPP: Rename opp init/free table routines
      PM / OPP: Prefix exported opp routines with dev_pm_opp_
      PM / OPP: Move opp core to its own directory
      PM / OPP: Move cpu specific code to opp/cpu.c
      cpufreq: conservative: remove 'enable' field
      cpufreq: Drop redundant check for inactive policies
      cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
      cpufreq: Use cpumask_copy instead of cpumask_or to copy a mask
      cpufreq: create cpu/cpufreq at boot time
      cpufreq: remove cpufreq_sysfs_{create|remove}_file()
      cpufreq: create cpu/cpufreq/policyX directories
      cpufreq: postfix policy directory with the first CPU in related_cpus

---------------

 Documentation/ABI/testing/sysfs-power              |   12 +
 Documentation/kernel-parameters.txt                |    6 +-
 arch/arm/kernel/time.c                             |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |    2 +-
 arch/arm/mach-omap2/timer.c                        |    4 +-
 arch/arm/mach-rockchip/rockchip.c                  |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |    2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |    2 +-
 arch/arm/mach-spear/spear13xx.c                    |    2 +-
 arch/arm/mach-sunxi/sunxi.c                        |    2 +-
 arch/arm/mach-u300/core.c                          |    2 +-
 arch/arm/mach-ux500/timer.c                        |    2 +-
 arch/arm/mach-zynq/common.c                        |    2 +-
 arch/arm64/include/asm/acpi.h                      |    1 -
 arch/arm64/include/asm/irq.h                       |   13 -
 arch/arm64/kernel/acpi.c                           |   25 -
 arch/arm64/kernel/time.c                           |    8 +-
 arch/ia64/include/asm/pci.h                        |    5 -
 arch/ia64/pci/pci.c                                |  368 ++----
 arch/microblaze/kernel/setup.c                     |    2 +-
 arch/mips/pistachio/time.c                         |    2 +-
 arch/mips/ralink/clk.c                             |    2 +-
 arch/nios2/kernel/time.c                           |    2 +-
 arch/x86/include/asm/msr-index.h                   |    7 +
 arch/x86/kernel/acpi/boot.c                        |   22 +-
 arch/x86/pci/acpi.c                                |  296 ++---
 arch/xtensa/kernel/time.c                          |    2 +-
 drivers/acpi/Kconfig                               |   29 +-
 drivers/acpi/Makefile                              |    1 +
 drivers/acpi/acpi_lpss.c                           |    2 +-
 drivers/acpi/acpi_pad.c                            |    2 -
 drivers/acpi/acpi_pnp.c                            |    4 +-
 drivers/acpi/acpi_processor.c                      |   18 +
 drivers/acpi/acpica/Makefile                       |   18 +-
 drivers/acpi/acpica/acapps.h                       |    2 +-
 drivers/acpi/acpica/acdebug.h                      |    6 +
 drivers/acpi/acpica/acglobal.h                     |    7 +-
 drivers/acpi/acpica/acinterp.h                     |    2 -
 drivers/acpi/acpica/aclocal.h                      |   22 +-
 drivers/acpi/acpica/acnamesp.h                     |    4 -
 drivers/acpi/acpica/acopcode.h                     |    4 +-
 drivers/acpi/acpica/acparser.h                     |    4 -
 drivers/acpi/acpica/acutils.h                      |    2 -
 drivers/acpi/acpica/amlcode.h                      |   11 +-
 drivers/acpi/acpica/dbcmds.c                       | 1187 ++++++++++++++++++
 drivers/acpi/acpica/dbconvert.c                    |  484 ++++++++
 drivers/acpi/acpica/dbdisply.c                     | 1108 +++++++++++++++++
 drivers/acpi/acpica/dbexec.c                       |  764 ++++++++++++
 drivers/acpi/acpica/dbfileio.c                     |  256 ++++
 drivers/acpi/acpica/dbhistry.c                     |  239 ++++
 drivers/acpi/acpica/dbinput.c                      | 1267 ++++++++++++++++++++
 drivers/acpi/acpica/dbmethod.c                     |  369 ++++++
 drivers/acpi/acpica/dbnames.c                      |  947 +++++++++++++++
 drivers/acpi/acpica/dbobject.c                     |  533 ++++++++
 drivers/acpi/acpica/dbstats.c                      |  546 +++++++++
 drivers/acpi/acpica/dbtest.c                       | 1057 ++++++++++++++++
 drivers/acpi/acpica/dbutils.c                      |  457 +++++++
 drivers/acpi/acpica/dbxface.c                      |  513 ++++++++
 drivers/acpi/acpica/evxface.c                      |    2 +-
 drivers/acpi/acpica/exconvrt.c                     |    1 +
 drivers/acpi/acpica/exresolv.c                     |    1 -
 drivers/acpi/acpica/exresop.c                      |    2 +
 drivers/acpi/acpica/exstore.c                      |  120 +-
 drivers/acpi/acpica/exstoren.c                     |    5 +-
 drivers/acpi/acpica/nsdump.c                       |    6 -
 drivers/acpi/acpica/nspredef.c                     |    2 +-
 drivers/acpi/acpica/pstree.c                       |    2 -
 drivers/acpi/acpica/psutils.c                      |    2 -
 drivers/acpi/acpica/rsdump.c                       |    3 -
 drivers/acpi/acpica/rsutils.c                      |    2 -
 drivers/acpi/acpica/rsxface.c                      |    4 +-
 drivers/acpi/acpica/utdecode.c                     |   21 +-
 drivers/acpi/acpica/utfileio.c                     |    6 +
 drivers/acpi/acpica/utinit.c                       |   15 +-
 drivers/acpi/acpica/utmutex.c                      |   21 +
 drivers/acpi/acpica/utxface.c                      |   19 +-
 drivers/acpi/cppc_acpi.c                           |  733 +++++++++++
 drivers/acpi/device_pm.c                           |   19 +-
 drivers/acpi/device_sysfs.c                        |  120 +-
 drivers/acpi/ec.c                                  |  115 +-
 drivers/acpi/glue.c                                |    5 +-
 drivers/acpi/internal.h                            |    6 +-
 drivers/acpi/nfit.c                                |    6 +-
 drivers/acpi/nfit.h                                |    2 +-
 drivers/acpi/osl.c                                 |   24 +-
 drivers/acpi/pci_root.c                            |  204 ++++
 drivers/acpi/proc.c                                |    4 +-
 drivers/acpi/processor_driver.c                    |    6 +
 drivers/acpi/property.c                            |  427 +++++--
 drivers/acpi/resource.c                            |    9 +-
 drivers/acpi/scan.c                                |   67 +-
 drivers/acpi/sleep.c                               |    9 +-
 drivers/acpi/sysfs.c                               |    3 +
 drivers/acpi/tables.c                              |   94 +-
 drivers/acpi/video_detect.c                        |    9 +
 drivers/base/power/Makefile                        |    2 +-
 drivers/base/power/clock_ops.c                     |    6 +-
 drivers/base/power/domain.c                        |  368 ++----
 drivers/base/power/domain_governor.c               |    6 +-
 drivers/base/power/generic_ops.c                   |   23 +-
 drivers/base/power/opp/Makefile                    |    2 +
 drivers/base/power/{opp.c => opp/core.c}           |  363 +-----
 drivers/base/power/opp/cpu.c                       |  267 +++++
 drivers/base/power/opp/opp.h                       |  143 +++
 drivers/base/power/wakeup.c                        |   16 +-
 drivers/base/property.c                            |   88 +-
 drivers/clocksource/Kconfig                        |    9 +
 drivers/clocksource/Makefile                       |    2 +-
 drivers/clocksource/arm_arch_timer.c               |   10 +-
 .../clocksource/{clksrc-of.c => clksrc-probe.c}    |    6 +-
 drivers/cpufreq/Kconfig.arm                        |   17 +
 drivers/cpufreq/Kconfig.x86                        |    1 +
 drivers/cpufreq/Makefile                           |    3 +-
 drivers/cpufreq/arm_big_little.h                   |    2 +-
 drivers/cpufreq/arm_big_little_dt.c                |    4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  176 +++
 drivers/cpufreq/cpufreq-dt.c                       |   10 +-
 drivers/cpufreq/cpufreq.c                          |  112 +-
 drivers/cpufreq/cpufreq_conservative.c             |   31 +-
 drivers/cpufreq/cpufreq_governor.c                 |   32 +-
 drivers/cpufreq/cpufreq_governor.h                 |    1 -
 drivers/cpufreq/cpufreq_ondemand.c                 |   10 +-
 drivers/cpufreq/cpufreq_opp.c                      |  114 --
 drivers/cpufreq/exynos5440-cpufreq.c               |    6 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   56 +-
 drivers/cpufreq/integrator-cpufreq.c               |    2 +
 drivers/cpufreq/intel_pstate.c                     |  390 +++++-
 drivers/cpufreq/mt8173-cpufreq.c                   |    6 +-
 drivers/cpufreq/powernv-cpufreq.c                  |   10 +-
 drivers/cpufreq/tegra20-cpufreq.c                  |    2 -
 drivers/cpuidle/cpuidle-mvebu-v7.c                 |   46 +-
 drivers/dma/acpi-dma.c                             |   25 +-
 drivers/gpio/gpiolib-acpi.c                        |  153 ++-
 drivers/gpio/gpiolib.c                             |    3 +-
 drivers/gpio/gpiolib.h                             |   10 +-
 drivers/input/serio/i8042.c                        |   32 +-
 drivers/irqchip/irq-gic.c                          |   69 +-
 drivers/irqchip/irqchip.c                          |    5 +-
 drivers/pci/pci-driver.c                           |    7 +
 drivers/pci/pci.c                                  |   70 +-
 drivers/pci/pci.h                                  |    1 +
 drivers/pnp/pnpacpi/core.c                         |    4 +-
 drivers/power/avs/rockchip-io-domain.c             |    1 +
 drivers/powercap/intel_rapl.c                      |    1 +
 drivers/soc/dove/pmu.c                             |    1 -
 include/acpi/acexcep.h                             |    7 +-
 include/acpi/acpi_bus.h                            |   37 +-
 include/acpi/acpiosxf.h                            |    3 +-
 include/acpi/acpixf.h                              |   14 +-
 include/acpi/actbl1.h                              |    2 +-
 include/acpi/cppc_acpi.h                           |  138 +++
 include/acpi/platform/acenv.h                      |    8 +-
 include/acpi/platform/aclinux.h                    |    7 +-
 include/acpi/platform/aclinuxex.h                  |    5 +
 include/acpi/processor.h                           |   14 +
 include/asm-generic/vmlinux.lds.h                  |   12 +
 include/linux/acpi.h                               |  159 ++-
 include/linux/acpi_irq.h                           |   10 -
 include/linux/clocksource.h                        |   13 +-
 include/linux/cpufreq.h                            |    5 -
 include/linux/fwnode.h                             |    1 +
 include/linux/ioport.h                             |    1 +
 include/linux/irqchip.h                            |   17 +
 include/linux/irqchip/arm-gic-acpi.h               |   31 -
 include/linux/pci-acpi.h                           |   24 +
 include/linux/pm.h                                 |    1 +
 include/linux/pm_domain.h                          |   70 +-
 include/linux/pm_opp.h                             |   24 +-
 include/linux/property.h                           |    4 +
 include/linux/suspend.h                            |   39 +
 kernel/irq/pm.c                                    |    2 +-
 kernel/power/hibernate.c                           |    2 +-
 kernel/power/main.c                                |   17 +
 kernel/power/suspend.c                             |    4 +
 tools/power/acpi/tools/acpidump/apfiles.c          |    2 +-
 175 files changed, 13959 insertions(+), 2196 deletions(-)

---
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 1 Nov 2015 17:52:26 +1100
Subject: [PATCH] ARM: mediatek: fixup for clocksource_of_init API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-mediatek/mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mediatek.c
b/arch/arm/mach-mediatek/mediatek.c
index 19dc738c1abc..c88a47a3dc37 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -40,7 +40,7 @@ static void __init mediatek_timer_init(void)
     }

     of_clk_init(NULL);
-    clocksource_of_init();
+    clocksource_probe();
 };

 static const char * const mediatek_board_dt_compat[] = {
