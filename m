Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH RESEND v4 0/9] PCI: Fixes and cleanups for native PCIe and ACPI hotplug
Date: Tue,  3 Apr 2018 17:52:16 +0300
Message-Id: <20180403145225.22371-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Resending this with linux-pci ML address corrected]

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
another. More detailed explanation is in changelog of patch [4/9].

This series fixes this issue and in addition includes fixes for few other
issues found during testing on a system that has Thunderbolt controller in
native PCIe enumeration mode. However, the fixes here are not in any way
Thunderbolt specific and should be applicable to other systems as well.

The previous versions of the patch series can be found here:

  v3: https://www.spinics.net/lists/linux-acpi/msg80876.html
  v2: https://www.spinics.net/lists/linux-pci/msg69186.html
  v1: https://www.spinics.net/lists/linux-acpi/msg80607.html

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

Mika Westerberg (9):
  PCI: Take all bridges into account when calculating bus numbers for extension
  PCI: Take bridge window alignment into account when distributing resources
  PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
  ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used
  ACPI / hotplug / PCI: Mark stale PCI devices disconnected
  PCI: Move resource distribution for a single bridge outside of the loop
  PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()
  PCI: Improve "partially hidden behind bridge" log message
  ACPI / hotplug / PCI: Drop unnecessary parentheses

 drivers/pci/hotplug/acpiphp.h      |  1 +
 drivers/pci/hotplug/acpiphp_glue.c | 82 ++++++++++++++++++++++++++++++--------
 drivers/pci/hotplug/pciehp.h       |  2 +-
 drivers/pci/hotplug/pciehp_core.c  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c   | 13 +++++-
 drivers/pci/probe.c                | 33 +++++++++------
 drivers/pci/setup-bus.c            | 69 ++++++++++++++++++++++++++------
 7 files changed, 158 insertions(+), 44 deletions(-)

-- 
2.16.2

