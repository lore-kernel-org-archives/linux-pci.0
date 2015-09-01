Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Sep 2015 01:41:11 +0200
Message-ID: <CAJZ5v0j71Zwe8H7Lais82+N97-eF==Yjf4SPnb40kdyBLu2THw@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI updates for v4.3-rc1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.3-rc1

to receive power management and ACPI material for v4.3-rc1 with
top-most commit e625ccec1fa6c24620f38fd72d5b2fd62230ad2b

 Merge branches 'pm-tools' and 'powercap'

on top of commit 64291f7db5bd8150a74ad2036f1037e6a0428df2

 Linux 4.2

>From the number of commits perspective, the biggest items are ACPICA
and cpufreq changes with the latter taking the lead (over 50 commits).

On the cpufreq front, there are many cleanups and minor fixes in the
core and governors, driver updates etc.  We also have a new cpufreq
driver for Mediatek MT8173 chips.

ACPICA mostly updates its debug infrastructure and adds a number
of fixes and cleanups for a good measure.

The Operating Performance Points (OPP) framework is updated
with new DT bindings and support for them among other things.

We have a few updates of the generic power domains framework
and a reorganization of the ACPI device enumeration code
and bus type operations.

And a lot of fixes and cleanups all over.

Included is one branch from the MFD tree as it contains some
PM-related driver core and ACPI PM changes a few other commits
are based on.

Specifics:

 - ACPICA update to upstream revision 20150818 including method
   tracing extensions to allow more in-depth AML debugging in the
   kernel and a number of assorted fixes and cleanups (Bob Moore,
   Lv Zheng, Markus Elfring).

 - ACPI sysfs code updates and a documentation update related to
   AML method tracing (Lv Zheng).

 - ACPI EC driver fix related to serialized evaluations of _Qxx
   methods and ACPI tools updates allowing the EC userspace tool
   to be built from the kernel source (Lv Zheng).

 - ACPI processor driver updates preparing it for future
   introduction of CPPC support and ACPI PCC mailbox driver
   updates (Ashwin Chaugule).

 - ACPI interrupts enumeration fix for a regression related
   to the handling of IRQ attribute conflicts between MADT
   and the ACPI namespace (Jiang Liu).

 - Fixes related to ACPI device PM (Mika Westerberg, Srinidhi Kasagar).

 - ACPI device registration code reorganization to separate the
   sysfs-related code and bus type operations from the rest (Rafael
   J Wysocki).

 - Assorted cleanups in the ACPI core (Jarkko Nikula, Mathias Krause,
   Andy Shevchenko, Rafael J Wysocki, Nicolas Iooss).

 - ACPI cpufreq driver and ia64 cpufreq driver fixes and cleanups
   (Pan Xinhui, Rafael J Wysocki).

 - cpufreq core cleanups on top of the previous changes allowing it
   to preseve its sysfs directories over system suspend/resume (Viresh
   Kumar, Rafael J Wysocki, Sebastian Andrzej Siewior).

 - cpufreq fixes and cleanups related to governors (Viresh Kumar).

 - cpufreq updates (core and the cpufreq-dt driver) related to the
   turbo/boost mode support (Viresh Kumar, Bartlomiej Zolnierkiewicz).

 - New DT bindings for Operating Performance Points (OPP), support
   for them in the OPP framework and in the cpufreq-dt driver plus
   related OPP framework fixes and cleanups (Viresh Kumar).

 - cpufreq powernv driver updates (Shilpasri G Bhat).

 - New cpufreq driver for Mediatek MT8173 (Pi-Cheng Chen).

 - Assorted cpufreq driver (speedstep-lib, sfi, integrator) cleanups
   and fixes (Abhilash Jindal, Andrzej Hajda, Cristian Ardelean).

 - intel_pstate driver updates including Skylake-S support, support
   for enabling HW P-states per CPU and an additional vendor bypass
   list entry (Kristen Carlson Accardi, Chen Yu, Ethan Zhao).

 - cpuidle core fixes related to the handling of coupled idle states
   (Xunlei Pang).

 - intel_idle driver updates including Skylake Client support and
   support for freeze-mode-specific idle states (Len Brown).

 - Driver core updates related to power management (Andy Shevchenko,
   Rafael J Wysocki).

 - Generic power domains framework fixes and cleanups (Jon Hunter,
   Geert Uytterhoeven, Rajendra Nayak, Ulf Hansson).

 - Device PM QoS framework update to allow the latency tolerance
   setting to be exposed to user space via sysfs (Mika Westerberg).

 - devfreq support for PPMUv2 in Exynos5433 and a fix for an incorrect
   exynos-ppmu DT binding (Chanwoo Choi, Javier Martinez Canillas).

 - System sleep support updates (Alan Stern, Len Brown, SungEun Kim).

 - rockchip-io AVS support updates (Heiko Stuebner).

 - PM core clocks support fixup (Colin Ian King).

 - Power capping RAPL driver update including support for Skylake H/S
   and Broadwell-H (Radivoje Jovanovic, Seiichi Ikarashi).

 - Generic device properties framework fixes related to the handling
   of static (driver-provided) property sets (Andy Shevchenko).

 - turbostat and cpupower updates (Len Brown, Shilpasri G Bhat,
   Shreyas B Prabhu).

