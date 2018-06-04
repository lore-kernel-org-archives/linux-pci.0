Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Jun 2018 13:25:50 +0200
Message-ID: <CAJZ5v0jRraYJ6e3UbEtf6514KPLaF5sGoKRy_c--ddxvSgGv3w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc1

with top-most commit a24e16b1310ce7f474aa0caca0e66f0f174c022f

 Merge branches 'pm-pci', 'acpi-pm', 'pm-sleep' and 'pm-avs'

on top of commit 0512e0134582ef85dee77d51aae77dcd1edec495

 Merge tag 'xfs-4.17-fixes-3' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux

to receive the first batch of power management updates for 4.18-rc1.

These include a significant update of the generic power domains (genpd)
and Operating Performance Points (OPP) frameworks, mostly related to
the introduction of power domain performance levels, cpufreq updates
(new driver for Qualcomm Kryo processors, updates of the existing
drivers, some core fixes, schedutil governor improvements), PCI power
management fixes, ACPI workaround for EC-based wakeup events handling
on resume from suspend-to-idle, and major updates of the turbostat
and pm-graph utilities.

Specifics:

 - Introduce power domain performance levels into the the generic
   power domains (genpd) and Operating Performance Points (OPP)
   frameworks (Viresh Kumar, Rajendra Nayak, Dan Carpenter).

 - Fix two issues in the runtime PM framework related to the
   initialization and removal of devices using device links (Ulf
   Hansson).

 - Clean up the initialization of drivers for devices in PM domains
   (Ulf Hansson, Geert Uytterhoeven).

 - Fix a cpufreq core issue related to the policy sysfs interface
   causing CPU online to fail for CPUs sharing one cpufreq policy in
   some situations (Tao Wang).

 - Make it possible to use platform-specific suspend/resume hooks
   in the cpufreq-dt driver and make the Armada 37xx DVFS use that
   feature (Viresh Kumar, Miquel Raynal).

 - Optimize policy transition notifications in cpufreq (Viresh Kumar).

 - Improve the iowait boost mechanism in the schedutil cpufreq
   governor (Patrick Bellasi).

 - Improve the handling of deferred frequency updates in the
   schedutil cpufreq governor (Joel Fernandes, Dietmar Eggemann,
   Rafael Wysocki, Viresh Kumar).

 - Add a new cpufreq driver for Qualcomm Kryo (Ilia Lin).

 - Fix and clean up some cpufreq drivers (Colin Ian King, Dmitry
   Osipenko, Doug Smythies, Luc Van Oostenryck, Simon Horman,
   Viresh Kumar).

 - Fix the handling of PCI devices with the DPM_SMART_SUSPEND flag
   set and update stale comments in the PCI core PM code (Rafael
   Wysocki).

 - Work around an issue related to the handling of EC-based wakeup
   events in the ACPI PM core during resume from suspend-to-idle if
   the EC has been put into the low-power mode (Rafael Wysocki).

 - Improve the handling of wakeup source objects in the PM core (Doug
   Berger, Mahendran Ganesh, Rafael Wysocki).

 - Update the driver core to prevent deferred probe from breaking
   suspend/resume ordering (Feng Kan).

 - Clean up the PM core somewhat (Bjorn Helgaas, Ulf Hansson, Rafael
   Wysocki).

 - Make the core suspend/resume code and cpufreq support the RT patch
   (Sebastian Andrzej Siewior, Thomas Gleixner).

 - Consolidate the PM QoS handling in cpuidle governors (Rafael
   Wysocki).

 - Fix a possible crash in the hibernation core (Tetsuo Handa).

 - Update the rockchip-io Adaptive Voltage Scaling (AVS) driver
   (David Wu).

 - Update the turbostat utility (fixes, cleanups, new CPU IDs, new
   command line options, built-in "Low Power Idle" counters support,
   new POLL and POLL% columns) and add an entry for it to MAINTAINERS
   (Len Brown, Artem Bityutskiy, Chen Yu, Laura Abbott, Matt Turner,
   Prarit Bhargava, Srinivas Pandruvada).

 - Update the pm-graph to version 5.1 (Todd Brandt).

 - Update the intel_pstate_tracer utility (Doug Smythies).

Thanks!


---------------

Artem Bityutskiy (4):
      tools/power turbostat: fix Skylake Xeon package C-state display
      tools/power turbostat: fix printing on input
      tools/power turbostat: dump BDX, SKX automatic C-state conversion bit
      tools/power turbostat: a small C-states dump readability immprovement

