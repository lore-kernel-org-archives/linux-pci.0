Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44913 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdKMWFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 17:05:10 -0500
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Nov 2017 23:05:08 +0100
Message-ID: <CAJZ5v0jVUXjvuAKcSNQAqgOFKyc_0Qf3Eawj95qQGDQ2AB6b4w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.15-rc1

with top-most commit 990a848d537e4da966907c8ccec95bc568f2911c

 Merge branches 'pm-devfreq' and 'pm-tools'

on top of commit e029b9bf1221f200319541cd6861912b89345665

 Merge branch 'pm-cpufreq-sched'

to receive power management updates for 4.15-rc1.

There are no real big ticket items here this time.

The most noticeable change is probably the relocation of the
OPP (Operating Performance Points) framework to its own directory
under drivers/ as it has grown big enough for that.  Also Viresh
is now going to maintain it and send pull requests for it to me,
so you will see this change in the git history going forward (but
still not right now).

Another noticeable set of changes is the modifications of the PM
core, the PCI subsystem and the ACPI PM domain to allow of more
integration between system-wide suspend/resume and runtime PM.
For now it's just a way to avoid resuming devices from runtime
suspend unnecessarily during system suspend (if the driver sets
a flag to indicate its readiness for that) and in the works is
an analogous mechanism to allow devices to stay suspended after
system resume.

In addition to that, we have some changes related to supporting
frequency-invariant CPU utilization metrics in the scheduler and
in the schedutil cpufreq governor on ARM and changes to add support
for device performance states to the generic power domains (genpd)
framework.

The rest is mostly fixes and cleanups of various sorts.

Specifics:

 - Relocate the OPP (Operating Performance Points) framework to its
   own directory under drivers/ and add support for power domain
   performance states to it (Viresh Kumar).

 - Modify the PM core, the PCI bus type and the ACPI PM domain to
   support power management driver flags allowing device drivers to
   specify their capabilities and preferences regarding the handling
   of devices with enabled runtime PM during system suspend/resume
   and clean up that code somewhat (Rafael Wysocki, Ulf Hansson).

 - Add frequency-invariant accounting support to the task scheduler
   on ARM and ARM64 (Dietmar Eggemann).

 - Fix PM QoS device resume latency framework to prevent "no
   restriction" requests from overriding requests with specific
   requirements and drop the confusing PM_QOS_FLAG_REMOTE_WAKEUP
   device PM QoS flag (Rafael Wysocki).

 - Drop legacy class suspend/resume operations from the PM core
   and drop legacy bus type suspend and resume callbacks from
   ARM/locomo (Rafael Wysocki).

 - Add min/max frequency support to devfreq and clean it up
   somewhat (Chanwoo Choi).

 - Rework wakeup support in the generic power domains (genpd)
   framework and update some of its users accordingly (Geert
   Uytterhoeven).

 - Convert timers in the PM core to use timer_setup() (Kees Cook).

 - Add support for exposing the SLP_S0 (Low Power S0 Idle)
   residency counter based on the LPIT ACPI table on Intel
   platforms (Srinivas Pandruvada).

 - Add per-CPU PM QoS resume latency support to the ladder cpuidle
   governor (Ramesh Thomas).

 - Fix a deadlock between the wakeup notify handler and the
   notifier removal in the ACPI core (Ville Syrj=C3=A4l=C3=A4).

 - Fix a cpufreq schedutil governor issue causing it to use
   stale cached frequency values sometimes (Viresh Kumar).

 - Fix an issue in the system suspend core support code causing
   wakeup events detection to fail in some cases (Rajat Jain).

 - Fix the generic power domains (genpd) framework to prevent
   the PM core from using the direct-complete optimization with
   it as that is guaranteed to fail (Ulf Hansson).

 - Fix a minor issue in the cpuidle core and clean it up a bit
   (Gaurav Jindal, Nicholas Piggin).

 - Fix and clean up the intel_idle and ARM cpuidle drivers (Jason
   Baron, Len Brown, Leo Yan).

 - Fix a couple of minor issues in the OPP framework and clean it
   up (Arvind Yadav, Fabio Estevam, Sudeep Holla, Tobias Jordan).

 - Fix and clean up some cpufreq drivers and fix a minor issue in
   the cpufreq statistics code (Arvind Yadav, Bhumika Goyal, Fabio
   Estevam, Gautham Shenoy, Gustavo Silva, Marek Szyprowski, Masahiro
   Yamada, Robert Jarzmik, Zumeng Chen).

 - Fix minor issues in the system suspend and hibernation core, in
   power management documentation and in the AVS (Adaptive Voltage
   Scaling) framework (Helge Deller, Himanshu Jha, Joe Perches,
   Rafael Wysocki).

 - Fix some issues in the cpupower utility and document that Shuah
   Khan is going to maintain it going forward (Prarit Bhargava,
   Shuah Khan).