Thanks!


---------------

Abhilash Jindal (1):
      cpufreq: speedstep-lib: Use monotonic clock

Alan Stern (1):
      PM / sleep: Allow devices without runtime PM to do direct-complete

Andrzej Hajda (1):
      cpufreq: sfi: use kmemdup rather than duplicating its implementation

Andy Shevchenko (10):
      klist: implement klist_prev()
      driver core: implement device_for_each_child_reverse()
      mfd: make mfd_remove_devices() iterate in reverse order
      dmaengine: add a driver for Intel integrated DMA 64-bit
      mfd: Add support for Intel Sunrisepoint LPSS devices
      device property: fix potential NULL pointer dereference
      ACPI / osl: replace custom implementation of readq / writeq
      device property: fallback to pset when gettng one string
      device property: attach 'else if' to the proper 'if'
      device property: check fwnode type in to_of_node()

Ashwin Chaugule (4):
      PCC: Initialize PCC Mailbox earlier at boot
      ACPI: Split out ACPI PSS from ACPI Processor driver
      ACPI: Decouple ACPI idle and ACPI processor drivers
      PCC: Disable compilation by default

Bartlomiej Zolnierkiewicz (3):
      PM / OPP: add dev_pm_opp_is_turbo() helper
      cpufreq: Update boost flag while initializing freq table from OPPs
      cpufreq-dt: make scaling_boost_freqs sysfs attr available when
boost is enabled

Bob Moore (20):
      ACPICA: iASL: Add new warnings for method local_x and arg_x variables
      ACPICA: Cleanup use of all non-ANSI local C library functions
      ACPICA: Cleanup use of NEGATIVE and POSITIVE defines
      ACPICA: iASL: Add support for TCPA Server Table
      ACPICA: iASL/Disassembler: Add prototype verbose mode
      ACPICA: Update version to 20150717
      ACPICA: Correctly cleanup after a ACPI table load failure
      ACPICA: Disassembler: Remove duplicate code in _PLD processing.
      ACPICA: Update parameter validation for data_table_region and load_table
      ACPICA: Disassembler: Update for new listing mode
      ACPICA: Update info messages during ACPICA init
      ACPICA: Headers: Fix some comments, no functional change
      ACPICA: acpinames: Add new options and wildcard support
      ACPICA: acpiexec/acpinames: Support very large number of ACPI tables
      ACPICA: Table handling: Cleanup and update debug output for tools
      ACPICA: Add additional debug info/statements
      ACPICA: Debugger: Add option to display namespace summary/counts
      ACPICA: Make the max-number-of-loops runtime configurable
      ACPICA: Header support to improve compatibility with MSVC
      ACPICA: Update version to 20150818

