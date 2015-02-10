Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:60939 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbBJVTf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 16:19:35 -0500
MIME-Version: 1.0
Date: Tue, 10 Feb 2015 22:19:34 +0100
Message-ID: <CAJZ5v0iyosRQ2g48TxJ39jLuOTUrER2=7j2F9Pg80rrkFAo1Kw@mail.gmail.com>
Subject: [GIT PULL] ACPI and power management updates for 3.20-rc1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-3.20-rc1

to receive ACPI and power management material for v3.20-rc1 with
top-most commit b5e82233cab43c25fc0a1c28d9136a086db4aa52

 Merge branch 'pm-tools'

on top of commit bfa76d49576599a4b9f9b7a71f23d73d6dcff735

 Linux 3.19

We have a few new features this time, including a new SFI-based
cpufreq driver, a new devfreq driver for Tegra Activity Monitor,
a new devfreq class for providing its governors with raw
utilization data and a new ACPI driver for AMD SoCs.

Still, the majority of changes here are reworks of existing code to
make it more straightforward or to prepare it for implementing new
features on top of it.  The primary example is the rework of ACPI
resources handling from Jiang Liu, Thomas Gleixner and Lv Zheng
with support for IOAPIC hotplug implemented on top of it, but
there is quite a number of changes of this kind in the cpufreq core,
ACPICA, ACPI EC driver, ACPI processor driver and the generic power
domains core code too.

The most active developer is Viresh Kumar with his cpufreq changes.

Specifics:

 - Rework of the core ACPI resources parsing code to fix issues
   in it and make using resource offsets more convenient and
   consolidation of some resource-handing code in a couple of places
   that have grown analagous data structures and code to cover the
   the same gap in the core (Jiang Liu, Thomas Gleixner, Lv Zheng).

 - ACPI-based IOAPIC hotplug support on top of the resources handling
   rework (Jiang Liu, Yinghai Lu).

 - ACPICA update to upstream release 20150204 including an interrupt
   handling rework that allows drivers to install raw handlers for
   ACPI GPEs which then become entirely responsible for the given GPE
   and the ACPICA core code won't touch it (Lv Zheng, David E Box,
   Octavian Purdila).

 - ACPI EC driver rework to fix several concurrency issues and other
   problems related to events handling on top of the ACPICA's new
   support for raw GPE handlers (Lv Zheng).

 - New ACPI driver for AMD SoCs analogous to the LPSS (Low-Power
   Subsystem) driver for Intel chips (Ken Xue).

 - Two minor fixes of the ACPI LPSS driver (Heikki Krogerus,
   Jarkko Nikula).

 - Two new blacklist entries for machines (Samsung 730U3E/740U3E and
   510R) where the native backlight interface doesn't work correctly
   while the ACPI one does (Hans de Goede).

 - Rework of the ACPI processor driver's handling of idle states
   to make the code more straightforward and less bloated overall
   (Rafael J Wysocki).

 - Assorted minor fixes related to ACPI and SFI (Andreas Ruprecht,
   Andy Shevchenko, Hanjun Guo, Jan Beulich, Rafael J Wysocki,
   Yaowei Bai).

 - PCI core power management modification to avoid resuming (some)
   runtime-suspended devices during system suspend if they are in
   the right states already (Rafael J Wysocki).

 - New SFI-based cpufreq driver for Intel platforms using SFI
   (Srinidhi Kasagar).

 - cpufreq core fixes, cleanups and simplifications (Viresh Kumar,
   Doug Anderson, Wolfram Sang).

 - SkyLake CPU support and other updates for the intel_pstate driver
   (Kristen Carlson Accardi, Srinivas Pandruvada).

 - cpufreq-dt driver cleanup (Markus Elfring).

 - Init fix for the ARM big.LITTLE cpuidle driver (Sudeep Holla).

 - Generic power domains core code fixes and cleanups (Ulf Hansson).

 - Operating Performance Points (OPP) core code cleanups and kernel
   documentation update (Nishanth Menon).

 - New dabugfs interface to make the list of PM QoS constraints
   available to user space (Nishanth Menon).

 - New devfreq driver for Tegra Activity Monitor (Tomeu Vizoso).

 - New devfreq class (devfreq_event) to provide raw utilization data
   to devfreq governors (Chanwoo Choi).

 - Assorted minor fixes and cleanups related to power management
   (Andreas Ruprecht, Krzysztof Kozlowski, Rickard Strandqvist,
   Pavel Machek, Todd E Brandt, Wonhong Kwon).

 - turbostat updates (Len Brown) and cpupower Makefile improvement
   (Sriram Raghunathan).