Thanks!


---------------

Arvind Yadav (3):
      cpufreq: powernow-k8: pr_err() strings should end with newlines
      cpufreq: SPEAr: pr_err() strings should end with newlines
      PM / OPP: Use snprintf() to avoid kasprintf() and kfree()

Bhumika Goyal (2):
      cpufreq: arm_big_little: make function arguments and structure
pointer const
      cpufreq: arm_big_little: make cpufreq_arm_bL_ops structures const

Chanwoo Choi (7):
      PM / devfreq: Set min/max_freq when adding the devfreq device
      Revert "PM / devfreq: Add show_one macro to delete the duplicate code=
"
      PM / devfreq: Use the available min/max frequency
      PM / devfreq: Change return type of devfreq_set_freq_table()
      PM / devfreq: Show the all available frequencies
      PM / devfreq: Remove unneeded conditional statement
      PM / devfreq: Define the constant governor name

Dietmar Eggemann (10):
      drivers base/arch_topology: free cpumask cpus_to_visit
      cpufreq: provide default frequency-invariance setter function
      cpufreq: arm_big_little: invoke frequency-invariance setter function
      cpufreq: dt: invoke frequency-invariance setter function
      drivers base/arch_topology: provide frequency-invariant accounting su=
pport
      drivers base/arch_topology: allow inlining cpu-invariant
accounting support
      arm: wire frequency-invariant accounting support up to the task sched=
uler
      arm: wire cpu-invariant accounting support up to the task scheduler
      arm64: wire frequency-invariant accounting support up to the
task scheduler
      arm64: wire cpu-invariant accounting support up to the task scheduler

Fabio Estevam (2):
      PM / OPP: Move error message to debug level
      cpufreq: imx6q: Move speed grading check to cpufreq driver

Gaurav Jindal (2):
      cpuidle: Clean up cpuidle_enable_device() error handling a bit
      cpuidle: Avoid assignment in if () argument

Gautham R. Shenoy (1):
      cpufreq: stats: Handle the case when trans_table goes beyond PAGE_SIZ=
E

Geert Uytterhoeven (5):
      PM / Domains: Allow genpd users to specify default active wakeup beha=
vior
      ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ACTIVE_WAKEUP
      soc: mediatek: Use GENPD_FLAG_ACTIVE_WAKEUP
      soc: rockchip: power-domain: Use GENPD_FLAG_ACTIVE_WAKEUP
      PM / Domains: Remove gpd_dev_ops.active_wakeup() callback

Gustavo A. R. Silva (1):
      cpufreq: speedstep-lib: mark expected switch fall-through

Helge Deller (1):
      PM / AVS: Use %pS printk format for direct addresses

Himanshu Jha (1):
      freezer: Fix typo in freezable_schedule_timeout() comment

Jason Baron (1):
      intel_idle: replace conditionals with static_cpu_has(X86_FEATURE_ARAT=
)

Joe Perches (1):
      PM: Use a more common logging style

Kees Cook (1):
      PM / core: Convert timers to use timer_setup()

Len Brown (1):
      intel_idle: Graceful probe failure when MWAIT is disabled

Leo Yan (2):
      ARM: cpuidle: Correct driver unregistration if init fails
      ARM: cpuidle: Refactor rollback operations if init fails

Marek Szyprowski (1):
      cpufreq: dt: Remove support for Exynos4212 SoCs

Masahiro Yamada (1):
      cpufreq: dt-platdev: drop socionext,uniphier-ld6b from whitelist

Nicholas Piggin (1):
      cpuidle: fix broadcast control when broadcast can not be entered

Prarit Bhargava (3):
      cpupower: Fix no-rounding MHz frequency output
      tools/power/cpupower: Add 64 bit library detection
      tools/power/cpupower: add libcpupower.so.0.0.1 to .gitignore

Rafael J. Wysocki (19):
      PM: Document rules on using pm_runtime_resume() in system
