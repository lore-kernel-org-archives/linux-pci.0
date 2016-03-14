Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Mar 2016 00:39:12 +0100
Message-ID: <CAJZ5v0i6nK2FNPiQhSgvF0E-EveE8mtAemST_ijjHt8rfWPZ-A@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI material for v4.6-rc1, part 1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.5-rc6-1

to receive the first batch of power management and ACPI updates for
v4.6-rc1 with top-most commit 0d571b62dd8eb341788599259c3dbc92c0dc8f22

 Merge branch 'pm-tools'

on top of commit b562e44f507e863c6792946e4e1b1449fbbac85d

 Linux 4.5

This time the majority of changes go into cpufreq and they are
significant.

First off, the way CPU frequency updates are triggered is different
now.  Instead of having to set up and manage a deferrable timer for
each CPU in the system to evaluate and possibly change its frequency
periodically, cpufreq governors set up callbacks to be invoked by the
scheduler on a regular basis (basically on utilization updates).  The
"old" governors, "ondemand" and "conservative", still do all of their
work in process context (although that is triggered by the scheduler
now), but intel_pstate does it all in the callback invoked by the
scheduler with no need for any additional asynchronous processing.

Of course, this eliminates the overhead related to the management
of all those timers, but also it allows the cpufreq governor code to
be simplified quite a bit.  On top of that, the common code and
data structures used by the "ondemand" and "conservative" governors
are cleaned up and made more straightforward and some long-standing
and quite annoying problems are addressed.  In particular, the
handling of governor sysfs attributes is modified and the related
locking becomes more fine grained which allows some concurrency
problems to be avoided (particularly deadlocks with the core cpufreq
code).

In principle, the new mechanism for triggering frequency updates
allows utilization information to be passed from the scheduler to
cpufreq.  Although the current code doesn't make use of it, in the
works is a new cpufreq governor that will make decisions based on the
scheduler's utilization data.  That should allow the scheduler and
cpufreq to work more closely together in the long run.

In addition to the core and governor changes, cpufreq drivers are
updated too.  Fixes and optimizations go into intel_pstate, the
cpufreq-dt driver is updated on top of some modification in the
Operating Performance Points (OPP) framework and there are fixes
and other updates in the powernv cpufreq driver.

Apart from the cpufreq updates there is some new ACPICA material,
including a fix for a problem introduced by previous ACPICA updates,
and some less significant changes in the ACPI code, like CPPC code
optimizations, ACPI processor driver cleanups and support for
loading ACPI tables from initrd.

Also updated are the generic power domains framework, the Intel
RAPL power capping driver and the turbostat utility and we have a
bunch of traditional assorted fixes and cleanups.