Thanks!


---------------

Andreas Ruprecht (2):
      USB / PM: Remove unneeded #ifdef and associated dead code
      ACPI / PM: Remove unneeded nested #ifdef

Andy Shevchenko (1):
      SFI: fix compiler warnings

Chanwoo Choi (3):
      PM / devfreq: event: Add devfreq_event class
      devfreq: Fix build break of devfreq-event class
      PM / devfreq: event: Add documentation for exynos-ppmu
devfreq-event driver

David E. Box (4):
      ACPICA: Events: Fix uninitialized variable
      ACPICA: Hardware: Cast GPE enable_mask before storing
      ACPICA: Update Copyright headers to 2015
      ACPICA: Update version to 20150204

Doug Anderson (1):
      cpufreq: suspend cpufreq governors on shutdown

Hanjun Guo (1):
      ACPI / table: remove duplicate NULL check for the handler of
acpi_table_parse()

Hans de Goede (2):
      ACPI / video: Add disable_native_backlight quirk for Samsung 730U3E/740U3E
      ACPI / video: Add disable_native_backlight quirk for Samsung 510R

Heikki Krogerus (1):
      ACPI / LPSS: check the result of ioremap()

Jan Beulich (1):
      ACPI / sleep: mark acpi_sleep_dmi_check() __init

Jarkko Nikula (1):
      ACPI / LPSS: Remove non-existing clock control from Intel Lynxpoint I2C

Jiang Liu (14):
      ACPI: Fix a bug in parsing ACPI Memory24 resource
      ACPI: Normalize return value of resource parser functions
      ACPI: Set flag IORESOURCE_UNSET for unassigned resources
      ACPI: Enforce stricter checks for address space descriptors
      ACPI: Return translation offset when parsing ACPI address space resources
      ACPI: Translate resource into master side address for bridge
window resources
      ACPI: Add field offset to struct resource_list_entry
      ACPI: Introduce helper function acpi_dev_filter_resource_type()
      resources: Move struct resource_list_entry from ACPI into resource core
      PCI: Use common resource list management code instead of private
implementation
      x86/PCI: Fix the range check for IO resources
      x86/PCI/ACPI: Use common ACPI resource interfaces to simplify
implementation
      x86/PCI: Refine the way to release PCI IRQ resources
      x86/irq, ACPI: Implement ACPI driver to support IOAPIC hotplug

Ken Xue (1):
      ACPI: add AMD ACPI2Platform device support for x86 system

Kristen Carlson Accardi (5):
      intel_pstate: Add support for SkyLake
      intel_pstate: expose turbo range to sysfs
      intel_pstate: Add num_pstates to sysfs
      intel_pstate: honor user space min_perf_pct override on resume
      intel_pstate: provide option to only use intel_pstate with HWP

Krzysztof Kozlowski (2):
      PM / QoS: Use lockdep asserts to find missing hold of power.lock
      PM / OPP: Assert RCU lock in exported functions

Len Brown (4):
      tools/power turbostat: relax dependency on root permission
      tools/power turbostat: decode MSR_*_PERF_LIMIT_REASONS
      tools/power turbostat: relax dependency on invariant TSC
      tools/power turbostat: relax dependency on APERF_MSR

Lv Zheng (25):
      ACPI / EC: Cleanup transaction wakeup code
      ACPI / EC: Add reference counting for query handlers
      ACPI / EC: Fix returning values in acpi_ec_sync_query()
      ACPI / EC: Fix a code path that global lock is not held
      ACPI / EC: Fix issues related to the SCI_EVT handling
      ACPI / EC: Cleanup QR_EC related code
      ACPI: Introduce acpi_unload_parent_table() usages in Linux kernel
      ACPICA: Resources: Provide common part for struct