suspend callbacks
      PM / core: Drop legacy class suspend/resume operations
      PCI / PM: Do not resume any devices in pci_pm_prepare()
      PCI / PM: Add dev_dbg() to print device suspend power states
      PM: ARM: locomo: Drop suspend and resume bus type callbacks
      ACPI / PM: Combine two identical device resume routines
      PM / QoS: Drop PM_QOS_FLAG_REMOTE_WAKEUP
      ACPI / PM: Combine device suspend routines
      PM: docs: Fix formatting typo in devices.rst
      PM / core: Fix kerneldoc comments of four functions
      ACPI / LPSS: Consolidate runtime PM and system sleep handling
      PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags
      PCI / PM: Use the NEVER_SKIP driver flag
      PM / core: Add SMART_SUSPEND driver flag
      PCI / PM: Drop unnecessary invocations of pcibios_pm_ops callbacks
      PCI / PM: Take SMART_SUSPEND driver flag into account
      ACPI / PM: Take SMART_SUSPEND driver flag into account
      PM / domains: Rework governor code to be more consistent
      PM / QoS: Fix device resume latency framework

Rajat Jain (1):
      PM / s2idle: Clear the events_check_enabled flag

Ramesh Thomas (1):
      cpuidle: ladder: Add per CPU PM QoS resume latency support

Robert Jarzmik (1):
      cpufreq: pxa: convert to clock API

Shuah Khan (1):
      MAINTAINERS: add maintainer for tools/power/cpupower

Srinivas Pandruvada (1):
      ACPI / LPIT: Add Low Power Idle Table (LPIT) support

Sudeep Holla (1):
      PM / OPP: add missing of_node_put() for of_get_cpu_node()

Tobias Jordan (1):
      PM / OPP: Add missing of_node_put(np)

Ulf Hansson (6):
      ACPI / PM: Remove stale function header
      PM / Domains: Rename genpd internals from pm_genpd_* to genpd_*
      ACPI / PM: Restore acpi_subsys_complete()
      ACPI / PM: Split code validating need for runtime resume in ->prepare=
()
      PM / sleep: Remove pm_complete_with_resume_check()
      PM / Domains: Fix genpd to deal with drivers returning 1 from ->prepa=
re()

Ville Syrj=C3=A4l=C3=A4 (1):
      ACPI / PM: Fix acpi_pm_notifier_lock vs flush_workqueue() deadlock

Viresh Kumar (6):
      PM / OPP: Move the OPP directory out of power/
      PM / OPP: Rename dev_pm_opp_register_put_opp_helper()
      PM / Domains: Add support to select performance-state of domains
      PM / OPP: Support updating performance state of device's power domain
      PM / OPP: Add dev_pm_opp_{un}register_get_pstate_helper()
      cpufreq: schedutil: Reset cached_raw_freq when not in sync with next_=
freq

Zumeng Chen (2):
      cpufreq: ti-cpufreq: kfree opp_data when failure
      cpufreq: ti-cpufreq: add missing of_node_put()

---------------

 Documentation/ABI/testing/sysfs-devices-power |  20 +-
 Documentation/acpi/lpit.txt                   |  25 +++
 Documentation/cpu-freq/cpufreq-stats.txt      |   3 +
 Documentation/driver-api/pm/devices.rst       |  61 +++++-
 Documentation/power/pci.txt                   |  33 +++
 Documentation/power/pm_qos_interface.txt      |  13 +-
 MAINTAINERS                                   |   4 +-
 arch/arm/common/locomo.c                      |  24 ---
 arch/arm/include/asm/hardware/locomo.h        |   2 -
 arch/arm/include/asm/topology.h               |   8 +
 arch/arm/mach-imx/mach-imx6q.c                |  88 +-------
 arch/arm/mach-shmobile/pm-rmobile.c           |   8 +-
 arch/arm64/include/asm/topology.h             |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/acpi/Kconfig                          |   5 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/acpi_lpit.c                      | 162 +++++++++++++++
 drivers/acpi/acpi_lpss.c                      |  95 ++++-----
 drivers/acpi/device_pm.c                      | 277 ++++++++++++++++------=
