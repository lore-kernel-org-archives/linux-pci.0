Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2015 01:28:23 +0100
Message-ID: <CAJZ5v0ji_y=MtkJATe9P9Qj0V1wukcQVK5G1=1wECfh9JCZg0w@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI updates for v4.4-rc1, part 2
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.4-rc1-2

to receive the second batch of power management and ACPI updates for
v4.4-rc1 with top-most commit f57ab32a843690fe7431ebb3a2f461e689a2e3c7

 Merge branch 'pm-tools'

on top of commit 0d51ce9ca1116e8f4dc87cb51db8dd250327e9bb

 Merge tag 'pm+acpi-4.4-rc1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

The only new feature in this batch is support for the ACPI _CCA
device configuration object, which it a pre-requisite for future
ACPI PCI support on ARM64, but should not affect the other
architectures.

The rest is fixes and cleanups, mostly in cpufreq (including
intel_pstate), the Operating Performace Points (OPP) framework
and tools (cpupower and turbostat).

Specifics:

 - Support for the ACPI _CCA configuration object intended to tell
   the OS whether or not a bus master device supports hardware
   managed cache coherency and a new set of functions to allow
   drivers to check the cache coherency support for devices in a
   platform firmware interface agnostic way (Suravee Suthikulpanit,
   Jeremy Linton).

 - ACPI backlight quirks for ESPRIMO Mobile M9410 and Dell XPS L421X
   (Aaron Lu, Hans de Goede).

 - Fixes for the arm_big_little and s5pv210-cpufreq cpufreq drivers
   (Jon Medhurst, Nicolas Pitre).

 - kfree()-related fixup for the recently introduced CPPC cpufreq
   frontend (Markus Elfring).

 - intel_pstate fix reducing kernel log noise on systems where
   P-states are managed by hardware (Prarit Bhargava).

 - intel_pstate maintainers information update (Srinivas Pandruvada).

 - cpufreq core optimization related to the handling of delayed work
   items used by governors (Viresh Kumar).

 - Locking fixes and cleanups of the Operating Performance Points
   (OPP) framework (Viresh Kumar).

 - Generic power domains framework cleanups (Lina Iyer).

 - cpupower tool updates (Jacob Tanenbaum, Sriram Raghunathan,
   Thomas Renninger).

 - turbostat tool updates (Len Brown).

Thanks!


PS
Please note that commit

  50230713b639 'PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()'

included here will conflict with commit

  f81c11af617c 'of/pci: Add of_pci_check_probe_only to parse
"linux,pci-probe-only"'

in your tree and appended is a patch used by Stephen to resolve that conflict.


---------------

Aaron Lu (1):
      ACPI / video: only register backlight for LCD device

Hans de Goede (1):
      ACPI / video: Add a quirk to force acpi-video backlight on Dell XPS L421X

Jacob Tanenbaum (1):
      cpupower: cpupower monitor reports uninitialized values for offline cpus

Jeremy Linton (1):
      ACPI: Honor ACPI _CCA attribute setting

Jon Medhurst (1):
      cpufreq: arm_big_little: fix frequency check when bL switcher is active

Len Brown (2):
      tools/power turbostat: simplify Bzy_MHz calculation
      tools/power turbostat: bugfix: print MAX_NON_TURBO_RATIO

Lina Iyer (2):
      PM / Domains: Remove dev->driver check for runtime PM
      PM / Domains: Allocate memory outside domain locks

Markus Elfring (1):
      cpufreq: CPPC: Delete an unnecessary check before the function
call kfree()

Nicolas Pitre (1):
      cpufreq: s5pv210-cpufreq: fix wrong do_div() usage

Prarit Bhargava (1):
      intel_pstate: decrease number of "HWP enabled" messages

Srinivas Pandruvada (1):
      MAINTAINERS: update for intel P-state driver

Sriram Raghunathan (1):
      Creating a common structure initialization pattern for struct option

Suravee Suthikulpanit (8):
      device property: Introducing enum dev_dma_attr
      ACPI: Adding DMA Attribute APIs for ACPI Device
      device property: Adding DMA Attribute APIs for Generic Devices
      device property: ACPI: Make use of the new DMA Attribute APIs
      device property: ACPI: Remove unused DMA APIs
      of/pci: Fix pci_get_host_bridge_device leak
      PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
      PCI: ACPI: Add support for PCI device DMA coherency

Thomas Renninger (2):
      cpupower: Remove debug message when using cpupower idle-set -D switch
      cpupower: Enable disabled Cstates if they are below max latency

Viresh Kumar (8):
      PM / OPP: Improve print messages with pr_fmt
      PM / OPP: Rename routines specific to old bindings with _v1
      PM / OPP: Parse all power-supply related bindings together
      cpufreq: governor: Quit work-handlers early if governor is stopped
      PM / OPP: Propagate error properly from dev_pm_opp_set_sharing_cpus()
      PM / OPP: Protect updates to list_dev with mutex
      PM / OPP: Hold dev_opp_list_lock for writers
      PM / OPP: Add opp_rcu_lockdep_assert() to _find_device_opp()