Specifics:

 - Redesign of cpufreq governors and the intel_pstate driver to
   make them use callbacks invoked by the scheduler to trigger CPU
   frequency evaluation instead of using per-CPU deferrable timers
   for that purpose (Rafael Wysocki).

 - Reorganization and cleanup of cpufreq governor code to make it
   more straightforward and fix some concurrency problems in it
   (Rafael Wysocki, Viresh Kumar).

 - Cleanup and improvements of locking in the cpufreq core (Viresh
   Kumar).

 - Assorted cleanups in the cpufreq core (Rafael Wysocki, Viresh
   Kumar, Eric Biggers).

 - intel_pstate driver updates including fixes, optimizations and a
   modification to make it enable enable hardware-coordinated P-state
   selection (HWP) by default if supported by the processor (Philippe
   Longepe, Srinivas Pandruvada, Rafael Wysocki, Viresh Kumar, Felipe
   Franciosi).

 - Operating Performance Points (OPP) framework updates to improve
   its handling of voltage regulators and device clocks and updates
   of the cpufreq-dt driver on top of that (Viresh Kumar, Jon Hunter).

 - Updates of the powernv cpufreq driver to fix initialization
   and cleanup problems in it and correct its worker thread handling
   with respect to CPU offline, new powernv_throttle tracepoint
   (Shilpasri Bhat).

 - ACPI cpufreq driver optimization and cleanup (Rafael Wysocki).

 - ACPICA updates including one fix for a regression introduced
   by previos changes in the ACPICA code (Bob Moore, Lv Zheng,
   David Box, Colin Ian King).

 - Support for installing ACPI tables from initrd (Lv Zheng).

 - Optimizations of the ACPI CPPC code (Prashanth Prakash, Ashwin
   Chaugule).

 - Support for _HID(ACPI0010) devices (ACPI processor containers)
   and ACPI processor driver cleanups (Sudeep Holla).

 - Support for ACPI-based enumeration of the AMBA bus (Graeme Gregory,
   Aleksey Makarov).

 - Modification of the ACPI PCI IRQ management code to make it treat
   255 in the Interrupt Line register as "not connected" on x86 (as
   per the specification) and avoid attempts to use that value as
   a valid interrupt vector (Chen Fan).

 - ACPI APEI fixes related to resource leaks (Josh Hunt).

 - Removal of modularity from a few ACPI drivers (BGRT, GHES,
   intel_pmic_crc) that cannot be built as modules in practice (Paul
   Gortmaker).

 - PNP framework update to make it treat ACPI_RESOURCE_TYPE_SERIAL_BUS
   as a valid resource type (Harb Abdulhamid).

 - New device ID (future AMD I2C controller) in the ACPI driver for
   AMD SoCs (APD) and in the designware I2C driver (Xiangliang Yu).

 - Assorted ACPI cleanups (Colin Ian King, Kaiyen Chang, Oleg Drokin).

 - cpuidle menu governor optimization to avoid a square root
   computation in it (Rasmus Villemoes).

 - Fix for potential use-after-free in the generic device properties
   framework (Heikki Krogerus).

 - Updates of the generic power domains (genpd) framework including
   support for multiple power states of a domain, fixes and debugfs
   output improvements (Axel Haslam, Jon Hunter, Laurent Pinchart,
   Geert Uytterhoeven).

 - Intel RAPL power capping driver updates to reduce IPI overhead in
   it (Jacob Pan).

 - System suspend/hibernation code cleanups (Eric Biggers, Saurabh
   Sengar).

 - Year 2038 fix for the process freezer (Abhilash Jindal).

 - turbostat utility updates including new features (decoding of more
   registers and CPUID fields, sub-second intervals support, GFX MHz
   and RC6 printout, --out command line option), fixes (syscall jitter
   detection and workaround, reductioin of the number of syscalls made,
   fixes related to Xeon x200 processors, compiler warning fixes) and
   cleanups (Len Brown, Hubert Chrzaniuk, Chen Yu).

Thanks!


---------------

Abhilash Jindal (1):
      PM/freezer: y2038, use boottime to compare tstamps

Aleksey Makarov (1):
      ACPI: introduce a function to find the first physical device

Ashwin Chaugule (1):
      ACPI / CPPC: Optimize PCC Read Write operations

Axel Haslam (3):
      PM / Domains: Support for multiple states
      ARM: imx6: pm: declare pm domain latency on power_state struct
      PM / Domains: remove old power on/off latencies

Bob Moore (5):
      ACPICA: Remove incorrect "static" from a global structure
      ACPICA: iASL: Fix some typos with the name strtoul64
      ACPICA: iASL: Update to use internal acpi_ut_strtoul64 function
      ACPICA: Remove unnecessary arguments to ACPI_INFO
      ACPICA: Utilities: Update trace mechinism for acquire_object

Chen Fan (1):
      x86/ACPI/PCI: Recognize that Interrupt Line 255 means "not connected"

Chen Yu (1):
      tools/power turbostat: bugfix: TDP MSRs print bits fixing

Colin Ian King (4):
      ACPICA: debugger: dbconvert: free pld_info on error return path
      ACPI / video: remove unused device_decode array
      ACPI: Add acpi_force_32bit_fadt_addr option to force 32 bit FADT addresses
      ACPI / util: remove redundant check if element is NULL

David E. Box (1):
      ACPICA: ACPI 6.0/iASL: Add support for the External AML opcode

Eric Biggers (3):
      PM / sleep: declare __tracedata symbols as char[] rather than char
      cpufreq: fix comment about return value of cpufreq_register_driver()
      cpufreq: simplify for_each_suitable_policy() macro

Felipe Franciosi (1):
      Documentation: cpufreq: intel_pstate: fix typo

Geert Uytterhoeven (2):
      PM / Domains: Restore alignment of slaves in debugfs output
      PM / Domains: Join state name and index in debugfs output

Graeme Gregory (1):
      ACPI / scan: AMBA bus probing support

