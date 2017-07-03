Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jul 2017 23:48:58 +0200
Message-ID: <CAJZ5v0h2OXNS3xOWHOs4dM6RXd9zY8LzT4JR6joeZ9UqmCyH+w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.13-rc1
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
 pm-4.13-rc1

with top-most commit 8f8e5c3e2796eaf150d6262115af12707c2616dd

 Merge branch 'acpi-pm'

on top of commit c0bc126f97fb929b3ae02c1c62322645d70eb408

 Linux 4.12-rc7

to receive power management updates for v4.13-rc1.

The big ticket items here are the rework of suspend-to-idle in order
to add proper support for power button wakeup from it on recent Dell
laptops and the rework of interfaces exporting the current CPU
frequency on x86.

In addition to that, support for a few new pieces of hardware is
added, the PCI/ACPI device wakeup infrastructure is simplified
significantly and the wakeup IRQ framework is fixed to unbreak the
IRQ bus locking infrastructure.

Also, there are some functional improvements for intel_pstate,
tools updates and small fixes and cleanups all over.

The uuid-types branch from the Christoph's tree at
git://git.infradead.org/users/hch/uuid.git (not shown in the appended
stats) is included to satisfy dependencies in the new ACPI PM code
related to the suspend-to-idle rework.

Specifics:

 - Rework suspend-to-idle to allow it to take wakeup events signaled
   by the EC into account on ACPI-based platforms in order to properly
   support power button wakeup from suspend-to-idle on recent Dell
   laptops (Rafael Wysocki).

   That includes the core suspend-to-idle code rework, support for
   the Low Power S0 _DSM interface, and support for the ACPI INT0002
   Virtual GPIO device from Hans de Goede (required for USB keyboard
   wakeup from suspend-to-idle to work on some machines).

 - Stop trying to export the current CPU frequency via /proc/cpuinfo
   on x86 as that is inaccurate and confusing (Len Brown).

 - Rework the way in which the current CPU frequency is exported by
   the kernel (over the cpufreq sysfs interface) on x86 systems with
   the APERF and MPERF registers by always using values read from
   these registers, when available, to compute the current frequency
   regardless of which cpufreq driver is in use (Len Brown).

 - Rework the PCI/ACPI device wakeup infrastructure to remove the
   questionable and artificial distinction between "devices that
   can wake up the system from sleep states" and "devices that can
   generate wakeup signals in the working state" from it, which
   allows the code to be simplified quite a bit (Rafael Wysocki).

 - Fix the wakeup IRQ framework by making it use SRCU instead of
   RCU which doesn't allow sleeping in the read-side critical
   sections, but which in turn is expected to be allowed by the
   IRQ bus locking infrastructure (Thomas Gleixner).

 - Modify some computations in the intel_pstate driver to avoid
   rounding errors resulting from them (Srinivas Pandruvada).

 - Reduce the overhead of the intel_pstate driver in the HWP
   (hardware-managed P-states) mode and when the "performance"
   P-state selection algorithm is in use by making it avoid
   registering scheduler callbacks in those cases (Len Brown).

 - Rework the energy_performance_preference sysfs knob in
   intel_pstate by changing the values that correspond to
   different symbolic hint names used by it (Len Brown).

 - Make it possible to use more than one cpuidle driver at the same
   time on ARM (Daniel Lezcano).

 - Make it possible to prevent the cpuidle menu governor from using
   the 0 state by disabling it via sysfs (Nicholas Piggin).

 - Add support for FFH (Fixed Functional Hardware) MWAIT in ACPI C1
   on AMD systems (Yazen Ghannam).

 - Make the CPPC cpufreq driver take the lowest nonlinear performance
   information into account (Prashanth Prakash).

 - Add support for hi3660 to the cpufreq-dt driver, fix the
   imx6q driver and clean up the sfi, exynos5440 and intel_pstate
   drivers (Colin Ian King, Krzysztof Kozlowski, Octavian Purdila,
   Rafael Wysocki, Tao Wang).

 - Fix a few minor issues in the generic power domains (genpd)
   framework and clean it up somewhat (Krzysztof Kozlowski,
   Mikko Perttunen, Viresh Kumar).

 - Fix a couple of minor issues in the operating performance points
   (OPP) framework and clean it up somewhat (Viresh Kumar).

 - Fix a CONFIG dependency in the hibernation core and clean it up
   slightly (Balbir Singh, Arvind Yadav, BaoJun Luo).

 - Add rk3228 support to the rockchip-io adaptive voltage scaling
   (AVS) driver (David Wu).

 - Fix an incorrect bit shift operation in the RAPL power capping
   driver (Adam Lessnau).

 - Add support for the EPP field in the HWP (hardware managed
   P-states) control register, HWP.EPP, to the x86_energy_perf_policy
   tool and update msr-index.h with HWP.EPP values (Len Brown).

 - Fix some minor issues in the turbostat tool (Len Brown).

 - Add support for AMD family 0x17 CPUs to the cpupower tool and fix
   a minor issue in it (Sherry Hurwitz).

 - Assorted cleanups, mostly related to the constification of some
   data structures (Arvind Yadav, Joe Perches, Kees Cook, Krzysztof
   Kozlowski).

