Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 21 Jan 2018 03:19:07 +0100
Message-ID: <CAJZ5v0gBZ2qQWoC0e26VM-g_Y7BnoML05pcJZPkFW4OcZpfLzA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

This goes early, because I'm attending the LCA next week and I may be
sparsely available and generally time-constrained during the next
several days.

In case you decide to open the 4.16 merge window any time soon, please
pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.16-rc1

with top-most commit ee43730d65155c5b3c3d0531f11daf59f8f42a73

 Merge branches 'pm-opp', 'pm-devfreq', 'pm-avs' and 'pm-tools'

on top of commit a8750ddca918032d6349adbf9a4b6555e7db20da

 Linux 4.15-rc8

to receive power management updates for 4.16-rc1.

This includes some infrastructure changes in the PM core, mostly
related to integration between runtime PM and system-wide suspend
and hibernation, plus some driver changes depending on them and
fixes for issues in that area which have become quite apparent
recently.

Also included are changes making more x86-based systems use the Low
Power Sleep S0 _DSM interface by default, which turned out to be
necessary to handle power button wakeups from suspend-to-idle on
Surface Pro3.

On the cpufreq front we have fixes and cleanups in the core, some
new hardware support, driver updates and the removal of some unused
code from the CPU cooling thermal driver.

Apart from this, the Operating Performance Points (OPP) framework
is prepared to be used with power domains in the future and there
is a usual bunch of assorted fixes and cleanups.

Specifics:

 - Define a PM driver flag allowing drivers to request that their
   devices be left in suspend after system-wide transitions to the
   working state if possible and add support for it to the PCI bus
   type and the ACPI PM domain (Rafael Wysocki).

 - Make the PM core carry out optimizations for devices with driver
   PM flags set in some cases and make a few drivers set those flags
   (Rafael Wysocki).

 - Fix and clean up wrapper routines allowing runtime PM device
   callbacks to be re-used for system-wide PM, change the generic
   power domains (genpd) framework to stop using those routines
   incorrectly and fix up a driver depending on that behavior of
   genpd (Rafael Wysocki, Ulf Hansson, Geert Uytterhoeven).

 - Fix and clean up the PM core's device wakeup framework and
   re-factor system-wide PM core code related to device wakeup
   (Rafael Wysocki, Ulf Hansson, Brian Norris).

 - Make more x86-based systems use the Low Power Sleep S0 _DSM
   interface by default (to fix power button wakeup from
   suspend-to-idle on Surface Pro3) and add a kernel command line
   switch to tell it to ignore the system sleep blacklist in the
   ACPI core (Rafael Wysocki).

 - Fix a race condition related to cpufreq governor module removal
   and clean up the governor management code in the cpufreq core
   (Rafael Wysocki).

 - Drop the unused generic code related to the handling of the static
   power energy usage model in the CPU cooling thermal driver along
   with the corresponding documentation (Viresh Kumar).

 - Add mt2712 support to the Mediatek cpufreq driver (Andrew-sh Cheng).

 - Add a new operating point to the imx6ul and imx6q cpufreq drivers
   and switch the latter to using clk_bulk_get() (Anson Huang, Dong
   Aisheng).

 - Add support for multiple regulators to the TI cpufreq driver along
   with a new DT binding related to that and clean up that driver
   somewhat (Dave Gerlach).

 - Fix a powernv cpufreq driver regression leading to incorrect CPU
   frequency reporting, fix that driver to deal with non-continguous
   P-states correctly and clean it up (Gautham Shenoy, Shilpasri Bhat).

 - Add support for frequency scaling on Armada 37xx SoCs through the
   generic DT cpufreq driver (Gregory CLEMENT).

 - Fix error code paths in the mvebu cpufreq driver (Gregory CLEMENT).

 - Fix a transition delay setting regression in the longhaul cpufreq
   driver (Viresh Kumar).

 - Add Skylake X (server) support to the intel_pstate cpufreq driver
   and clean up that driver somewhat (Srinivas Pandruvada).

 - Clean up the cpufreq statistics collection code (Viresh Kumar).

 - Drop cluster terminology and dependency on physical_package_id
   from the PSCI driver and drop dependency on arm_big_little from
   the SCPI cpufreq driver (Sudeep Holla).

 - Add support for system-wide suspend and resume to the RAPL power
   capping driver and drop a redundant semicolon from it (Zhen Han,
   Luis de Bethencourt).

 - Make SPI domain validation (in the SCSI SPI transport driver) and
   system-wide suspend mutually exclusive as they rely on the same
   underlying mechanism and cannot be carried out at the same time
   (Bart Van Assche).

 - Fix the computation of the amount of memory to preallocate in the
   hibernation core and clean up one function in there (Rainer Fiebig,
   Kyungsik Lee).

 - Prepare the Operating Performance Points (OPP) framework for being
   used with power domains and clean up one function in it (Viresh
   Kumar, Wei Yongjun).

 - Clean up the generic sysfs interface for device PM (Andy Shevchenko).

 - Fix several minor issues in power management frameworks and clean
   them up a bit (Arvind Yadav, Bjorn Andersson, Geert Uytterhoeven,
   Gustavo Silva, Julia Lawall, Luis de Bethencourt, Paul Gortmaker,
   Sergey Senozhatsky, gaurav jindal).

 - Make it easier to disable PM via Kconfig (Mark Brown).

 - Clean up the cpupower and intel_pstate_tracer utilities (Doug
   Smythies, Laura Abbott).