Bjorn Helgaas (3):
      PM / core: Remove unused initcall_debug_report() arguments
      PM / core: Simplify initcall_debug_report() timing
      PM / core: Use dev_printk() and symbols in suspend/resume diagnostics

Chen Yu (1):
      tools/power turbostat: if --num_iterations, print for specific
number of iterations

Colin Ian King (1):
      cpufreq: s3c2440: fix spelling mistake: "divsiors" -> "divisors"

Dan Carpenter (1):
      PM / OPP: silence an uninitialized variable warning

David Wu (1):
      PM / AVS: rockchip-io: add io selectors and supplies for PX30

Dietmar Eggemann (1):
      Revert "cpufreq: schedutil: Don't restrict kthread to
related_cpus unnecessarily"

Dmitry Osipenko (11):
      cpufreq: tegra20: Change module description
      cpufreq: tegra20: Clean up whitespaces in the code
      cpufreq: tegra20: Clean up included headers
      cpufreq: tegra20: Remove EMC clock usage
      cpufreq: tegra20: Release clocks properly
      cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
      cpufreq: tegra20: Remove unnecessary parentheses
      cpufreq: tegra20: Remove unneeded variable initialization
      cpufreq: tegra20: Check if this is Tegra20 machine
      cpufreq: tegra20: Allow cpufreq driver to be built as loadable module
      cpufreq: tegra20: Wrap cpufreq into platform driver

Doug Berger (1):
      PM / wakeup: Only update last time for active wakeup sources

Doug Smythies (2):
      cpufreq: intel_pstate: allow trace in passive mode
      tools/power/x86/intel_pstate_tracer: Add optional setting of
trace buffer memory allocation

Feng Kan (1):
      PM / core: fix deferred probe breaking suspend resume order

Geert Uytterhoeven (1):
      PM / domains: Improve wording of dev_pm_domain_attach() comment

Ilia Lin (2):
      cpufreq: Add Kryo CPU scaling driver
      dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu

Joel Fernandes (Google) (1):
      schedutil: Allow cpufreq requests to be made even when kthread kicked

Laura Abbott (1):
      tools/power turbostat: Don't make man pages executable

Len Brown (15):
      MAINTAINERS: add turbostat utility
      tools/power turbostat: add --enable Time_Of_Day_Seconds
      tools/power turbostat: on SIGINT: sample, print and exit
      tools/power turbostat: on SIGUSR1: sample, print and continue
      tools/power turbostat: end current interval upon newline input
      tools/power turbostat: fix  MSR_IA32_MISC_ENABLE MWAIT printout
      tools/power turbostat: fix possible sprintf buffer overflow
      tools/power turbostat: do not hard-code 25MHz crystal on SKX
      tools/power turbostat: remove blank lines
      tools/power turbostat: Build-in "Low Power Idle" counters support
      tools/power turbostat: Fix --hide Pk%pc10
      tools/power turbostat: add POLL and POLL% column
      tools/power turbostat: delete duplicate #defines
      tools/power turbostat: Fix node and siblings lookup data
      tools/power turbostat: update version number

Luc Van Oostenryck (1):
      cpufreq: speedstep: fix speedstep_detect_processor()'s return type

Mahendran Ganesh (1):
      PM / wakeup: Use seq_open() to show wakeup stats

Matt Turner (2):
      tools/power turbostat: Correct SNB_C1/C3_AUTO_UNDEMOTE defines
      x86: msr-index.h: Correct SNB_C1/C3_AUTO_UNDEMOTE defines

Miquel Raynal (1):
      cpufreq: add suspend/resume support in Armada 37xx DVFS driver

Patrick Bellasi (2):
      cpufreq: schedutil: Fix iowait boost reset
      cpufreq: schedutil: Cleanup and document iowait boost

Prarit Bhargava (7):
      tools/power turbostat: set max_num_cpus equal to the cpumask length
      tools/power turbostat: Calculate additional node information for a package
      tools/power turbostat: track thread ID in cpu_topology
      tools/power turbostat: rename num_cores_per_pkg to num_cores_per_node
      tools/power turbostat: remove num_ from cpu_topology struct
      tools/power turbostat: add node information into turbostat calculations
      tools/power turbostat: Add Node in output

Rafael J. Wysocki (9):
      PCI / PM: Do not clear state_saved for devices that remain suspended
      PCI / PM: Clean up outdated comments in pci_target_state()
      PM: wakeup: Use pr_debug() for the "aborting suspend" message
      cpufreq: schedutil: Avoid missing updates for one-CPU policies
      ACPICA: Introduce acpi_dispatch_gpe()
      ACPI: EC: Dispatch the EC GPE directly on s2idle wake
      PM / QoS: Drop redundant declaration of pm_qos_get_value()
      cpuidle: governors: Drop redundant checks related to PM QoS
      cpuidle: governors: Consolidate PM QoS handling