Chanwoo Choi (2):
      PM / devfreq: exynos-ppmu: Add the support of PPMUv2 for Exynos5433
      PM / devfreq: exynos-ppmu: Update documentation to support PPMUv2

Chen Yu (1):
      intel_pstate: Fix possible overflow complained by Coverity

Colin Ian King (1):
      PM / clk: don't return int on __pm_clk_enable()

Cristian Ardelean (1):
      cpufreq: integrator: fixed coding style issues

Ethan Zhao (1):
      intel_pstate: append more Oracle OEM table id to vendor bypass list

Geert Uytterhoeven (3):
      PM / Domains: Correct unit address in power-controller example
      PM / domains: Align column headers and data in pm_genpd_summary output
      PM / Domains: Remove unusable governor dummies

Heiko Stuebner (2):
      PM / AVS: rockchip-io: depend on CONFIG_POWER_AVS
      PM / AVS: rockchip-io: add io selectors and supplies for rk3368

Jarkko Nikula (1):
      ACPI: Remove FSF mailing addresses

Javier Martinez Canillas (1):
      PM / devfreq: event: Remove incorrect property in exynos-ppmu DT binding

Jiang Liu (1):
      ACPI, PCI: Penalize legacy IRQ used by ACPI SCI

Jon Hunter (2):
      PM / Domains: Return -EPROBE_DEFER if we fail to init or turn-on domain
      PM / Domains: Fix typo in description of genpd_dev_pm_detach()

Kristen Carlson Accardi (2):
      intel_pstate: enable HWP per CPU
      intel_pstate: Add SKY-S support

Len Brown (8):
      tools/power turbostat: update turbostat(8)
      tools/power turbostat: cpu0 is no longer hard-coded, so  update output
      tools/power turbostat: dump CONFIG_TDP
      tools/power turbostat: fix parameter passing for forked command
      tools/power turbostat: fix typo on DRAM column in Joules-mode
      intel_idle: allow idle states to be freeze-mode specific
      PM / suspend: make sync() on suspend-to-RAM build-time optional
      intel_idle: Skylake Client Support

Lv Zheng (28):
      ACPICA: Parser: Reduce parser/namespace divergences for tracer support
      ACPICA: Parser: Cleanup aml_offset in struct acpi_walk_state
      ACPICA: Parser: Cleanup aml_offset in union acpi_operand_object
      ACPICA: Dispatcher: Cleanup union acpi_operand_object's AML
address assignments
      ACPICA: Executer: Add back pointing reference of method operand
      ACPICA: Namespace: Add function to directly return normalized full path
      ACPICA: Dispatcher: Move stack traversal code to dispatcher
      ACPICA: Dispatcher: Add trace support for interpreter
      ACPICA: Executer: Add interpreter tracing mode for method tracing facility
      ACPICA: Executer: Add OSL trace hook support
      ACPICA: Executer: Add option to bypass opcode tracing
      ACPICA: Parser: Remove redundant opcode execution debugging output
      ACPICA: MSVC: Fix inclusion order issue of <crtdbg.h>
      ACPICA: Debugger: Reduce structure size for debugger
      ACPICA: Debugger: Move debugger specific APIs to debugger component
      tools/power/acpi: Add descend support in ACPI tools Makefile
      tools/power/acpi: Enable build for EC userspace tool
      ACPI / sysfs: Add ACPI_LV_REPAIR debug level.
      ACPI / sysfs: Update method tracing facility.
      ACPI / sysfs: Add support to allow leading "\" missing in
trace_method_name.
      ACPI / Documentation: Update method tracing documentation.
      ACPI / EC: Fix an issue caused by the serialized _Qxx evaluations
      ACPICA: Tables: Fix global table list issues by removing fixed