acpi_resource_address structures.
      ACPICA: Events: Back port "ACPICA: Save current masks of enabled
GPEs after enable register writes"
      ACPICA: Events: Remove duplicated sanity check in acpi_ev_enable_gpe()
      ACPICA: Events: Remove acpi_ev_valid_gpe_event() due to current
restriction
      ACPICA: Events: Cleanup of resetting the GPE handler to NULL
before removing
      ACPICA: Events: Cleanup to move acpi_gbl_global_event_handler
invocation out of acpi_ev_gpe_dispatch()
      ACPICA: Events: Cleanup GPE dispatcher type obtaining code
      ACPICA: Events: Introduce ACPI_GPE_DISPATCH_RAW_HANDLER to fix 2
issues for the current GPE APIs
      ACPICA: Events: Introduce acpi_set_gpe()/acpi_finish_gpe() to
reduce divergences
      ACPICA: Events: Enable APIs to allow interrupt/polling adaptive
request based GPE handling model
      ACPI / EC: Fix several GPE handling issues by deploying
ACPI_GPE_DISPATCH_RAW_HANDLER mode.
      ACPI / EC: Reduce ec_poll() by referencing the last register
access timestamp.
      ACPI / EC: Update revision due to raw handler mode.
      ACPI / EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag
      ACPI / EC: Add command flushing support.
      ACPI / EC: Refine command storm prevention support
      ACPI / EC: Add query flushing support
      ACPI / EC: Add GPE reference counting debugging messages

Markus Elfring (1):
      cpufreq-dt: Drop unnecessary check before
cpufreq_cooling_unregister() invocation

Nishanth Menon (4):
      PM / QoS: Add debugfs support to view the list of constraints
      PM / OPP: export dev_pm_opp_get_notifier
      PM / OPP: Ensure consistent naming of static functions
      PM / OPP: Update kernel documentation

Octavian Purdila (1):
      ACPICA: take ACPI_MTX_INTERPRETER in acpi_unload_table_id()

Pavel Machek (1):
      PM / sleep: Mention async suspend in PM_TRACE documentation

Rafael J. Wysocki (11):
      PCI / PM: Avoid resuming PCI devices during system suspend
      ACPI / cpuidle: Drop unnecessary calls from acpi_idle_do_entry()
      ACPI / cpuidle: Drop unnecessary calls from ->enter callback routines
      ACPI / cpuidle: Clean up fallback to C1 checks
      ACPI / cpuidle: Drop irrelevant comment from acpi_idle_enter_simple()
      ACPI / cpuidle: Clean up white space in a switch statement
      ACPI / cpuidle: Drop flags.bm_check tests from acpi_idle_enter_bm()
      ACPI / cpuidle: Merge acpi_idle_enter_c1() and acpi_idle_enter_simple()
      ACPI / cpuidle: Common callback routine for entering states
      ACPI / PCC: Use pr_debug() for debug messages in pcc_init()
      Merge branch 'pci/host-generic' of
git://git.kernel.org/.../helgaas/pci into acpi-resources

Rickard Strandqvist (1):
      PM / hibernate: Remove unused function

Srinidhi Kasagar (1):
      cpufreq: Add SFI based cpufreq driver support

Srinivas Pandruvada (1):
      intel_pstate: respect cpufreq policy request

Sriram Raghunathan (1):
      cpupower Makefile change to help run the tool without 'make install'

Sudeep Holla (1):
      drivers: cpuidle: Don't initialize big.LITTLE driver if MCPM is
unavailable

Thomas Gleixner (7):
      ACPI: Remove redundant check in function acpi_dev_resource_address_space()
      ACPI: Implement proper length checks for mem resources
      ACPI: Use the length check for io resources as well
      ACPI: Let the parser return false for disabled resources
      ACPI: Unify the parsing of address_space and ext_address_space
      ACPI: Move the window flag logic to the combined parser
      ACPI: Add prefetch decoding to the address space parser

Todd E Brandt (1):
      PM / sleep: export suspend_resume trace event

Tomeu Vizoso (1):
      PM / devfreq: tegra: add devfreq driver for Tegra Activity Monitor