Rajendra Nayak (1):
      PM / domains: Add perf_state attribute to genpd debugfs

Sebastian Andrzej Siewior (5):
      PM / wakeup: Make events_lock a RAW_SPINLOCK
      PM / s2idle: Make s2idle_wait_head swait based
      PM / wakeup: Make s2idle_lock a RAW_SPINLOCK
      kernel/SRCU: provide a static initializer
      cpufreq: Use static SRCU initializer

Simon Horman (2):
      Revert "cpufreq: dt: Add r8a7796 support to to use generic cpufreq driver"
      Revert "cpufreq: rcar: Add support for R8A7795 SoC"

Srinivas Pandruvada (1):
      tools/power turbostat: Add Cannon Lake support

Tao Wang (1):
      cpufreq: Fix new policy initialization during limits updates via sysfs

Tetsuo Handa (1):
      PM / hibernate: Fix oops at snapshot_write()

Thomas Gleixner (1):
      PM / suspend: Prevent might sleep splats

Todd E Brandt (1):
      PM / tools: pm-graph: upgrade to v5.1

Ulf Hansson (22):
      PM / core: Drop internal unused inline functions for wakeups
      PM / core: Drop unused internal inline functions for wakeirqs
      PM / core: Drop unused internal functions for pm_qos sysfs
      PM / core: Drop unused internal inline functions for sysfs
      PM / Domains: Fix error path during attach in genpd
      PM / Domains: Drop comment in genpd about legacy Samsung DT binding
      PM / Domains: Drop redundant code in genpd while attaching devices
      PM / Domains: Check for existing PM domain in dev_pm_domain_attach()
      PM / Domains: Allow a better error handling of dev_pm_domain_attach()
      amba: Respect all error codes from dev_pm_domain_attach()
      driver core: Respect all error codes from dev_pm_domain_attach()
      i2c: Respect all error codes from dev_pm_domain_attach()
      mmc: sdio: Respect all error codes from dev_pm_domain_attach()
      soundwire: Respect all error codes from dev_pm_domain_attach()
      spi: Respect all error codes from dev_pm_domain_attach()
      PM / Domains: Don't return -EEXIST at attach when PM domain exists
      PM / runtime: Fixup reference counting of device link suppliers at probe
      PM / runtime: Drop usage count for suppliers at device link removal
      PM / Domains: Drop extern declarations of functions in pm_domain.h
      PM / Domains: Drop __pm_genpd_add_device()
      PM / Domains: Drop genpd as in-param for pm_genpd_remove_device()
      PM / Domains: Drop unused parameter in genpd_allocate_dev_data()

Viresh Kumar (23):
      soc/tegra: pmc: Don't allocate struct tegra_powergate on stack
      PM / OPP: dt-bindings: Rename "required-opp" as "required-opps"
      PM / OPP: dt-bindings: Make "opp-hz" optional for power domains
      PM / OPP: "opp-hz" is optional for power domains
      PM / OPP: Implement dev_pm_opp_of_add_table_indexed()
      PM / OPP: Implement of_dev_pm_opp_find_required_opp()
      PM / OPP: Implement dev_pm_opp_get_of_node()
      PM / Domain: Add struct device to genpd
      PM / Domain: Add support to parse domain's OPP table
      PM / Domain: Implement of_genpd_opp_to_performance_state()
      PM / OPP: Get performance state using genpd helper
      PM / OPP: Remove dev_pm_opp_{un}register_get_pstate_helper()
      cpufreq: dt: Allow platform specific suspend/resume callbacks
      cpufreq: armada: Free resources on error paths
      cpufreq: optimize cpufreq_notify_transition()
      cpufreq: schedutil: Don't set next_freq to UINT_MAX
      PM / OPP: Fix shared OPP table support in dev_pm_opp_set_supported_hw()
      PM / OPP: Fix shared OPP table support in dev_pm_opp_set_prop_name()
      PM / OPP: Fix shared OPP table support in dev_pm_opp_set_regulators()
      PM / OPP: Fix shared OPP table support in
dev_pm_opp_register_set_opp_helper()
      cpufreq: Rename cpufreq_can_do_remote_dvfs()
      PM / Domain: Return 0 on error from of_genpd_opp_to_performance_state()
      OPP: Allow same OPP table to be used for multiple genpd