Harb Abdulhamid (1):
      PNP / ACPI: add ACPI_RESOURCE_TYPE_SERIAL_BUS as a valid type

Heikki Krogerus (1):
      device property: fix for a case of use-after-free

Hubert Chrzaniuk (2):
      tools/power turbostat: Intel Xeon x200: fix erroneous bclk value
      tools/power turbostat: Intel Xeon x200: fix turbo-ratio decoding

Jacob Pan (4):
      cpumask: export cpumask_any_but
      powercap/rapl: reduce ipi calls
      powercap/rapl: add package reference per domain
      powercap/rapl: track lead cpu per package

Jon Hunter (3):
      PM / OPP: Fix NULL pointer dereference crash when disabling OPPs
      PM / Domains: Fix removal of a subdomain
      PM / Domains: Fix potential NULL pointer dereference

Josh Hunt (2):
      ACPI / APEI: Fix leaked resources
      ACPI / APEI: ERST: Fixed leaked resources in erst_init

Kaiyen Chang (1):
      ACPI / fan: Make struct dev_pm_ops const

Laurent Pinchart (1):
      PM / Domains: Propagate start and restore errors during runtime resume

Len Brown (17):
      tools/power turbostat: decode more CPUID fields
      tools/power turbostat: CPUID(0x16) leaf shows base, max, and bus frequency
      x86 msr-index: Simplify syntax for HWP fields
      tools/power turbostat: decode HWP registers
      tools/power turbostat: Decode MSR_MISC_PWR_MGMT
      tools/power turbostat: allow sub-sec intervals
      tools/power turbostat: re-name "%Busy" field to "Busy%"
      tools/power turbostat: add --out option for saving output in a file
      tools/power turbostat: fix compiler warnings
      tools/power turbostat: make fewer systems calls
      tools/power turbostat: show IRQs per CPU
      tools/power turbostat: show GFXMHz
      tools/power turbostat: show GFX%rc6
      tools/power turbostat: detect and work around syscall jitter
      tools/power turbostat: indicate SMX and SGX support
      tools/power turbostat: call __cpuid() instead of __get_cpuid()
      tools/power turbostat: correct output for MSR_NHM_SNB_PKG_CST_CFG_CTL dump

Lv Zheng (7):
      ACPICA: Tables: make default region accessible during the table load
      ACPICA: ACPICA: Tune _REG evaluations order in the initialization steps
      ACPICA: Namespace: Ensure \_SB._INI executed before any _REG
      ACPICA: Namespace: Rename acpi_gbl_reg_methods_enabled to
acpi_gbl_namespace_initialized
      ACPI / OSL: Clean up initrd table override code
      ACPI / OSL: Add support to install tables via initrd
      ACPICA / Interpreter: Fix a regression triggered because of
wrong Linux ECDT support

Oleg Drokin (1):
      ACPI / EC: Deny write access unless requested by module param

Paul Gortmaker (3):
      drivers/acpi: make bgrt driver explicitly non-modular
      drivers/acpi: make apei/ghes.c more explicitly non-modular
      drivers/acpi: make pmic/intel_pmic_crc.c explicitly non-modular

Philippe Longepe (4):
      intel_pstate: Remove extra conversions in pid calculation
      intel_pstate: Optimize calculation for max/min_perf_adj
      intel_pstate: Move intel_pstate_calc_busy() into
get_target_pstate_use_performance()
      intel_pstate: Remove freq calculation from intel_pstate_calc_busy()

Prakash, Prashanth (4):
      ACPI / CPPC: optimized cpc_read and cpc_write
      mailbox: pcc: optimized pcc_send_data
      ACPI / CPPC: replace writeX/readX to PCC with relaxed version
      ACPI / CPPC: use MRTT/MPAR to decide if/when a req can be sent