table indexes
      ACPICA: Tables: Cleanup to reduce FACS globals
      ACPICA: Debugger: Split debugger initialization/termination APIs
      ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_disasm
      ACPICA: Disassembler: Cleanup acpi_gbl_db_opt_verbose acpiexec usage
      ACPICA: Debugger: Cleanup debugging outputs to dump name path
without trailing underscores

Markus Elfring (1):
      ACPICA: Remove extraneous check for null walk_state

Mathias Krause (1):
      ACPI / processor: remove leftover __refdata annotations

Mika Westerberg (2):
      PM / QoS: Make it possible to expose device latency tolerance to userspace
      ACPI / PM: Attach ACPI power domain only once

Nicolas Iooss (1):
      ACPI: fix acpi_debugfs_init prototype

Pan Xinhui (5):
      acpi-cpufreq: replace per_cpu with driver_data of policy
      acpi-cpufreq: Fix an ACPI perf unregister issue
      cpufreq: ia64: remove redundant freq_table of acpi_cpufreq_data
      cpufreq: ia64: Fix a memory leak in acpi_cpufreq_cpu_exit()
      cpufreq: Correct a freq check in cpufreq_set_policy()

Pi-Cheng Chen (2):
      dt-bindings: mediatek: Add MT8173 CPU DVFS clock bindings
      cpufreq: mediatek: Add MT8173 cpufreq driver

Radivoje Jovanovic (2):
      powercap / RAPL: Add support for Skylake H/S
      powercap / RAPL: Add support for Broadwell-H

Rafael J. Wysocki (19):
      ACPI / PM: Update the copyright notice and description of power.c
      ACPI / scan: Move sysfs-related device code to a separate file
      ACPI / scan: Move device matching code to bus.c
      ACPI / scan: Move bus operations and notification routines to bus.c
      ACPI / bus: Move ACPI bus type registration
      ACPI / processor: Drop an unused argument of a cleanup routine
      cpufreq: acpi-cpufreq: Drop acpi_data from struct acpi_cpufreq_data
      cpufreq: acpi-cpufreq: Fix up the handling of cpb sysfs attribute
      Driver core: wakeup the parent device before trying probe
      cpufreq: Rework two functions related to CPU offline
      cpufreq: Drop cpufreq_policy_restore()
      cpufreq: Drop unnecessary label from cpufreq_add_dev()
      cpufreq: Drop unused dev argument from two functions
      cpufreq: Do not update related_cpus on every policy activation
      cpufreq: Pass CPU number to cpufreq_policy_alloc()
      cpufreq: Separate CPU device registration from CPU online
      cpufreq: Replace recover_policy with new_policy in cpufreq_online()
      cpufreq: Lock CPU online/offline in cpufreq_register_driver()
      ACPI / bus: Move duplicate code to a separate new function

Rajendra Nayak (1):
      PM / Domains: Make pm_genpd_init() available to modules

Sebastian Andrzej Siewior (1):
      cpufreq: Remove cpufreq_rwsem

Seiichi Ikarashi (1):
      powercap / RAPL: disable the 2nd power limit properly

Shilpasri G Bhat (8):
      cpupower: Do not change the frequency of offline cpu
      cpufreq: powernv: Handle throttling due to Pmax capping at chip level
      powerpc/powernv: Add definition of OPAL_MSG_OCC message type
      cpufreq: powernv: Register for OCC related opal_message notification
      cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
      cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is set
      cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling
      cpufreq: powernv: Increase the verbosity of OCC console messages

Shreyas B. Prabhu (1):
      tools: cpupower: Fix error when running cpupower monitor

Srinidhi Kasagar (1):
      ACPI / LPSS: Ignore 10ms delay for Braswell

SungEun Kim (1):
      PM / autosleep: Use workqueue for user space wakeup sources
garbage collector

Ulf Hansson (1):
      PM / Domains: Remove intermediate states from the power off sequence