Thanks!


---------------

Adam Lessnau (1):
      powercap/RAPL: prevent overridding bits outside of the mask

Arvind Yadav (2):
      PM / QoS: constify *_attribute_group.
      PM: hibernate: constify attribute_group structures.

Balbir Singh (1):
      PM / hibernate: Use CONFIG_HAVE_SET_MEMORY for include condition

BaoJun Luo (1):
      PM / hibernate: Drop redundant parameter of swsusp_alloc()

Colin Ian King (1):
      cpufreq: sfi: make freq_table static

Daniel Lezcano (1):
      ARM: cpuidle: Support asymmetric idle definition

David Wu (1):
      PM / AVS: rockchip-io: add io selectors and supplies for rk3228

Hans de Goede (1):
      platform/x86: Add driver for ACPI INT0002 Virtual GPIO device

Joe Perches (1):
      intel_idle: Use more common logging style

Kees Cook (1):
      x86/power/64: Use char arrays for asm function names

Krzysztof Kozlowski (10):
      cpufreq: exynos5440: Fix inconsistent indenting
      PM / Domains: Constify genpd pointer
      PM: Constify returned PM event name
      PM: Constify info string used in messages
      PM / sysfs: Constify attribute groups
      PM / Domains: Handle safely genpd_syscore_switch() call on
non-genpd device
      PM / Domains: Fix unsafe iteration over modified list of device links
      PM / Domains: Fix unsafe iteration over modified list of domain providers
      PM / Domains: Fix unsafe iteration over modified list of domains
      PM / Domains: Fix missing default_power_down_ok comment

Len Brown (14):
      x86: msr-index.h: define EPB mid-points
      x86: msr-index.h: define HWP.EPP values
      x86: msr-index.h: fix shifts to ULL results in HWP macros.
      tools/power x86_energy_perf_policy: support HWP.EPP
      intel_pstate: use updated msr-index.h HWP.EPP values
      x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
      tools/power turbostat: hide SKL counters, when not requested
      tools/power turbostat: if  --debug, print sampling overhead
      tools/power turbostat: stop migrating, unless '-m'
      tools/power turbostat: decode MSR_IA32_MISC_ENABLE only on Intel
      tools/power turbostat: update version number
      x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
      intel_pstate: delete scheduler hook in HWP mode
      intel_pstate: skip scheduler hook when in "performance" mode

Mikko Perttunen (1):
      PM / Domains: Call driver's noirq callbacks

Nicholas Piggin (1):
      cpuidle: menu: allow state 0 to be disabled

Octavian Purdila (1):
      cpufreq: imx6q: imx6ull should use the same flow as imx6ul

Prakash, Prashanth (1):
      cpufreq / CPPC: Initialize policy->min to lowest nonlinear performance

Rafael J. Wysocki (17):
      ACPI / PM: Run wakeup notify handlers synchronously
      USB / PCI / PM: Allow the PCI core to do the resume cleanup
      ACPI / PM: Change log level of wakeup-related message
      ACPI / PM: Clean up device wakeup enable/disable code
      PM / sleep: Print timing information if debug is enabled
      PCI / PM: Restore PME Enable if skipping wakeup setup
      ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle
      platform: x86: intel-vbtn: Wake up the system from suspend-to-idle
      platform: x86: intel-hid: Wake up the system from suspend-to-idle
      ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems
      ACPI / PM: Drop run_wake from struct acpi_device_wakeup_flags
      ACPI / PM: Consolidate device wakeup settings code
      PCI / PM: Drop pme_interrupt flag from struct pci_dev
      PCI / PM: Simplify device wakeup settings code
      PM / core: Drop run_wake flag from struct dev_pm_info
      cpufreq: intel_pstate: Clean up after performance governor changes
      cpufreq: Update scaling_cur_freq documentation

Sherry Hurwitz (2):
      cpupower: Fix bug where return value was not used
      cpupower: Add support for new AMD family 0x17

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Remove max/min fractions to limit performance

Tao Wang (1):
      cpufreq: dt: Add support for hi3660

Thomas Gleixner (1):
      PM / wakeirq: Convert to SRCU

Viresh Kumar (7):
      PM / Domains: pdd->dev can't be NULL in genpd_dev_pm_qos_notifier()
      PM / OPP: Reorganize _generic_set_opp_regulator()
      PM / OPP: Don't create copy of regulators unnecessarily
      PM / OPP: opp-microvolt is not optional if regulators are set
      PM / OPP: Don't create debugfs "supply-0" directory unnecessarily
      PM / OPP: Use - instead of @ for DT entries
      PM / OPP: Add dev_pm_opp_{set|put}_clkname()