Rafael J. Wysocki (52):
      cpufreq: Clean up default and fallback governor setup
      cpufreq: Drop unnecessary checks from show() and store()
      cpufreq: Rearrange __cpufreq_driver_target()
      cpufreq: acpi-cpufreq: Drop pointless label from acpi_cpufreq_target()
      cpufreq: Simplify the cpufreq_for_each_valid_entry()
      cpufreq: acpi-cpufreq: Make read and write operations more efficient
      cpufreq: Add mechanism for registering utilization update callbacks
      cpufreq: intel_pstate: Replace timers with utilization update callbacks
      cpufreq: governor: Replace timers with utilization update callbacks
      cpufreq: governor: Use common mutex for dbs_data protection
      cpufreq: governor: Avoid passing dbs_data pointers around unnecessarily
      cpufreq: governor: Put governor structure into common_dbs_data
      cpufreq: governor: Rename some data types and variables
      cpufreq: governor: Rework cpufreq_governor_dbs()
      cpufreq: governor: Drop the gov pointer from struct dbs_data
      cpufreq: governor: Rename cpu_common_dbs_info to policy_dbs_info
      cpufreq: governor: Drop cpu argument from dbs_check_cpu()
      cpufreq: governor: Simplify cpufreq_governor_limits()
      cpufreq: governor: Rearrange governor data structures
      cpufreq: governor: Symmetrize cpu_dbs_info initialization and cleanup
      cpufreq: governor: Rename skip_work to work_count
      cpufreq: governor: Drop pointless goto from cpufreq_governor_init()
      cpufreq: governor: Avoid irq_work_queue_on() crash on non-SMP ARM
      cpufreq: governor: Simplify gov_cancel_work() slightly
      cpufreq: governor: Avoid atomic operations in hot paths
      cpufreq: governor: Fix nice contribution computation in dbs_check_cpu()
      cpufreq: governor: Clean up load-related computations
      cpufreq: governor: Get rid of the ->gov_check_cpu callback
      cpufreq: governor: Reset sample delay in store_sampling_rate()
      cpufreq: governor: Move rate_mult to struct policy_dbs
      cpufreq: ondemand: Simplify conditionals in od_dbs_timer()
      cpufreq: governor: Use microseconds in sample delay computations
      cpufreq: ondemand: Simplify od_update() slightly
      cpufreq: ondemand: Drop unused callback from struct od_ops
      cpufreq: governor: Close dbs_data update race condition
      cpufreq: governor: Move io_is_busy to struct dbs_data
      cpufreq: governor: Add a ->start callback for governors
      cpufreq: governor: Drop unused governor callback and data fields
      cpufreq: ondemand: Drop one more callback from struct od_ops
      cpufreq: governor: Fix CPU load information updates via ->store
      cpufreq: ondemand: Rework the handling of powersave bias updates
      cpufreq: governor: Make governor private data per-policy
      cpufreq: governor: Move per-CPU data to the common code
      cpufreq: governor: Relocate definitions of tuners structures
      cpufreq: governor: Make dbs_data_mutex static
      cpufreq: governor: Narrow down the dbs_data_mutex coverage
      cpufreq: governor: Make gov_set_update_util() static
      cpufreq: governor: Fix race in dbs_update_util_handler()
      cpufreq: Select IRQ_WORK if CPU_FREQ_GOV_COMMON is set
      cpufreq: Reduce cpufreq_update_util() overhead a bit
      cpufreq: Move scheduler-related code to the sched directory
      intel_pstate: Do not skip samples partially

Rasmus Villemoes (2):
      cpuidle: menu: avoid expensive square root computation
      cpuidle: menu: help gcc generate slightly better code

Saurabh Sengar (1):
      PM / suspend: replacing printk

Shilpasri G Bhat (6):
      cpufreq: powernv: Free 'chips' on module exit
      cpufreq: powernv: Hot-plug safe the kworker thread
      cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
      cpufreq: powernv/tracing: Add powernv_throttle tracepoint
      cpufreq: powernv: Replace pr_info with trace print for throttle event
      cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Enable HWP by default
      cpufreq: intel_pstate: disable HWP notifications

Sudeep Holla (3):
      ACPI / processor_idle: replace PREFIX with pr_fmt
      ACPI / processor : add support for ACPI0010 processor container
      ACPI / sleep: move acpi_processor_sleep to sleep.c

