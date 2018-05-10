Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v6 00/12] PCI: Fixes and cleanups for native PCIe, SHPC and ACPI hotplug
Date: Thu, 10 May 2018 21:28:32 +0300
Message-Id: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

When Thunderbolt host router is configured to be in native enumeration mode
it is only present in the system if there is something connected to the
ports. This pretty much follows how the BIOS assisted mode works.

In native enumeration mode the Thunderbolt host controller (NHI) and USB
host controller (xHCI) are not hot-added using native PCIe hotplug but
instead they will be hotplugged via BIOS triggered ACPI Notify() to the
root port. This is done to preserve resources since NHI and xHCI only need
1 MB of MMIO space and no additional buses. Currently Linux does not
support this very well and ends up failing the hotplug in one way or
another. More detailed explanation is in changelog of patch [7/12].

This series fixes this issue and in addition includes fixes for few other
issues found during testing on a system that has Thunderbolt controller in
native PCIe enumeration mode. However, the fixes here are not in any way
Thunderbolt specific and should be applicable to other systems as well.

The previous versions of the patch series can be found here:

  v5: https://www.spinics.net/lists/linux-pci/msg71339.html
  v4: https://www.spinics.net/lists/linux-pci/msg71006.html
  v3: https://www.spinics.net/lists/linux-acpi/msg80876.html
  v2: https://www.spinics.net/lists/linux-pci/msg69186.html
  v1: https://www.spinics.net/lists/linux-acpi/msg80607.html

Changes from v5:

  - Dropped patch "PCI: Take bridge window alignment into account when
    distributing resources"
  - Rework pciehp_is_native() to be more stricter
  - Make standard PCI hotplug driver (SHPC) builtin
  - Rework the way we request OS control of native PCIe
    hotplug (pciehp) and standard PCI hotplug (SHPC)
  - Make acpiphp to avoid bridges where hotplug_is_native() returns true
    (this is combined from pciehp and SHPC)
  - Updated changelog of patch [7/12]
  - Use hotplug_bridges + normal_bridges == 1 in patch [9/12] and also
    remove one indent level from the loop.

Because patch [7/12] looks quite different now I dropped Reviewed-by and
stable tag (it now depends on reworked pciehp/SHCP support that most
probably is not suitable for stable trees).

I also was not able to test that SHPC really works because I don't have
hardware that supports it.

Changes from v4:

  - Updated message in patch [8/9] following Rafael's suggestion
  - Added Rafael's tag to patches 6, 7, 9.

Changes from v3:

  - Added Andy's tag to patches [1-5]
  - Improved changelog and subject line of patch [1/9] to match better what
    it is trying to solve
  - Improved comment in patch [1/9]
  - Improved changelog of patches [2/9] and [4/9] accordingly to match
    better why they are needed
  - Added cleanup patches [6-9/9]

Changes from v2:

  - Added Rafael's tag to patch [1/5]
  - Updated changelog of patch [1/5] to include more details about how the
    problem can be observed from dmesg and lspci output

Changes from v1:

  - Drop 'cmax - max ?: 1' and use similar construct than we use in second
    pass loop in patch [1/5]
  - Drop unnecessary parentheses in patch [1/5]
  - Added Rafael's tag to patches [2-5/5]

Mika Westerberg (12):
  PCI: Take all bridges into account when calculating bus numbers for extension
  PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
  PCI: Request control of native PCIe hotplug only if supported
  PCI: Make pciehp_is_native() stricter
  PCI: hotplug: Convert SHPC to be builtin only
  PCI: Request control of native SHPC hotplug similarly to pciehp
  ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used
  ACPI / hotplug / PCI: Mark stale PCI devices disconnected
  PCI: Move resource distribution for a single bridge outside of the loop
  PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()
  PCI: Improve "partially hidden behind bridge" log message
  ACPI / hotplug / PCI: Drop unnecessary parentheses

 drivers/acpi/pci_root.c            | 10 +++-
 drivers/pci/hotplug/Kconfig        |  5 +-
 drivers/pci/hotplug/acpi_pcihp.c   | 34 +++++-------
 drivers/pci/hotplug/acpiphp_glue.c | 84 +++++++++++++++++++++++-------
 drivers/pci/hotplug/pciehp.h       |  2 +-
 drivers/pci/hotplug/pciehp_core.c  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c   | 13 ++++-
 drivers/pci/hotplug/shpchp.h       | 11 ----
 drivers/pci/hotplug/shpchp_core.c  |  2 +-
 drivers/pci/pci-acpi.c             | 51 +++++++++++++-----
 drivers/pci/pcie/portdrv.h         |  2 -
 drivers/pci/pcie/portdrv_core.c    |  2 +-
 drivers/pci/probe.c                | 36 ++++++++-----
 drivers/pci/setup-bus.c            | 82 ++++++++++++++---------------
 include/linux/pci.h                |  5 +-
 include/linux/pci_hotplug.h        | 31 +++++++++--
 16 files changed, 237 insertions(+), 135 deletions(-)

-- 
2.17.0