Thanks!


---------------

Andrew-sh Cheng (2):
      cpufreq: mediatek: add mt2712 into compatible list
      cpufreq: mediatek: add mediatek related projects into blacklist

Andy Shevchenko (3):
      PM / sysfs: Convert to use sysfs_streq()
      PM / sysfs: Remove redundant 'else' keyword.
      PM / sysfs: Convert to use DEVICE_ATTR_RO / DEVICE_ATTR_RW

Anson Huang (2):
      ARM: dts: imx6ul: add 696MHz operating point
      cpufreq: imx6q: add 696MHz operating point for i.mx6ul

Arvind Yadav (1):
      powercap: Simplify powercap_init()

Bart Van Assche (2):
      PM / sleep: Make lock/unlock_system_sleep() available to kernel modules
      block, scsi: Fix race between SPI domain validation and system suspend

Bjorn Andersson (1):
      PM / devfreq: Propagate error from devfreq_add_device()

Brian Norris (1):
      PM / wakeup: only recommend "call"ing device_init_wakeup() once

Dave Gerlach (4):
      cpufreq: ti-cpufreq: Convert to module_platform_driver
      cpufreq: ti-cpufreq: Add support for multiple regulators
      dt-bindings: opp: Introduce ti-opp-supply bindings
      PM / OPP: Add ti-opp-supply driver

Dong Aisheng (1):
      cpufreq: imx6q: switch to Use clk_bulk_get() to refine clk operations

Doug Smythies (1):
      tools/power/x86/intel_pstate_tracer: Free the trace buffer memory

Gautham R. Shenoy (3):
      powernv-cpufreq: Add helper to extract pstate from PMSR
      powernv-cpufreq: Fix pstate_to_idx() to handle non-continguous pstates
      powernv-cpufreq: Treat pstates as opaque 8-bit values

Geert Uytterhoeven (2):
      PM / Domains: Remove obsolete "samsung,power-domain" check
      dmaengine: rcar-dmac: Make DMAC reinit during system resume explicit

Gregory CLEMENT (7):
      cpufreq: ARM: sort the Kconfig menu
      cpufreq: sort the drivers in ARM part
      cpufreq: mvebu: Free the clock reference in the normal path
      cpufreq: mvebu: Free opp if registering failed
      dt-bindings: marvell: Add documentation for the North Bridge PM
on Armada 37xx
      MAINTAINERS: add new entries for Armada 37xx cpufreq driver
      cpufreq: Add DVFS support for Armada 37xx

Gustavo A. R. Silva (1):
      PM / devfreq: Fix potential NULL pointer dereference in governor_store

Julia Lawall (1):
      PM / AVS: rockchip-io: account for const type of of_device_id.data

Kyungsik Lee (1):
      PM / hibernate: Drop unused parameter of enough_swap

Laura Abbott (1):
      cpupower: Remove FSF address

