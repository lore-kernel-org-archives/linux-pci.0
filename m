Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33698 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115AbcGZU5E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2016 16:57:04 -0400
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Jul 2016 22:57:01 +0200
Message-ID: <CAJZ5v0gjFWS0uGB9m2_4KxK0SHPRJgj2MCLCghpGSS9ZkvOZTw@mail.gmail.com>
Subject: [GIT PULL] Power management changes for v4.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.8-rc1

to receive the main part of power management material for v4.8-rc1
with top-most commit bc841e260c95608921809a2c7481cf6f03bec21a

 Merge branch 'pm-cpu'

on top of commit 523d939ef98fd712632d93a5a2b588e477a7565e

 Linux 4.7

Again, the majority of changes go into the cpufreq subsystem, but there are
no big features this time.  The cpufreq changes that stand out somewhat are the
governor interface rework and improvements related to the handling of frequency
tables.  Apart from those, there are fixes and new device/CPU IDs in drivers,
cleanups and an improvement of the new schedutil governor.

Next, there are some changes in the hibernation core, including a fix for
a nasty problem related to the MONITOR/MWAIT usage by CPU offline during
resume from hibernation, a few core improvements related to memory management
during resume, a couple of additional debug features and cleanups.

Finally, we have some fixes and cleanups in the devfreq subsystem, generic
power domains framework improvements related to system suspend/resume, support
for some new chips in intel_idle and in the power capping RAPL driver, a
new version of the AnalyzeSuspend utility and some assorted fixes and
cleanups.

Specifics:

 - Rework the cpufreq governor interface to make it more straightforward
   and modify the conservative governor to avoid using transition
   notifications (Rafael Wysocki).

 - Rework the handling of frequency tables by the cpufreq core to make
   it more efficient (Viresh Kumar).

 - Modify the schedutil governor to reduce the number of wakeups it
   causes to occur in cases when the CPU frequency doesn't need to be
   changed (Steve Muckle, Viresh Kumar).

 - Fix some minor issues and clean up code in the cpufreq core and
   governors (Rafael Wysocki, Viresh Kumar).

 - Add Intel Broxton support to the intel_pstate driver (Srinivas
   Pandruvada).

 - Fix problems related to the config TDP feature and to the validity
   of the MSR_HWP_INTERRUPT register in intel_pstate (Jan Kiszka,
   Srinivas Pandruvada).

 - Make intel_pstate update the cpu_frequency tracepoint even if
   the frequency doesn't change to avoid confusing powertop (Rafael
   Wysocki).

 - Clean up the usage of __init/__initdata in intel_pstate, mark some
   of its internal variables as __read_mostly and drop an unused
   structure element from it (Jisheng Zhang, Carsten Emde).

 - Clean up the usage of some duplicate MSR symbols in intel_pstate
   and turbostat (Srinivas Pandruvada).

 - Update/fix the powernv, s3c24xx and mvebu cpufreq drivers (Akshay
   Adiga, Viresh Kumar, Ben Dooks).

 - Fix a regression (introduced during the 4.5 cycle) in the
   pcc-cpufreq driver by reverting the problematic commit (Andreas
   Herrmann).

 - Add support for Intel Denverton to intel_idle, clean up Broxton
   support in it and make it explicitly non-modular (Jacob Pan,
   Jan Beulich, Paul Gortmaker).

 - Add support for Denverton and Ivy Bridge server to the Intel RAPL
   power capping driver and make it more careful about the handing
   of MSRs that may not be present (Jacob Pan, Xiaolong Wang).

 - Fix resume from hibernation on x86-64 by making the CPU offline
   during resume avoid using MONITOR/MWAIT in the "play dead" loop
   which may lead to an inadvertent "revival" of a "dead" CPU and
   a page fault leading to a kernel crash from it (Rafael Wysocki).

 - Make memory management during resume from hibernation more
   straightforward (Rafael Wysocki).

 - Add debug features that should help to detect problems related
   to hibernation and resume from it (Rafael Wysocki, Chen Yu).

 - Clean up hibernation core somewhat (Rafael Wysocki).

 - Prevent KASAN from instrumenting the hibernation core which leads
   to large numbers of false-positives from it (James Morse).

 - Prevent PM (hibernate and suspend) notifiers from being called
   during the cleanup phase if they have not been called during the
   corresponding preparation phase which is possible if one of the
   other notifiers returns an error at that time (Lianwei Wang).

 - Improve suspend-related debug printout in the tasks freezer and
   clean up suspend-related console handling (Roger Lu, Borislav
   Petkov).

 - Update the AnalyzeSuspend script in the kernel sources to
   version 4.2 (Todd Brandt).

 - Modify the generic power domains framework to make it handle
   system suspend/resume better (Ulf Hansson).

 - Make the runtime PM framework avoid resuming devices synchronously
   when user space changes the runtime PM settings for them and
   improve its error reporting (Rafael Wysocki, Linus Walleij).

 - Fix error paths in devfreq drivers (exynos, exynos-ppmu, exynos-bus)
   and in the core, make some devfreq code explicitly non-modular and
   change some of it into tristate (Bartlomiej Zolnierkiewicz,
   Peter Chen, Paul Gortmaker).

 - Add DT support to the generic PM clocks management code and make
   it export some more symbols (Jon Hunter, Paul Gortmaker).

 - Make the PCI PM core code slightly more robust against possible
   driver errors (Andy Shevchenko).

 - Make it possible to change DESTDIR and PREFIX in turbostat
   (Andy Shevchenko).