Viresh Kumar (38):
      PM / OPP: get/put regulators from OPP core
      PM / OPP: Disable OPPs that aren't supported by the regulator
      PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()
      PM / OPP: Introduce dev_pm_opp_get_max_transition_latency()
      PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
      PM / OPP: Manage device clk
      PM / OPP: Add dev_pm_opp_set_rate()
      cpufreq: dt: Convert few pr_debug/err() calls to dev_dbg/err()
      cpufreq: dt: Rename 'need_update' to 'opp_v1'
      cpufreq: dt: OPP layers handles clock-latency for V1 bindings as well
      cpufreq: dt: Pass regulator name to the OPP core
      cpufreq: dt: Unsupported OPPs are already disabled
      cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
      cpufreq: dt: Use dev_pm_opp_set_rate() to switch frequency
      cpufreq: dt: No need to fetch voltage-tolerance
      cpufreq: dt: No need to allocate resources anymore
      PM / OPP: Initialize u_volt_min/max to a valid value
      PM / OPP: Initialize regulator pointer to an error value
      PM / OPP: Fix incorrect comments
      PM / OPP: Rename structures for clarity
      intel_pstate: Update frequencies of policy->cpus only from ->set_policy()
      cpufreq: governor: Create generic macro for common tunables
      cpufreq: governor: Move common tunables to 'struct dbs_data'
      cpufreq: governor: New sysfs show/store callbacks for governor tunables
      cpufreq: governor: Drop unused macros for creating governor
tunable attributes
      Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
      cpufreq: governor: Create and traverse list of policy_dbs to
avoid deadlock
      cpufreq: Merge cpufreq_offline_prepare/finish routines
      cpufreq: Call __cpufreq_governor() with policy->rwsem held
      cpufreq: Remove cpufreq_governor_lock
      cpufreq: governor: No need to manage state machine now
      cpufreq: conservative: Update sample_delay_ns immediately
      cpufreq: ondemand: Rearrange od_dbs_timer() to avoid updating delay
      cpufreq: governor: Drop unnecessary checks from show() and store()
      cpufreq: Relocate handle_update() to kill its declaration
      cpufreq: Rename __cpufreq_governor() to cpufreq_governor()
      cpufreq: Remove 'policy->governor_enabled'
      Revert "cpufreq: postfix policy directory with the first CPU in
related_cpus"

Xiangliang Yu (1):
      i2c: designware: Add device HID for future AMD I2C controller

waddlesplash (1):
      ACPICA: aclocal: Put parens around some definitions.