---------------

 MAINTAINERS                                        |  3 +-
 drivers/acpi/acpi_platform.c                       |  7 +-
 drivers/acpi/acpi_video.c                          | 78 ++++++++++++++++++----
 drivers/acpi/glue.c                                |  8 ++-
 drivers/acpi/scan.c                                | 42 ++++++++++++
 drivers/acpi/video_detect.c                        |  9 +++
 drivers/base/power/domain.c                        | 21 +++---
 drivers/base/power/opp/core.c                      | 44 ++++++++----
 drivers/base/power/opp/cpu.c                       | 13 ++--
 drivers/base/power/opp/opp.h                       |  3 +
 drivers/base/property.c                            | 32 ++++++---
 drivers/cpufreq/arm_big_little.c                   | 22 +++---
 drivers/cpufreq/cppc_cpufreq.c                     |  3 +-
 drivers/cpufreq/cpufreq_governor.c                 | 33 ++++++---
 drivers/cpufreq/intel_pstate.c                     | 10 +--
 drivers/cpufreq/s5pv210-cpufreq.c                  |  4 +-
 drivers/crypto/ccp/ccp-platform.c                  | 15 +++--
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |  8 ++-
 drivers/of/of_pci.c                                | 20 ------
 drivers/pci/probe.c                                | 32 ++++++++-
 include/acpi/acpi_bus.h                            | 36 +---------
 include/linux/acpi.h                               |  7 +-
 include/linux/of_pci.h                             |  3 -
 include/linux/property.h                           | 10 ++-
 tools/power/cpupower/debug/i386/dump_psb.c         |  2 +-
 tools/power/cpupower/man/cpupower-idle-set.1       |  4 +-
 tools/power/cpupower/utils/cpufreq-info.c          | 30 ++++-----
 tools/power/cpupower/utils/cpufreq-set.c           | 10 +--
 tools/power/cpupower/utils/cpuidle-info.c          |  4 +-
 tools/power/cpupower/utils/cpuidle-set.c           | 33 ++++-----
 tools/power/cpupower/utils/cpupower-info.c         |  4 +-
 tools/power/cpupower/utils/cpupower-set.c          |  2 +-
 tools/power/cpupower/utils/helpers/topology.c      | 23 ++++---
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |  9 ++-
 tools/power/x86/turbostat/turbostat.c              | 30 +++++----
 35 files changed, 405 insertions(+), 209 deletions(-)


---------------

 diff --cc drivers/of/of_pci.c
index ff27177f49ed,b66ee4ebf650..000000000000
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@@ -118,51 -117,6 +118,31 @@@ int of_get_pci_domain_nr(struct device_
  }
  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);

 +/**
 + * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
 + *                           is present and valid
 + */
 +void of_pci_check_probe_only(void)
 +{
 +    u32 val;
 +    int ret;
 +
 +    ret = of_property_read_u32(of_chosen, "linux,pci-probe-only", &val);
 +    if (ret) {
 +        if (ret == -ENODATA || ret == -EOVERFLOW)
 +            pr_warn("linux,pci-probe-only without valid value, ignoring\n");
 +        return;
 +    }
 +
 +    if (val)
 +        pci_add_flags(PCI_PROBE_ONLY);
 +    else
 +        pci_clear_flags(PCI_PROBE_ONLY);
 +
 +    pr_info("PCI: PROBE_ONLY %sabled\n", val ? "en" : "dis");
 +}
 +EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 +
- /**
-  * of_pci_dma_configure - Setup DMA configuration
-  * @dev: ptr to pci_dev struct of the PCI device
-  *
-  * Function to update PCI devices's DMA configuration using the same
-  * info from the OF node of host bridge's parent (if any).
-  */
- void of_pci_dma_configure(struct pci_dev *pci_dev)
- {
-     struct device *dev = &pci_dev->dev;
-     struct device *bridge = pci_get_host_bridge_device(pci_dev);
-
-     if (!bridge->parent)
-         return;
-
-     of_dma_configure(dev, bridge->parent->of_node);
-     pci_put_host_bridge_device(bridge);
- }
- EXPORT_SYMBOL_GPL(of_pci_dma_configure);
-
  #if defined(CONFIG_OF_ADDRESS)
  /**
   * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
diff --cc include/linux/of_pci.h
index 38c0533a3359,ce0e5abeb454..000000000000
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@@ -16,8 -16,6 +16,7 @@@ int of_pci_get_devfn(struct device_nod
  int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
  int of_get_pci_domain_nr(struct device_node *node);
- void of_pci_dma_configure(struct pci_dev *pci_dev);
 +void of_pci_check_probe_only(void);
  #else
  static inline int of_irq_parse_pci(const struct pci_dev *pdev,
struct of_phandle_args *out_irq)
  {
@@@ -52,10 -50,6 +51,8 @@@ of_get_pci_domain_nr(struct device_nod
  {
      return -1;
  }
 +
- static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
-
 +static inline void of_pci_check_probe_only(void) { }
  #endif

  #if defined(CONFIG_OF_ADDRESS)