Luis de Bethencourt (2):
      powercap: intel_rapl: Fix trailing semicolon
      PCI / PM: Remove spurious semicolon

Mark Brown (1):
      PM: Provide a config snippet for disabling PM

Paul Gortmaker (1):
      bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to tristate

Rafael J. Wysocki (24):
      PM / core: Add LEAVE_SUSPENDED driver flag
      PCI / PM: Support for LEAVE_SUSPENDED driver flag
      ACPI / PM: Support for LEAVE_SUSPENDED driver flag in ACPI PM domain
      ACPI / PM: Make it possible to ignore the system sleep blacklist
      cpufreq: Clean up cpufreq_parse_governor()
      cpufreq: Pass policy pointer to cpufreq_parse_governor()
      cpufreq: Drop pointless return statement
      cpufreq: Fix governor module removal race
      PM / core: Use dev_pm_skip_next_resume_phases() internally
      PM / wakeup: Drop redundant check from device_set_wakeup_enable()
      PM / wakeup: Drop redundant check from device_init_wakeup()
      PM / core: Add helpers for subsystem callback selection
      PM / core: Direct DPM_FLAG_SMART_SUSPEND optimization
      PM / core: Direct DPM_FLAG_LEAVE_SUSPENDED handling
      PM / wakeup: Do not fail dev_pm_attach_wake_irq() unnecessarily
      PCI / PM: Use SMART_SUSPEND and LEAVE_SUSPENDED flags for PCIe ports
      PM / mfd: intel-lpss: Use DPM_FLAG_SMART_SUSPEND
      PM: i2c-designware-platdrv: Use DPM_FLAG_SMART_PREPARE
      PM: i2c-designware-platdrv: Optimize power management
      ACPI / PM: Use Low Power S0 Idle on more systems
      platform/x86: surfacepro3: Support for wakeup from suspend-to-idle
      PM / genpd: Stop/start devices without pm_runtime_force_suspend/resume()
      PM / runtime: Rework pm_runtime_force_suspend/resume()
      PM / runtime: Check ignore_children in pm_runtime_need_not_resume()

Rainer Fiebig (1):
      PM: hibernate: Do not subtract NR_FILE_MAPPED in minimum_image_size()

Sergey Senozhatsky (1):
      PM / core: remove unneeded kallsyms include

Shilpasri G Bhat (1):
      cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Replace bxt_funcs with core_funcs
      cpufreq: intel_pstate: Add Skylake servers support

Sudeep Holla (2):
      drivers: psci: remove cluster terminology and dependency on
physical_package_id
      cpufreq: scpi: remove arm_big_little dependency

Ulf Hansson (8):
      PM / core: Re-factor some code dealing with parents in __device_suspend()
      PM / core: Assign the wakeup_path status flag in __device_prepare()
      PM / wakeup: Add device_set_wakeup_path() helper to control wakeup path
      PM / core: Re-structure code for clearing the direct_complete flag
      PM / core: Propagate wakeup_path status flag in __device_suspend_late()
      PM / domains: Don't skip driver's ->suspend|resume_noirq() callbacks
      PM / wakeup: Print warn if device gets enabled as wakeup source
during sleep
      PM / runtime: Allow no callbacks in pm_runtime_force_suspend|resume()

Viresh Kumar (9):
      cpu_cooling: Make of_cpufreq_power_cooling_register() parse DT
      cpu_cooling: Remove unused cpufreq_power_cooling_register()
      cpu_cooling: Keep only one of_cpufreq*cooling_register() helper
      cpu_cooling: Drop static-power related stuff
      cpufreq: longhaul: Revert transition_delay_us to 200 ms
      OPP: Allow OPP table to be used for power-domains
      OPP: Introduce "required-opp" property
      cpu_cooling: Remove static-power related documentation
      cpufreq: stats: Change return type of cpufreq_stats_update() as void

Wei Yongjun (1):
      PM / OPP: Make local function ti_opp_supply_set_opp() static

Zhen Han (1):
      powercap: add suspend and resume mechanism for SOC power limit