---------------

 Documentation/cpu-freq/intel-pstate.txt     |    2 +-
 Documentation/kernel-parameters.txt         |    6 +
 arch/arm/mach-imx/gpc.c                     |    9 +-
 arch/x86/include/asm/msr-index.h            |    8 +-
 drivers/acpi/Makefile                       |    1 +
 drivers/acpi/acpi_amba.c                    |  122 +++
 drivers/acpi/acpi_apd.c                     |    1 +
 drivers/acpi/acpi_platform.c                |   19 +-
 drivers/acpi/acpi_processor.c               |   17 +
 drivers/acpi/acpi_video.c                   |    7 -
 drivers/acpi/acpica/acglobal.h              |    2 +-
 drivers/acpi/acpica/aclocal.h               |    6 +-
 drivers/acpi/acpica/acnamesp.h              |    2 +-
 drivers/acpi/acpica/acpredef.h              |    2 +-
 drivers/acpi/acpica/dbcmds.c                |    2 +-
 drivers/acpi/acpica/dbconvert.c             |    5 +-
 drivers/acpi/acpica/dsmethod.c              |    3 +-
 drivers/acpi/acpica/dsobject.c              |    3 +-
 drivers/acpi/acpica/evgpeblk.c              |    3 +-
 drivers/acpi/acpica/evgpeinit.c             |    2 +-
 drivers/acpi/acpica/evregion.c              |    2 +-
 drivers/acpi/acpica/exconfig.c              |    4 +-
 drivers/acpi/acpica/exoparg3.c              |    4 +-
 drivers/acpi/acpica/nseval.c                |    3 +-
 drivers/acpi/acpica/nsinit.c                |  137 ++--
 drivers/acpi/acpica/tbinstal.c              |    5 +-
 drivers/acpi/acpica/tbprint.c               |    7 +-
 drivers/acpi/acpica/tbutils.c               |    4 +-
 drivers/acpi/acpica/tbxfload.c              |   40 +-
 drivers/acpi/acpica/utcache.c               |    2 +-
 drivers/acpi/acpica/utnonansi.c             |  246 +++++-
 drivers/acpi/acpica/uttrack.c               |    2 +-
 drivers/acpi/acpica/utxferror.c             |    3 +-
 drivers/acpi/acpica/utxfinit.c              |   67 +-
 drivers/acpi/apei/apei-base.c               |    6 +-
 drivers/acpi/apei/erst.c                    |    3 +
 drivers/acpi/apei/ghes.c                    |   23 +-
 drivers/acpi/bgrt.c                         |   10 +-
 drivers/acpi/bus.c                          |   26 +-
 drivers/acpi/cppc_acpi.c                    |  237 ++++--
 drivers/acpi/ec_sys.c                       |    3 +
 drivers/acpi/fan.c                          |    2 +-
 drivers/acpi/internal.h                     |    7 +
 drivers/acpi/osl.c                          |  158 ++--
 drivers/acpi/pci_irq.c                      |   29 +-
 drivers/acpi/pmic/intel_pmic_crc.c          |    7 +-
 drivers/acpi/processor_driver.c             |    2 -
 drivers/acpi/processor_idle.c               |   62 +-
 drivers/acpi/scan.c                         |    1 +
 drivers/acpi/sleep.c                        |   35 +
 drivers/acpi/tables.c                       |   12 +
 drivers/acpi/utils.c                        |    4 -
 drivers/base/power/domain.c                 |   60 +-
 drivers/base/power/domain_governor.c        |   64 +-
 drivers/base/power/opp/core.c               | 1079 +++++++++++++++++++--------
 drivers/base/power/opp/cpu.c                |   22 +-
 drivers/base/power/opp/debugfs.c            |   85 ++-
 drivers/base/power/opp/opp.h                |   74 +-
 drivers/base/power/trace.c                  |    4 +-
 drivers/base/property.c                     |   25 +-
 drivers/cpufreq/Kconfig                     |    1 +
 drivers/cpufreq/acpi-cpufreq.c              |  212 +++---
 drivers/cpufreq/amd_freq_sensitivity.c      |    8 +-
 drivers/cpufreq/cpufreq-dt.c                |  300 +++-----
 drivers/cpufreq/cpufreq.c                   |  333 ++++-----
 drivers/cpufreq/cpufreq_conservative.c      |  282 ++++---
 drivers/cpufreq/cpufreq_governor.c          |  766 ++++++++++---------
 drivers/cpufreq/cpufreq_governor.h          |  261 +++----
 drivers/cpufreq/cpufreq_ondemand.c          |  445 ++++-------
 drivers/cpufreq/cpufreq_ondemand.h          |   30 +
 drivers/cpufreq/cpufreq_performance.c       |   18 +-
 drivers/cpufreq/cpufreq_powersave.c         |   10 +-
 drivers/cpufreq/cpufreq_userspace.c         |   10 +-
 drivers/cpufreq/intel_pstate.c              |  192 +++--
 drivers/cpufreq/powernv-cpufreq.c           |  152 ++--
 drivers/cpuidle/governors/menu.c            |   47 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 drivers/mailbox/pcc.c                       |  111 ++-
 drivers/pnp/pnpacpi/rsparser.c              |    4 +
 drivers/powercap/intel_rapl.c               |  220 +++---
 include/acpi/acoutput.h                     |    2 +-
 include/acpi/acpixf.h                       |    6 +-
 include/acpi/processor.h                    |    9 +-
 include/linux/cpufreq.h                     |   47 +-
 include/linux/interrupt.h                   |   10 +
 include/linux/pm_domain.h                   |   13 +-
 include/linux/pm_opp.h                      |   27 +
 include/linux/sched.h                       |    9 +
 include/trace/events/power.h                |   22 +
 kernel/irq/manage.c                         |    9 +-
 kernel/power/process.c                      |   12 +-
 kernel/power/suspend.c                      |    6 +-
 kernel/sched/Makefile                       |    1 +
 kernel/sched/cpufreq.c                      |   37 +
 kernel/sched/deadline.c                     |    4 +
 kernel/sched/fair.c                         |   26 +-
 kernel/sched/rt.c                           |    4 +
 kernel/sched/sched.h                        |   48 ++
 kernel/trace/power-traces.c                 |    1 +
 lib/cpumask.c                               |    1 +
 tools/power/x86/turbostat/turbostat.8       |   32 +-
 tools/power/x86/turbostat/turbostat.c       |  889 +++++++++++++++++-----
 102 files changed, 4459 insertions(+), 2947 deletions(-)