Ulf Hansson (11):
      PM / Domains: Remove pm_genpd_dev_need_restore() API
      PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
      PM / Domains: Remove reference counting for the generic_pm_domain_data
      PM / Domains: Don't allow an existing generic_pm_domain_data
      PM / Domains: Don't check for an existing device when adding a new
      PM / Domains: Eliminate the mutex for the generic_pm_domain_data
      PM / Domains: Free pm_subsys_data in error path in __pm_genpd_add_device()
      PM / Domains: Re-order initialization of generic_pm_domain_data
      PM / Domains: Handle errors from genpd's ->attach_dev() callback
      PM: Update function header for dev_pm_get_subsys_data()
      PM: Convert dev_pm_put_subsys_data() into a void function

Viresh Kumar (35):
      cpufreq: remove dangling comment
      cpufreq: remove extra parenthesis
      cpufreq: don't need line break in show_scaling_cur_freq()
      cpufreq: merge 'if' blocks in __cpufreq_remove_dev_prepare()
      cpufreq: s/__find_governor/find_governor
      cpufreq: No need to check for has_target()
      cpufreq: pass policy to cpufreq_out_of_sync
      cpufreq: pass policy to __cpufreq_get()
      cpufreq: update driver_data->flags only if we are registering driver
      cpufreq: get rid of CONFIG_{HOTPLUG_CPU|SMP} mess
      cpufreq: get rid of 'tpolicy' from __cpufreq_add_dev()
      cpufreq: use light-weight cpufreq_cpu_get_raw() in __cpufreq_add_dev()
      cpufreq: limit the scope of l_p_j variables
      cpufreq: check cpufreq_policy_list instead of scanning policies
for all CPUs
      cpufreq: move some initialization stuff to cpufreq_policy_alloc()
      cpufreq: stats: Improve module description string
      cpufreq: stats: return -EEXIST when stats are already allocated
      cpufreq: stats: remove unused cpufreq_stats_attribute
      cpufreq: stats: initialize 'cur_time' on its definition
      cpufreq: stats: don't check for freq table while freeing stats
      cpufreq: stats: pass 'stat' to cpufreq_stats_update()
      cpufreq: stats: get rid of per-cpu cpufreq_stats_table
      cpufreq: stats: rename 'struct cpufreq_stats' objects as 'stats'
      cpufreq: Remove (now) unused 'last_cpu' from struct cpufreq_policy
      cpufreq: stats: drop 'cpu' field of struct cpufreq_stats
      cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
      cpufreq: stats: create sysfs group once we are ready
      cpufreq: stats: time_in_state can't be NULL in cpufreq_stats_update()
      cpufreq: stats: don't update stats from show_trans_table()
      cpufreq: stats: don't update stats on false notifiers
      cpufreq: stats: drop unnecessary locking
      cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
      cpufreq: Drop cpufreq_disabled() check from cpufreq_cpu_{get|put}()
      cpufreq: Create for_each_policy()
      cpufreq: Create for_each_governor()

Wolfram Sang (1):
      cpufreq: drop owner assignment from platform_drivers

Wonhong Kwon (1):
      PM / hibernate: exclude freed pages from allocated pages printout

Yaowei Bai (2):
      ACPI / Documentation: add a missing '='
      MAINTAINERS / ACPI: add the necessary '/' according to entry rules

Yinghai Lu (1):
      ACPI: Add interfaces to parse IOAPIC ID for IOAPIC hotplug