gaurav jindal (1):
      cpuidle: Avoid NULL argument in cpuidle_switch_governor()

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   5 +-
 .../bindings/arm/marvell/armada-37xx.txt           |  19 +
 Documentation/devicetree/bindings/opp/opp.txt      |  13 +
 .../bindings/opp/ti-omap5-opp-supply.txt           |  63 +++
 .../devicetree/bindings/power/power_domain.txt     |  65 ++++
 Documentation/driver-api/pm/devices.rst            |  54 ++-
 Documentation/power/pci.txt                        |  11 +
 Documentation/thermal/cpu-cooling-api.txt          | 115 +-----
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/imx6ul.dtsi                      |   2 +
 arch/x86/kernel/acpi/sleep.c                       |   2 +
 drivers/acpi/device_pm.c                           |  27 +-
 drivers/acpi/sleep.c                               |  16 +-
 drivers/base/power/domain.c                        |  69 ++--
 drivers/base/power/main.c                          | 415 +++++++++++++++-----
 drivers/base/power/power.h                         |  11 +-
 drivers/base/power/runtime.c                       |  84 ++--
 drivers/base/power/sysfs.c                         | 182 ++++-----
 drivers/base/power/wakeirq.c                       |   8 +-
 drivers/base/power/wakeup.c                        |  26 +-
 drivers/bus/Kconfig                                |   2 +-
 drivers/cpufreq/Kconfig.arm                        |  88 +++--
 drivers/cpufreq/Makefile                           |   9 +-
 drivers/cpufreq/arm_big_little.c                   |  23 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              | 241 ++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   8 +
 drivers/cpufreq/cpufreq-dt.c                       |  27 +-
 drivers/cpufreq/cpufreq.c                          |  55 +--
 drivers/cpufreq/cpufreq_stats.c                    |   3 +-
 drivers/cpufreq/imx6q-cpufreq.c                    | 171 +++++----
 drivers/cpufreq/intel_pstate.c                     |  14 +-
 drivers/cpufreq/longhaul.c                         |   2 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |  23 +-
 drivers/cpufreq/mvebu-cpufreq.c                    |  16 +-
 drivers/cpufreq/powernv-cpufreq.c                  | 143 ++++---
 drivers/cpufreq/qoriq-cpufreq.c                    |  14 +-
 drivers/cpufreq/scpi-cpufreq.c                     | 193 +++++++++-
 drivers/cpufreq/ti-cpufreq.c                       |  51 ++-
 drivers/cpuidle/governor.c                         |   5 +-
 drivers/devfreq/devfreq.c                          |   5 +-
 drivers/dma/sh/rcar-dmac.c                         |  24 +-
 drivers/firmware/psci_checker.c                    |  46 ++-
 drivers/i2c/busses/i2c-designware-core.h           |   2 -
 drivers/i2c/busses/i2c-designware-platdrv.c        |  39 +-
 drivers/mfd/intel-lpss.c                           |   6 +-
 drivers/opp/Makefile                               |   1 +
 drivers/opp/ti-opp-supply.c                        | 425 +++++++++++++++++++++
 drivers/pci/pci-driver.c                           |  21 +-
 drivers/pci/pcie/portdrv_pci.c                     |   3 +
 drivers/platform/x86/surfacepro3_button.c          |   4 +-
 drivers/power/avs/rockchip-io-domain.c             |  24 +-
 drivers/powercap/intel_rapl.c                      |  99 ++++-
 drivers/powercap/powercap_sys.c                    |   6 +-
 drivers/scsi/scsi_transport_spi.c                  |  16 +-
 drivers/thermal/cpu_cooling.c                      | 201 ++--------
 include/linux/acpi.h                               |   1 +
 include/linux/cpu_cooling.h                        |  75 +---
 include/linux/pm.h                                 |  16 +-
 include/linux/pm_wakeup.h                          |   7 +
 include/linux/suspend.h                            |  28 +-
 include/trace/events/thermal.h                     |  10 +-
 kernel/configs/nopm.config                         |  15 +
 kernel/power/main.c                                |  29 ++
 kernel/power/snapshot.c                            |   6 +-
 kernel/power/swap.c                                |   4 +-
 tools/power/cpupower/lib/cpufreq.h                 |   4 -
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  15 +
 67 files changed, 2310 insertions(+), 1099 deletions(-)