---------------

 .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++
 Documentation/devicetree/bindings/opp/opp.txt      |   7 +-
 .../devicetree/bindings/power/power_domain.txt     |   6 +-
 .../bindings/power/rockchip-io-domain.txt          |  15 +
 MAINTAINERS                                        |  16 +
 arch/x86/include/asm/msr-index.h                   |   4 +-
 drivers/acpi/acpica/evgpe.c                        |   6 +
 drivers/acpi/acpica/evxfgpe.c                      |  22 +
 drivers/acpi/device_pm.c                           |   9 +-
 drivers/acpi/ec.c                                  |   6 +
 drivers/acpi/internal.h                            |   1 +
 drivers/acpi/sleep.c                               |   7 +
 drivers/amba/bus.c                                 |   4 +-
 drivers/base/base.h                                |   3 +
 drivers/base/core.c                                |  20 +
 drivers/base/dd.c                                  |   7 +-
 drivers/base/platform.c                            |  17 +-
 drivers/base/power/common.c                        |  10 +-
 drivers/base/power/domain.c                        | 212 +++--
 drivers/base/power/main.c                          |  37 +-
 drivers/base/power/power.h                         |  30 -
 drivers/base/power/runtime.c                       |  29 +-
 drivers/base/power/wakeup.c                        |  96 ++-
 drivers/cpufreq/Kconfig.arm                        |  13 +-
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c              | 100 ++-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +-
 drivers/cpufreq/cpufreq-dt.c                       |  10 +-
 drivers/cpufreq/cpufreq-dt.h                       |   5 +
 drivers/cpufreq/cpufreq.c                          |  78 +-
 drivers/cpufreq/cpufreq_governor.c                 |   2 +-
 drivers/cpufreq/intel_pstate.c                     |  46 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 212 +++++
 drivers/cpufreq/s3c2440-cpufreq.c                  |   2 +-
 drivers/cpufreq/speedstep-lib.c                    |   2 +-
 drivers/cpufreq/tegra20-cpufreq.c                  | 200 +++--
 drivers/cpuidle/governor.c                         |  17 +-
 drivers/cpuidle/governors/ladder.c                 |  10 +-
 drivers/cpuidle/governors/menu.c                   |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   2 +-
 drivers/i2c/i2c-core-base.c                        |   2 +-
 drivers/mmc/core/sdio_bus.c                        |   2 +-
 drivers/opp/core.c                                 | 267 ++----
 drivers/opp/debugfs.c                              |  15 +-
 drivers/opp/of.c                                   | 184 ++++-
 drivers/opp/opp.h                                  |   6 +-
 drivers/pci/pci-driver.c                           |   5 +-
 drivers/pci/pci.c                                  |   6 +-
 drivers/power/avs/rockchip-io-domain.c             |  68 ++
 drivers/soc/tegra/pmc.c                            |  20 +-
 drivers/soundwire/bus_type.c                       |  15 +-
 drivers/spi/spi.c                                  |  11 +-
 include/acpi/acpixf.h                              |   1 +
 include/linux/acpi.h                               |   2 +-
 include/linux/cpufreq.h                            |   2 +-
 include/linux/cpuidle.h                            |   1 +
 include/linux/kernel.h                             |   1 +
 include/linux/notifier.h                           |  34 +-
 include/linux/pm_domain.h                          |  79 +-
 include/linux/pm_opp.h                             |  27 +-
 include/linux/pm_runtime.h                         |   6 +-
 include/linux/srcutiny.h                           |   6 +-
 include/linux/srcutree.h                           |   6 +-
 kernel/power/hibernate.c                           |   7 +
 kernel/power/qos.c                                 |   1 -
 kernel/power/suspend.c                             |  27 +-
 kernel/power/user.c                                |   5 +
 kernel/power/wakelock.c                            |   1 +
 kernel/sched/cpufreq_schedutil.c                   | 262 ++++--
 kernel/time/tick-common.c                          |   2 +
 tools/power/pm-graph/bootgraph.py                  |   2 +-
 tools/power/pm-graph/sleepgraph.8                  |   4 +
 tools/power/pm-graph/sleepgraph.py                 | 399 +++++----
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  54 +-
 tools/power/x86/turbostat/Makefile                 |   2 +-
 tools/power/x86/turbostat/turbostat.8              |  26 +-
 tools/power/x86/turbostat/turbostat.c              | 908 +++++++++++++++------
 tools/power/x86/x86_energy_perf_policy/Makefile    |   2 +-
 78 files changed, 3235 insertions(+), 1192 deletions(-)