This includes an x86/cpu branch from the tip tree containing changes related
to new Intel CPU model macros that were needed for some driver-related changes
in cpufreq, cpuidle and in the RAPL driver.  The x86/cpu branch has been
excluded from the statistics below.

Thanks!

---------------

Akshay Adiga (1):
      cpufreq: powernv: Replacing pstate_id with frequency table index

Andreas Herrmann (1):
      Revert "cpufreq: pcc-cpufreq: update default value of
cpuinfo_transition_latency"

Andy Shevchenko (2):
      tools/turbostat: allow user to alter DESTDIR and PREFIX
      PCI / PM: check all fields in pci_set_platform_pm()

Bartlomiej Zolnierkiewicz (2):
      PM / devfreq: exynos: fix error path in exynos_bus_probe()
      PM / devfreq: exynos-ppmu: fix error path in exynos_ppmu_probe()

Ben Dooks (1):
      cpufreq: mvebu: fix integer to pointer cast

Borislav Petkov (1):
      PM / sleep: Make pm_prepare_console() return void

Carsten Emde (1):
      cpufreq: intel_pstate: clean remnant struct element

Chen Yu (1):
      PM / hibernate: Introduce test_resume mode for hibernation

Jacob Pan (4):
      powercap / RAPL: reduce message loglevel
      powercap / RAPL: handle missing MSRs
      powercap / RAPL: add support for Denverton
      idle_intel: Add Denverton

James Morse (1):
      PM / Hibernate: Don't let kasan instrument snapshot.c

Jan Beulich (2):
      intel_idle: re-work bxt_idle_state_table_update() and its helper
      intel_idle: correct BXT support

Jan Kiszka (1):
      intel_pstate: Fix MSR_CONFIG_TDP_x addressing in core_get_max_pstate()

Jisheng Zhang (3):
      intel_pstate: Fix incorrect placement of __initdata
      intel_pstate: add __init/__initdata marker to some functions/variables
      intel_pstate: Declare pid_params/pstate_funcs/hwp_active __read_mostly

Jon Hunter (1):
      PM / clk: Add support for adding a specific clock from device-tree

Lianwei Wang (1):
      PM / sleep: make PM notifiers called symmetrically

Linus Walleij (1):
      PM / runtime: print error when activating a child to unactive parent

Paul Gortmaker (7):
      PM / clk: export symbols for existing pm_clk_<...> API fcns
      drivers/idle: make intel_idle.c driver more explicitly non-modular
      PM / devfreq: make devfreq explicitly non-modular
      PM / devfreq: make devfreq-event explicitly non-modular
      PM / devfreq: make exynos-bus ARM_EXYNOS_BUS_DEVFREQ tristate
      PM / devfreq: make event/exynos-nocp DEVFREQ_EVENT_EXYNOS_NOCP tristate
      PM / devfreq: make event/exynos-ppmu DEVFREQ_EVENT_EXYNOS_PPMU tristate

