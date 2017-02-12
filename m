Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Message-Id: <cover.1486913733.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Feb 2017 17:07:45 +0100
Subject: [PATCH v6 0/8] Runtime PM for Thunderbolt on Macs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Erik Veijola <erik.veijola@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Keith Busch <keith.busch@intel.com>, Yinghai Lu <yinghai@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

Power down Thunderbolt controllers on Macs when nothing is plugged in
to save around 2W per controller and fix a power regression introduced
in v3.17 that affects millions of machines (all Macs with Thunderbolt)


Changes since v5:

- Patch [1/8] ("PCI: Recognize Thunderbolt devices"):
  Rename set_pcie_vendor_specific() (Bjorn Helgaas)

- Patch [3/8] ("PCI: pciehp: Reinstate runtime PM on Thunderbolt hotplug
  ports"):  Modified version of reverted patch

- Patch [7/8] ("thunderbolt: Power down controller when idle"):
  Add comment explaining use of pr_*() instead of dev_*(), drop unnecessary
  initialization (Bjorn Helgaas)

- Polish commit messages


Link to v5:
https://lkml.org/lkml/2017/1/15/180

Browse the patches on GitHub:
https://github.com/l1k/linux/commits/thunderbolt_runpm_v6


Thanks,

Lukas


Chen Yu (1):
  PM / sleep: Define constant for direct_complete

Lukas Wunner (7):
  PCI: Recognize Thunderbolt devices
  PCI: Allow runtime PM on Thunderbolt ports
  PCI: pciehp: Reinstate runtime PM on Thunderbolt hotplug ports
  Revert "PM / Runtime: Remove the exported function
    pm_children_suspended()"
  PM: Make requirements of dev_pm_domain_set() more precise
  thunderbolt: Power down controller when idle
  thunderbolt: Runtime suspend NHI when idle

 drivers/base/power/common.c       |  15 +-
 drivers/base/power/runtime.c      |   3 +-
 drivers/pci/hotplug/pciehp_ctrl.c |  13 +-
 drivers/pci/pci.c                 |  20 ++-
 drivers/pci/pci.h                 |   2 +
 drivers/pci/probe.c               |  32 ++++
 drivers/thunderbolt/Kconfig       |   3 +-
 drivers/thunderbolt/Makefile      |   4 +-
 drivers/thunderbolt/nhi.c         |   5 +
 drivers/thunderbolt/power.c       | 359 ++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h       |  37 ++++
 drivers/thunderbolt/switch.c      |   9 +
 drivers/thunderbolt/tb.c          |  13 ++
 drivers/thunderbolt/tb.h          |   2 +
 include/linux/pci.h               |   1 +
 include/linux/pm.h                |   7 +
 include/linux/pm_runtime.h        |   7 +
 17 files changed, 515 insertions(+), 17 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

-- 
2.11.0