Viresh Kumar (36):
      cpufreq: cpufreq_add_dev: name goto labels based on what they do
      cpufreq: Properly handle errors from cpufreq_init_policy()
      cpufreq: governor: Name delayed-work as dwork
      cpufreq: governor: Drop unused field 'cpu'
      cpufreq: governor: Rename 'cpu_dbs_common_info' to 'cpu_dbs_info'
      cpufreq: governor: name pointer to cpu_dbs_info as 'cdbs'
      cpufreq: governor: rename cur_policy as policy
      cpufreq: governor: Keep single copy of information common to policy->cpus
      cpufreq: governor: split out common part of {cs|od}_dbs_timer()
      cpufreq: governor: Avoid invalid states with additional checks
      cpufreq: governor: Don't WARN on invalid states
      cpufreq: propagate errors returned from __cpufreq_governor()
      PM / OPP: Update bindings to make opp-hz a 64 bit value
      PM / OPP: Create a directory for opp bindings
      PM / OPP: Relocate few routines
      PM / OPP: Create _remove_device_opp() for freeing dev_opp
      PM / OPP: Allocate dev_opp from _add_device_opp()
      PM / OPP: Break _opp_add_dynamic() into smaller functions
      PM / OPP: Add support to parse "operating-points-v2" bindings
      PM / OPP: Add clock-latency-ns support
      PM / OPP: Add OPP sharing information to OPP library
      PM / OPP: Add support for opp-suspend
      PM / OPP: Add helpers for initializing CPU OPPs
      cpufreq: Allow drivers to enable boost support after registering driver
      cpufreq: dt: Add support for operating-points-v2 bindings
      cpufreq: dt: Add support for turbo/boost mode
      PM / OPP: Free resources and properly return error on failure
      PM / OPP: Fix static checker warning (broken 64bit big endian systems)
      PM / OPP: Drop unlikely before IS_ERR(_OR_NULL)
      cpufreq: remove redundant CPUFREQ_INCOMPATIBLE notifier event
      cpufreq: use memcpy() to copy policy
      cpufreq: update user_policy.* on success
      cpufreq: remove redundant 'governor' field from user_policy
      cpufreq: remove redundant 'policy' field from user_policy
      cpufreq: rename cpufreq_real_policy as cpufreq_user_policy
      cpufreq: drop !cpufreq_driver check from cpufreq_parse_governor()

Xunlei Pang (2):
      cpuidle/coupled: Remove cpuidle_device::safe_state_index
      cpuidle/coupled: Remove redundant 'dev' argument of
cpuidle_state_is_coupled()