Peter Chen (2):
      PM / devfreq: add missing of_node_put after calling of_parse_phandle
      PM / devfreq: exynos-bus: add missing of_node_put after calling
of_parse_phandle

Rafael J. Wysocki (21):
      cpufreq: governor: CPUFREQ_GOV_LIMITS never fails
      cpufreq: governor: Check transition latecy at init time only
      cpufreq: governor: Simplify performance and powersave governors
      cpufreq: Split cpufreq_governor() into simpler functions
      cpufreq: governor: Get rid of governor events
      cpufreq: Drop the 'initialized' field from struct cpufreq_governor
      cpufreq: stats: Make the stats code non-modular
      cpufreq: governor: Drop gov_cancel_work()
      cpufreq: conservative: Do not use transition notifications
      PM / runtime: Asynchronous "idle" in pm_runtime_allow()
      PM / hibernate: Do not free preallocated safe pages during image restore
      PM / hibernate: Simplify mark_unsafe_pages()
      PM / hibernate: Recycle safe pages after image restoration
      cpufreq: Drop redundant check from cpufreq_update_current_freq()
      PM / hibernate: Add missing braces in hibernate_setup()
      PM / hibernate: Clean up function headers in snapshot.c
      PM / hibernate: Clean up comments in snapshot.c
      PM / hibernate: Add missing braces in __register_nosave_region()
      PM / hibernate: Image data protection during restoration
      x86 / hibernate: Use hlt_play_dead() when resuming from hibernation
      intel_pstate: Update cpu_frequency tracepoint every time

Roger Lu (1):
      PM / suspend: show workqueue state in suspend flow

Srinivas Pandruvada (5):
      cpufreq: intel_pstate: Broxton support
      cpufreq: intel_pstate: Replace MSR_NHM_TURBO_RATIO_LIMIT
      tools/power turbostat: Replace MSR_NHM_TURBO_RATIO_LIMIT
      x86: remove duplicate turbo ratio limit MSRs
      cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT

Steve Muckle (4):
      cpufreq: add cpufreq_driver_resolve_freq()
      cpufreq: schedutil: map raw required frequency to driver frequency
      cpufreq: acpi-cpufreq: use cached frequency mapping when possible
      cpufreq: export cpufreq_driver_resolve_freq()

Todd Brandt (1):
      PM / tools: scripts: AnalyzeSuspend v4.2

Ulf Hansson (7):
      PM / Domains: Allow genpd to power on during system PM phases
      PM / Domains: Remove redundant wrapper functions for system PM
      PM / Domains: Remove redundant pm_request_idle() call in genpd
      PM / Runtime: Avoid resuming devices again in pm_runtime_force_resume()
      PM / Domains: Allow runtime PM during system PM phases
      PM / Domains: Stop/start devices during system PM suspend/resume in genpd
      PM / Domains: Convert pm_genpd_init() to return an error code

Viresh Kumar (16):
      cpufreq: governor: Remove prints from allocation failures
      cpufreq: governor: Remove unnecessary bits from print message
      cpufreq: governor: Create cpufreq_policy_apply_limits()
      cpufreq: Send START policy notification after sending CREATE
      cpufreq: Use clamp_val() in __cpufreq_driver_target()
      cpufreq: Unexport cpufreq_frequency_table_cpuinfo()
      cpufreq: s3c24xx: Remove useless checks
      cpufreq: Remove cpufreq_frequency_get_table()
      cpufreq: ondemand: Don't keep a copy of freq_table pointer
      cpufreq: Drop freq-table param to cpufreq_frequency_table_target()
      cpufreq: Drop 'freq_table' argument of __target_index()
      cpufreq: Return index from cpufreq_frequency_table_target()
      cpufreq: davinci: Reuse cpufreq_generic_frequency_table_verify()
      cpufreq: Handle sorted frequency tables more efficiently
      cpufreq: Reuse new freq-table helpers
      cpufreq: Disallow ->resolve_freq() for drivers providing ->target_index()

Xiaolong Wang (1):
      powercap / RAPL: Add support for Ivy Bridge server