Yazen Ghannam (1):
      x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD systems

---------------

 Documentation/admin-guide/pm/cpufreq.rst           |   12 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |    6 +-
 Documentation/devicetree/bindings/opp/opp.txt      |   38 +-
 .../bindings/power/rockchip-io-domain.txt          |    7 +
 Documentation/power/runtime_pm.txt                 |    7 +-
 arch/x86/include/asm/msr-index.h                   |   18 +-
 arch/x86/include/asm/suspend_64.h                  |    5 +-
 arch/x86/kernel/acpi/cstate.c                      |    3 +-
 arch/x86/kernel/cpu/Makefile                       |    1 +
 arch/x86/kernel/cpu/aperfmperf.c                   |   79 +
 arch/x86/kernel/cpu/proc.c                         |   10 +-
 arch/x86/power/hibernate_64.c                      |    6 +-
 drivers/acpi/battery.c                             |    2 +-
 drivers/acpi/button.c                              |    5 +-
 drivers/acpi/device_pm.c                           |  102 +-
 drivers/acpi/ec.c                                  |    2 +-
 drivers/acpi/internal.h                            |    4 +
 drivers/acpi/pci_root.c                            |    5 +-
 drivers/acpi/proc.c                                |    4 +-
 drivers/acpi/scan.c                                |   23 +-
 drivers/acpi/sleep.c                               |  152 +-
 drivers/ata/libata-zpodd.c                         |    9 +-
 drivers/base/power/domain.c                        |  103 +-
 drivers/base/power/domain_governor.c               |   12 +-
 drivers/base/power/main.c                          |   40 +-
 drivers/base/power/opp/core.c                      |  154 +-
 drivers/base/power/opp/debugfs.c                   |    7 +-
 drivers/base/power/opp/of.c                        |   10 +-
 drivers/base/power/sysfs.c                         |   12 +-
 drivers/base/power/wakeup.c                        |   50 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   19 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    1 +
 drivers/cpufreq/cpufreq.c                          |   12 +-
 drivers/cpufreq/exynos5440-cpufreq.c               |    6 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |    6 +-
 drivers/cpufreq/intel_pstate.c                     |  172 ++-
 drivers/cpufreq/sfi-cpufreq.c                      |    2 +-
 drivers/cpuidle/Kconfig.arm                        |    1 +
 drivers/cpuidle/cpuidle-arm.c                      |   62 +-
 drivers/cpuidle/governors/menu.c                   |   20 +-
 drivers/idle/intel_idle.c                          |   32 +-
 drivers/pci/pci-acpi.c                             |   90 +-
 drivers/pci/pci-driver.c                           |    2 +-
 drivers/pci/pci-mid.c                              |   10 +-
 drivers/pci/pci.c                                  |   68 +-
 drivers/pci/pci.h                                  |    9 +-
 drivers/pci/pcie/pme.c                             |   16 +-
 drivers/platform/x86/Kconfig                       |   19 +
 drivers/platform/x86/Makefile                      |    1 +
 drivers/platform/x86/intel-hid.c                   |   40 +-
 drivers/platform/x86/intel-vbtn.c                  |   39 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |  219 +++
 drivers/pnp/pnpacpi/core.c                         |    6 +-
 drivers/power/avs/rockchip-io-domain.c             |   14 +
 drivers/powercap/intel_rapl.c                      |    4 +-
 drivers/usb/core/hcd-pci.c                         |    7 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    3 +-
 drivers/usb/host/uhci-pci.c                        |    2 +-
 include/acpi/acpi_bus.h                            |   29 +-
 include/linux/cpufreq.h                            |    2 +
 include/linux/pci.h                                |   10 +-
 include/linux/pm.h                                 |    1 -
 include/linux/pm_opp.h                             |    9 +
 include/linux/pm_runtime.h                         |   12 -
 include/linux/suspend.h                            |    7 +-
 kernel/power/hibernate.c                           |    2 +-
 kernel/power/process.c                             |    2 +-
 kernel/power/snapshot.c                            |   11 +-
 kernel/power/suspend.c                             |   35 +-
 tools/power/cpupower/utils/helpers/amd.c           |   31 +-
 tools/power/cpupower/utils/helpers/helpers.h       |    2 +
 tools/power/cpupower/utils/helpers/misc.c          |   23 +-
 tools/power/x86/turbostat/turbostat.c              |   94 +-
 tools/power/x86/x86_energy_perf_policy/Makefile    |   27 +-
 .../x86_energy_perf_policy.8                       |  241 +++-
 .../x86_energy_perf_policy.c                       | 1504 +++++++++++++++++---
 76 files changed, 2887 insertions(+), 925 deletions(-)