---------------

 Documentation/acpi/enumeration.txt                 |   2 +-
 Documentation/cpu-freq/intel-pstate.txt            |   8 +
 .../bindings/devfreq/event/exynos-ppmu.txt         | 110 ++++
 Documentation/kernel-parameters.txt                |   3 +
 Documentation/power/s2ram.txt                      |   4 +
 MAINTAINERS                                        |   4 +-
 arch/arm/kernel/bios32.c                           |   5 +-
 arch/ia64/kernel/acpi-ext.c                        |   6 +-
 arch/ia64/kernel/acpi.c                            |   6 -
 arch/ia64/pci/pci.c                                |  14 +-
 arch/x86/Kconfig                                   |  11 +
 arch/x86/include/asm/pci_x86.h                     |   2 -
 arch/x86/include/uapi/asm/msr-index.h              |   5 +
 arch/x86/kernel/acpi/boot.c                        |  16 +-
 arch/x86/pci/acpi.c                                | 293 +++------
 arch/x86/pci/bus_numa.c                            |   4 +-
 arch/x86/pci/common.c                              |  34 +-
 arch/x86/pci/intel_mid_pci.c                       |   4 +-
 arch/x86/pci/irq.c                                 |  15 +-
 arch/x86/pci/mmconfig-shared.c                     |   6 +-
 drivers/acpi/Kconfig                               |   6 +
 drivers/acpi/Makefile                              |   3 +-
 drivers/acpi/acpi_apd.c                            | 150 +++++
 drivers/acpi/acpi_lpss.c                           |  12 +-
 drivers/acpi/acpi_memhotplug.c                     |   8 +-
 drivers/acpi/acpi_platform.c                       |   4 +-
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   4 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acmacros.h                     |   2 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsmthdat.c                     |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dsutils.c                      |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   2 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        | 164 ++---
 drivers/acpi/acpica/evgpeblk.c                     |  10 +-
 drivers/acpi/acpica/evgpeinit.c                    |  10 +-
 drivers/acpi/acpica/evgpeutil.c                    |  61 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   2 +-
 drivers/acpi/acpica/evsci.c                        |   2 +-
 drivers/acpi/acpica/evxface.c                      | 132 +++-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      | 123 +++-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   2 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   2 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   2 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |  10 +-
 drivers/acpi/acpica/hwpci.c                        |   2 +-
 drivers/acpi/acpica/hwregs.c                       |   2 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsaccess.c                     |   2 +-
 drivers/acpi/acpica/nsalloc.c                      |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nseval.c                       |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsnames.c                      |   2 +-
 drivers/acpi/acpica/nsobject.c                     |   2 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nssearch.c                     |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfeval.c                     |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/nsxfobj.c                      |  46 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psloop.c                       |   2 +-
 drivers/acpi/acpica/psobject.c                     |   2 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   2 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rsaddr.c                       |  11 +-
 drivers/acpi/acpica/rscalc.c                       |   2 +-
 drivers/acpi/acpica/rscreate.c                     |   2 +-
 drivers/acpi/acpica/rsdump.c                       |   2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |  61 +-
 drivers/acpi/acpica/rsinfo.c                       |   2 +-
 drivers/acpi/acpica/rsio.c                         |   2 +-
 drivers/acpi/acpica/rsirq.c                        |   2 +-
 drivers/acpi/acpica/rslist.c                       |   2 +-
 drivers/acpi/acpica/rsmemory.c                     |   2 +-
 drivers/acpi/acpica/rsmisc.c                       |   2 +-
 drivers/acpi/acpica/rsserial.c                     |   2 +-
 drivers/acpi/acpica/rsutils.c                      |   2 +-
 drivers/acpi/acpica/rsxface.c                      |  12 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   2 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |  41 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/utdelete.c                     |   2 +-
 drivers/acpi/acpica/uterror.c                      |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utexcep.c                      |   2 +-
 drivers/acpi/acpica/utfileio.c                     |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utmath.c                       |   2 +-
 drivers/acpi/acpica/utmisc.c                       |   2 +-
 drivers/acpi/acpica/utmutex.c                      |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utownerid.c                    |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/utresrc.c                      |   2 +-
 drivers/acpi/acpica/utstate.c                      |   2 +-
 drivers/acpi/acpica/utstring.c                     |   2 +-
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxferror.c                    |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/acpica/utxfmutex.c                    |   2 +-
 drivers/acpi/device_pm.c                           |   2 -
 drivers/acpi/ec.c                                  | 548 ++++++++++++----
 drivers/acpi/internal.h                            |  11 +
 drivers/acpi/ioapic.c                              | 229 +++++++
 drivers/acpi/numa.c                                |  12 +-
 drivers/acpi/pci_irq.c                             |   9 +-
 drivers/acpi/pci_root.c                            |   9 +-
 drivers/acpi/processor_core.c                      | 123 +++-
 drivers/acpi/processor_idle.c                      | 182 ++----
 drivers/acpi/resource.c                            | 353 ++++++----
 drivers/acpi/scan.c                                |   1 +
 drivers/acpi/sleep.c                               |   2 +-
 drivers/acpi/video.c                               |  18 +
 drivers/base/power/common.c                        |  18 +-
 drivers/base/power/domain.c                        | 157 ++---
 drivers/base/power/opp.c                           | 194 ++++--
 drivers/base/power/qos.c                           |   4 +
 drivers/char/hpet.c                                |   4 +-
 drivers/cpufreq/Kconfig.x86                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt.c                       |   3 +-
 drivers/cpufreq/cpufreq.c                          | 174 ++---
 drivers/cpufreq/cpufreq_stats.c                    | 219 +++----
 drivers/cpufreq/intel_pstate.c                     |  55 +-
 drivers/cpufreq/ls1x-cpufreq.c                     |   1 -
 drivers/cpufreq/sfi-cpufreq.c                      | 136 ++++
 drivers/cpuidle/cpuidle-big_little.c               |   4 +
 drivers/devfreq/Kconfig                            |  12 +
 drivers/devfreq/Makefile                           |   5 +
 drivers/devfreq/devfreq-event.c                    | 494 ++++++++++++++
 drivers/devfreq/event/Kconfig                      |  25 +
 drivers/devfreq/event/Makefile                     |   2 +
 drivers/devfreq/event/exynos-ppmu.c                | 374 +++++++++++
 drivers/devfreq/event/exynos-ppmu.h                |  93 +++
 drivers/devfreq/tegra-devfreq.c                    | 718 +++++++++++++++++++++
 drivers/dma/acpi-dma.c                             |  10 +-
 drivers/hv/vmbus_drv.c                             |   4 +-
 drivers/mailbox/pcc.c                              |   4 +-
 drivers/of/of_pci.c                                |   3 +
 drivers/pci/bus.c                                  |  18 +-
 drivers/pci/host-bridge.c                          |   8 +-
 drivers/pci/host/pci-host-generic.c                |   4 +-
 drivers/pci/host/pci-xgene.c                       |   4 +-
 drivers/pci/host/pcie-xilinx.c                     |   4 +-
 drivers/pci/hotplug/sgi_hotplug.c                  |  13 +-
 drivers/pci/pci-acpi.c                             |  17 +
 drivers/pci/pci-driver.c                           |  11 +-
 drivers/pci/pci.c                                  |  26 +
 drivers/pci/pci.h                                  |   6 +
 drivers/pci/probe.c                                |  10 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  45 +-
 drivers/sfi/sfi_core.c                             |   4 +-
 drivers/usb/core/hub.c                             |  12 -
 drivers/xen/xen-acpi-memhotplug.c                  |   8 +-
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |   2 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |  18 +-
 include/acpi/acrestyp.h                            |  42 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |   2 +-
 include/acpi/actbl2.h                              |   2 +-
 include/acpi/actbl3.h                              |   2 +-
 include/acpi/actypes.h                             |  14 +-
 include/acpi/platform/acenv.h                      |   2 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |   2 +-
 include/acpi/platform/aclinux.h                    |   2 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/linux/acpi.h                               |  22 +-
 include/linux/cpufreq.h                            |  10 +-
 include/linux/devfreq-event.h                      | 196 ++++++
 include/linux/pci.h                                |   9 +-
 include/linux/pm.h                                 |   2 +-
 include/linux/pm_domain.h                          |   4 -
 include/linux/resource_ext.h                       |  77 +++
 kernel/power/qos.c                                 |  91 ++-
 kernel/power/snapshot.c                            |  11 +-
 kernel/resource.c                                  |  25 +
 kernel/trace/power-traces.c                        |   1 +
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslibcfs.c     |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 tools/power/cpupower/Makefile                      |   2 +-
 tools/power/x86/turbostat/turbostat.8              |  66 +-
 tools/power/x86/turbostat/turbostat.c              | 338 +++++++---
 298 files changed, 5315 insertions(+), 1824 deletions(-)