---------------

 Documentation/cpu-freq/core.txt                 |    4 +-
 Documentation/cpu-freq/cpu-drivers.txt          |   10 +-
 Documentation/cpu-freq/pcc-cpufreq.txt          |    4 +-
 Documentation/kernel-parameters.txt             |    3 +
 arch/powerpc/platforms/cell/cpufreq_spudemand.c |   72 +-
 arch/x86/include/asm/msr-index.h                |    2 -
 arch/x86/include/asm/smp.h                      |    1 +
 arch/x86/kernel/smpboot.c                       |    2 +-
 arch/x86/power/cpu.c                            |   30 +
 drivers/base/power/clock_ops.c                  |   45 +
 drivers/base/power/domain.c                     |  301 +-
 drivers/base/power/runtime.c                    |   13 +-
 drivers/cpufreq/Kconfig                         |   13 +-
 drivers/cpufreq/acpi-cpufreq.c                  |   17 +-
 drivers/cpufreq/amd_freq_sensitivity.c          |   10 +-
 drivers/cpufreq/cpufreq.c                       |  223 +-
 drivers/cpufreq/cpufreq_conservative.c          |   88 +-
 drivers/cpufreq/cpufreq_governor.c              |   73 +-
 drivers/cpufreq/cpufreq_governor.h              |   24 +-
 drivers/cpufreq/cpufreq_ondemand.c              |   38 +-
 drivers/cpufreq/cpufreq_ondemand.h              |    1 -
 drivers/cpufreq/cpufreq_performance.c           |   19 +-
 drivers/cpufreq/cpufreq_powersave.c             |   19 +-
 drivers/cpufreq/cpufreq_stats.c                 |  157 +-
 drivers/cpufreq/cpufreq_userspace.c             |  104 +-
 drivers/cpufreq/davinci-cpufreq.c               |   22 +-
 drivers/cpufreq/freq_table.c                    |  106 +-
 drivers/cpufreq/intel_pstate.c                  |   74 +-
 drivers/cpufreq/mvebu-cpufreq.c                 |    2 +-
 drivers/cpufreq/pcc-cpufreq.c                   |    2 -
 drivers/cpufreq/powernv-cpufreq.c               |  181 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c           |    3 +-
 drivers/cpufreq/s3c24xx-cpufreq.c               |   33 +-
 drivers/cpufreq/s5pv210-cpufreq.c               |    7 +-
 drivers/devfreq/Kconfig                         |    2 +-
 drivers/devfreq/devfreq-event.c                 |   12 +-
 drivers/devfreq/devfreq.c                       |   15 +-
 drivers/devfreq/event/Kconfig                   |    4 +-
 drivers/devfreq/event/exynos-ppmu.c             |    3 +-
 drivers/devfreq/exynos-bus.c                    |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c         |   23 -
 drivers/idle/intel_idle.c                       |  107 +-
 drivers/pci/pci.c                               |    4 +-
 drivers/powercap/intel_rapl.c                   |  107 +-
 drivers/thermal/cpu_cooling.c                   |   24 +-
 include/linux/cpufreq.h                         |  289 +-
 include/linux/pm_clock.h                        |    1 +
 include/linux/pm_domain.h                       |   10 +-
 include/linux/suspend.h                         |    5 +-
 kernel/power/Makefile                           |    2 +
 kernel/power/console.c                          |    8 +-
 kernel/power/hibernate.c                        |  101 +-
 kernel/power/main.c                             |   11 +-
 kernel/power/power.h                            |   11 +
 kernel/power/process.c                          |    3 +
 kernel/power/snapshot.c                         |  940 +++---
 kernel/power/suspend.c                          |   10 +-
 kernel/power/swap.c                             |    6 +
 kernel/power/user.c                             |   14 +-
 kernel/sched/cpufreq_schedutil.c                |   74 +-
 kernel/workqueue.c                              |    4 +-
 scripts/analyze_suspend.py                      | 3641 +++++++++++++++--------
 tools/power/x86/turbostat/Makefile              |    4 +-
 tools/power/x86/turbostat/turbostat.8           |    2 +-
 tools/power/x86/turbostat/turbostat.c           |    2 +-
 65 files changed, 4332 insertions(+), 2821 deletions(-)