---------------

 Documentation/acpi/method-tracing.txt              |  204 +++-
 Documentation/cpu-freq/core.txt                    |    7 +-
 .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  |   83 ++
 .../bindings/devfreq/event/exynos-ppmu.txt         |   43 +-
 .../devicetree/bindings/{power => opp}/opp.txt     |   40 +-
 .../devicetree/bindings/power/power_domain.txt     |    2 +-
 .../bindings/power/rockchip-io-domain.txt          |   14 +
 Documentation/power/devices.txt                    |    7 +
 Documentation/power/runtime_pm.txt                 |    4 -
 arch/powerpc/include/asm/opal-api.h                |   12 +
 arch/x86/include/asm/msr-index.h                   |    6 +
 arch/x86/kernel/acpi/boot.c                        |    1 +
 drivers/acpi/Kconfig                               |   19 +-
 drivers/acpi/Makefile                              |    8 +-
 drivers/acpi/ac.c                                  |    4 -
 drivers/acpi/acpi_ipmi.c                           |    4 -
 drivers/acpi/acpi_lpss.c                           |   38 +-
 drivers/acpi/acpi_memhotplug.c                     |    5 -
 drivers/acpi/acpi_pad.c                            |    4 -
 drivers/acpi/acpi_processor.c                      |    2 +-
 drivers/acpi/acpi_video.c                          |    4 -
 drivers/acpi/acpica/Makefile                       |    2 +
 drivers/acpi/acpica/acdebug.h                      |   26 +-
 drivers/acpi/acpica/acdispat.h                     |    8 +
 drivers/acpi/acpica/acglobal.h                     |   20 +-
 drivers/acpi/acpica/acinterp.h                     |   22 +
 drivers/acpi/acpica/aclocal.h                      |   28 +-
 drivers/acpi/acpica/acmacros.h                     |    9 +
 drivers/acpi/acpica/acnamesp.h                     |   13 +-
 drivers/acpi/acpica/acobject.h                     |    1 +
 drivers/acpi/acpica/acparser.h                     |    4 +-
 drivers/acpi/acpica/acstruct.h                     |    2 +-
 drivers/acpi/acpica/actables.h                     |   14 +-
 drivers/acpi/acpica/acutils.h                      |   25 +-
 drivers/acpi/acpica/dsargs.c                       |    4 +-
 drivers/acpi/acpica/dscontrol.c                    |    2 +-
 drivers/acpi/acpica/dsdebug.c                      |  231 +++++
 drivers/acpi/acpica/dsinit.c                       |   20 +-
 drivers/acpi/acpica/dsmethod.c                     |   35 +-
 drivers/acpi/acpica/dsopcode.c                     |   31 +-
 drivers/acpi/acpica/dswload.c                      |    2 +-
 drivers/acpi/acpica/dswload2.c                     |    2 +-
 drivers/acpi/acpica/evregion.c                     |   22 +-
 drivers/acpi/acpica/exconfig.c                     |    8 -
 drivers/acpi/acpica/excreate.c                     |    1 +
 drivers/acpi/acpica/exdebug.c                      |  324 ++++++
 drivers/acpi/acpica/exdump.c                       |    5 +-
 drivers/acpi/acpica/exresnte.c                     |    2 +-
 drivers/acpi/acpica/exresolv.c                     |   16 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   15 +-
 drivers/acpi/acpica/nseval.c                       |    4 +-
 drivers/acpi/acpica/nsload.c                       |   16 +-
 drivers/acpi/acpica/nsnames.c                      |  275 ++---
 drivers/acpi/acpica/nsparse.c                      |   42 +-
 drivers/acpi/acpica/nsutils.c                      |   19 +-
 drivers/acpi/acpica/nsxfname.c                     |    8 +-
 drivers/acpi/acpica/psargs.c                       |   26 +-
 drivers/acpi/acpica/psloop.c                       |   32 +-
 drivers/acpi/acpica/psobject.c                     |   17 +-
 drivers/acpi/acpica/psparse.c                      |   14 +-
 drivers/acpi/acpica/psutils.c                      |    8 +-
 drivers/acpi/acpica/psxface.c                      |  123 +--
 drivers/acpi/acpica/rscreate.c                     |    3 +-
 drivers/acpi/acpica/tbfadt.c                       |    6 +-
 drivers/acpi/acpica/tbfind.c                       |   15 +-
 drivers/acpi/acpica/tbinstal.c                     |   40 +-
 drivers/acpi/acpica/tbutils.c                      |   73 +-
 drivers/acpi/acpica/tbxfload.c                     |   93 +-
 drivers/acpi/acpica/utdebug.c                      |   31 +-
 drivers/acpi/acpica/utdelete.c                     |    3 +
 drivers/acpi/acpica/utfileio.c                     |    2 +-
 drivers/acpi/acpica/utinit.c                       |    3 +-
 drivers/acpi/acpica/utmisc.c                       |    4 +-
 drivers/acpi/acpica/utnonansi.c                    |  380 +++++++
 drivers/acpi/acpica/utstring.c                     |  342 ------
 drivers/acpi/acpica/utxface.c                      |   12 +-
 drivers/acpi/acpica/utxfinit.c                     |   11 -
 drivers/acpi/apei/apei-base.c                      |    4 -
 drivers/acpi/apei/einj.c                           |    4 -
 drivers/acpi/apei/erst-dbg.c                       |    4 -
 drivers/acpi/apei/erst.c                           |    4 -
 drivers/acpi/apei/ghes.c                           |    4 -
 drivers/acpi/apei/hest.c                           |    4 -
 drivers/acpi/battery.c                             |    4 -
 drivers/acpi/blacklist.c                           |    4 -
 drivers/acpi/bus.c                                 |  408 +++++++-
 drivers/acpi/button.c                              |    4 -
 drivers/acpi/cm_sbs.c                              |    4 -
 drivers/acpi/container.c                           |    4 -
 drivers/acpi/debugfs.c                             |    2 +
 drivers/acpi/device_pm.c                           |   12 +-
 drivers/acpi/device_sysfs.c                        |  521 ++++++++++
 drivers/acpi/dock.c                                |    4 -
 drivers/acpi/ec.c                                  |   86 +-
 drivers/acpi/fan.c                                 |    4 -
 drivers/acpi/hed.c                                 |    4 -
 drivers/acpi/internal.h                            |   16 +-
 drivers/acpi/numa.c                                |    4 -
 drivers/acpi/osl.c                                 |   45 +-
 drivers/acpi/pci_irq.c                             |    4 -
 drivers/acpi/pci_link.c                            |   20 +-
 drivers/acpi/pci_root.c                            |    4 -
 drivers/acpi/pci_slot.c                            |    4 -
 drivers/acpi/power.c                               |   19 +-
 drivers/acpi/processor_driver.c                    |   92 +-
 drivers/acpi/processor_idle.c                      |    4 -
 drivers/acpi/processor_perflib.c                   |   10 +-
 drivers/acpi/processor_thermal.c                   |    4 -
 drivers/acpi/processor_throttling.c                |    4 -
 drivers/acpi/property.c                            |    5 +-
 drivers/acpi/resource.c                            |    4 -
 drivers/acpi/sbs.c                                 |    4 -
 drivers/acpi/scan.c                                |  860 ---------------
 drivers/acpi/sysfs.c                               |  133 ++-
 drivers/acpi/tables.c                              |    4 -
 drivers/acpi/thermal.c                             |    4 -
 drivers/acpi/utils.c                               |    4 -
 drivers/base/core.c                                |   43 +
 drivers/base/dd.c                                  |   20 +
 drivers/base/power/clock_ops.c                     |    4 +-
 drivers/base/power/domain.c                        |  386 ++-----
 drivers/base/power/main.c                          |    2 +-
 drivers/base/power/opp.c                           | 1095 ++++++++++++++++----
 drivers/base/power/power.h                         |    2 +
 drivers/base/power/qos.c                           |   37 +
 drivers/base/power/sysfs.c                         |   11 +
 drivers/base/property.c                            |    8 +-
 drivers/cpufreq/Kconfig.arm                        |    7 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/acpi-cpufreq.c                     |   93 +-
 drivers/cpufreq/cpufreq-dt.c                       |   73 +-
 drivers/cpufreq/cpufreq.c                          |  419 ++++----
 drivers/cpufreq/cpufreq_conservative.c             |   25 +-
 drivers/cpufreq/cpufreq_governor.c                 |  196 +++-
 drivers/cpufreq/cpufreq_governor.h                 |   40 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |   67 +-
 drivers/cpufreq/cpufreq_opp.c                      |    4 +
 drivers/cpufreq/e_powersaver.c                     |    2 +-
 drivers/cpufreq/freq_table.c                       |   15 +
 drivers/cpufreq/ia64-acpi-cpufreq.c                |   20 +-
 drivers/cpufreq/integrator-cpufreq.c               |   18 +-
 drivers/cpufreq/intel_pstate.c                     |   20 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |  527 ++++++++++
 drivers/cpufreq/powernow-k7.c                      |    4 +-
 drivers/cpufreq/powernow-k8.c                      |    5 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  199 +++-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c              |    4 +-
 drivers/cpufreq/sfi-cpufreq.c                      |    4 +-
 drivers/cpufreq/speedstep-lib.c                    |    9 +-
 drivers/cpuidle/coupled.c                          |    8 +-
 drivers/cpuidle/cpuidle.c                          |    4 +-
 drivers/cpuidle/cpuidle.h                          |    7 +-
 drivers/devfreq/event/exynos-ppmu.c                |  170 ++-
 drivers/devfreq/event/exynos-ppmu.h                |   70 ++
 drivers/dma/Kconfig                                |    8 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/idma64.c                               |  710 +++++++++++++
 drivers/dma/idma64.h                               |  233 +++++
 drivers/idle/intel_idle.c                          |   72 +-
 drivers/mailbox/Kconfig                            |    1 +
 drivers/mailbox/pcc.c                              |    8 +-
 drivers/mfd/Kconfig                                |   23 +
 drivers/mfd/Makefile                               |    3 +
 drivers/mfd/intel-lpss-acpi.c                      |   84 ++
 drivers/mfd/intel-lpss-pci.c                       |  113 ++
 drivers/mfd/intel-lpss.c                           |  524 ++++++++++
 drivers/mfd/intel-lpss.h                           |   62 ++
 drivers/mfd/mfd-core.c                             |    2 +-
 drivers/power/avs/Kconfig                          |    2 +-
 drivers/power/avs/rockchip-io-domain.c             |   59 ++
 drivers/powercap/intel_rapl.c                      |    8 +-
 drivers/video/fbdev/pxafb.c                        |    1 -
 drivers/video/fbdev/sa1100fb.c                     |    1 -
 drivers/xen/xen-acpi-processor.c                   |   16 +-
 include/acpi/acbuffer.h                            |    1 +
 include/acpi/acconfig.h                            |    4 -
 include/acpi/acexcep.h                             |    7 +-
 include/acpi/acoutput.h                            |   21 +-
 include/acpi/acpi_bus.h                            |    4 -
 include/acpi/acpi_drivers.h                        |    4 -
 include/acpi/acpiosxf.h                            |    6 +
 include/acpi/acpixf.h                              |   16 +-
 include/acpi/actbl2.h                              |   17 +-
 include/acpi/actypes.h                             |   13 +-
 include/acpi/platform/acenv.h                      |   19 +-
 include/acpi/platform/acenvex.h                    |    3 +
 include/acpi/platform/acmsvcex.h                   |   54 +
 include/acpi/platform/acwinex.h                    |   49 +
 include/acpi/processor.h                           |   59 +-
 include/linux/acpi.h                               |    6 +-
 include/linux/cpufreq.h                            |   28 +-
 include/linux/cpuidle.h                            |    1 -
 include/linux/device.h                             |    2 +
 include/linux/klist.h                              |    1 +
 include/linux/of.h                                 |    3 +-
 include/linux/pm_domain.h                          |    9 -
 include/linux/pm_opp.h                             |   36 +
 include/linux/pm_qos.h                             |    5 +
 include/linux/pm_runtime.h                         |    6 -
 kernel/power/Kconfig                               |   10 +
 kernel/power/suspend.c                             |    2 +
 kernel/power/wakelock.c                            |   18 +-
 lib/klist.c                                        |   41 +
 tools/power/acpi/Makefile                          |  168 +--
 tools/power/acpi/Makefile.config                   |   92 ++
 tools/power/acpi/Makefile.rules                    |   37 +
 tools/power/acpi/tools/acpidump/Makefile           |   53 +
 tools/power/acpi/tools/ec/Makefile                 |   33 +-
 tools/power/cpupower/utils/cpufreq-set.c           |    4 +
 tools/power/cpupower/utils/helpers/topology.c      |    2 +
 tools/power/x86/turbostat/turbostat.8              |    5 -
 tools/power/x86/turbostat/turbostat.c              |  100 +-
 212 files changed, 8448 insertions(+), 3381 deletions(-)