----
 drivers/acpi/internal.h                       |   6 +
 drivers/acpi/osl.c                            |  42 ++--
 drivers/acpi/scan.c                           |   1 +
 drivers/base/arch_topology.c                  |  29 ++-
 drivers/base/cpu.c                            |   3 +-
 drivers/base/dd.c                             |   2 +
 drivers/base/power/Makefile                   |   1 -
 drivers/base/power/domain.c                   | 226 ++++++++++++++-------
 drivers/base/power/domain_governor.c          |  73 ++++---
 drivers/base/power/generic_ops.c              |  23 ---
 drivers/base/power/main.c                     |  53 +++--
 drivers/base/power/qos.c                      |   5 +-
 drivers/base/power/runtime.c                  |   9 +-
 drivers/base/power/sysfs.c                    |  53 ++---
 drivers/base/power/wakeup.c                   |  11 +-
 drivers/cpufreq/arm_big_little.c              |  16 +-
 drivers/cpufreq/arm_big_little.h              |   4 +-
 drivers/cpufreq/arm_big_little_dt.c           |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   3 -
 drivers/cpufreq/cpufreq-dt.c                  |  12 +-
 drivers/cpufreq/cpufreq.c                     |   6 +
 drivers/cpufreq/cpufreq_stats.c               |   7 +-
 drivers/cpufreq/imx6q-cpufreq.c               |  85 ++++++--
 drivers/cpufreq/powernow-k8.c                 |   2 +-
 drivers/cpufreq/pxa2xx-cpufreq.c              | 191 ++++--------------
 drivers/cpufreq/scpi-cpufreq.c                |   2 +-
 drivers/cpufreq/spear-cpufreq.c               |   4 +-
 drivers/cpufreq/speedstep-lib.c               |   2 +-
 drivers/cpufreq/ti-cpufreq.c                  |   6 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c        |   2 +-
 drivers/cpuidle/cpuidle-arm.c                 | 153 ++++++++------
 drivers/cpuidle/cpuidle.c                     |  14 +-
 drivers/cpuidle/governors/ladder.c            |   7 +
 drivers/cpuidle/governors/menu.c              |   4 +-
 drivers/devfreq/devfreq.c                     | 139 +++++++++----
 drivers/devfreq/exynos-bus.c                  |   5 +-
 drivers/devfreq/governor_passive.c            |   2 +-
 drivers/devfreq/governor_performance.c        |   2 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |   2 +-
 drivers/devfreq/governor_userspace.c          |   2 +-
 drivers/devfreq/rk3399_dmc.c                  |   2 +-
 drivers/gpu/drm/i915/i915_drv.c               |   2 +-
 drivers/idle/intel_idle.c                     |  23 ++-
 drivers/misc/mei/pci-me.c                     |   2 +-
 drivers/misc/mei/pci-txe.c                    |   2 +-
 drivers/opp/Kconfig                           |  13 ++
 drivers/{base/power =3D> }/opp/Makefile         |   0
 drivers/{base/power =3D> }/opp/core.c           | 143 ++++++++++++-
 drivers/{base/power =3D> }/opp/cpu.c            |   0
 drivers/{base/power =3D> }/opp/debugfs.c        |  10 +-
 drivers/{base/power =3D> }/opp/of.c             |   6 +-
 drivers/{base/power =3D> }/opp/opp.h            |   6 +
 drivers/pci/pci-driver.c                      | 134 +++++++++----
 drivers/pci/pci.c                             |   3 +-
 drivers/power/avs/smartreflex.c               |  10 +-
 drivers/soc/mediatek/mtk-scpsys.c             |  14 +-
 drivers/soc/rockchip/pm_domains.c             |  14 +-
 include/acpi/acpiosxf.h                       |   2 +
 include/linux/acpi.h                          |  30 ++-
 include/linux/arch_topology.h                 |  17 +-
 include/linux/cpufreq.h                       |   3 +
 include/linux/devfreq.h                       |  16 +-
 include/linux/device.h                        |  15 +-
 include/linux/freezer.h                       |   2 +-
 include/linux/pci.h                           |   7 +-
 include/linux/pm.h                            |  31 ++-
 include/linux/pm_domain.h                     |  20 +-
 include/linux/pm_opp.h                        |  14 +-
 include/linux/pm_qos.h                        |  27 ++-
 kernel/power/Kconfig                          |  14 --
 kernel/power/qos.c                            |   4 +-
 kernel/power/snapshot.c                       |  35 ++--
 kernel/power/suspend.c                        |   2 +-
 kernel/power/swap.c                           | 128 ++++++------
 kernel/sched/cpufreq_schedutil.c              |   6 +-
 tools/power/cpupower/.gitignore               |   3 +-
 tools/power/cpupower/Makefile                 |   6 +
 tools/power/cpupower/utils/cpufreq-info.c     |   2 -
 99 files changed, 1758 insertions(+), 1063 deletions(-)
