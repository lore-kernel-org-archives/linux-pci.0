Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:53132 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965066AbeBMQcE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Feb 2018 11:32:04 -0500
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/5] PCI: Fixes for native PCIe and ACPI hotplug
Date: Tue, 13 Feb 2018 19:31:55 +0300
Message-Id: <20180213163200.8787-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

When Thunderbolt controller is configured to be in native enumeration mode
it actually includes two slightly different modes. First there is non-RTD3
mode where the Thunderbolt host controller is only present when there is a
device connected. The second one is RTD3 mode where the controller is
always present.

In non-RTD3 mode the Thunderbolt host controller (NHI) and USB host (xHCI)
controller are not hotplugged using native PCIe hotplug but instead they
will be hotplugged via BIOS triggered ACPI Notify() to the root port. This
is done to preserve resources since the NHI and xHCI only need 1 MB of MMIO
space and no additional buses. Currently Linux does not support this very
well and ends up failing the hotplug in one way or another. More detailed
explanation is in changelog of patch [4/5].

This series fixes this issue and in addition includes fixes for few other
issues found during testing on a system that has Thunderbolt controller in
non-RTD3 native PCIe enumeration mode. However, the fixes here are not in
any way Thunderbolt specific and should be applicable to other systems as
well.

Mika Westerberg (5):
  PCI: Make sure all bridges reserve at least one bus number
  PCI: Take bridge window alignment into account when distributing resources
  PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
  ACPI / hotplug / PCI: Do not scan all bridges when native PCIe hotplug is used
  ACPI / hotplug / PCI: Mark stale PCI devices disconnected

 drivers/pci/hotplug/acpiphp.h      |  1 +
 drivers/pci/hotplug/acpiphp_glue.c | 78 ++++++++++++++++++++++++++++++--------
 drivers/pci/hotplug/pciehp.h       |  2 +-
 drivers/pci/hotplug/pciehp_core.c  |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c   | 13 ++++++-
 drivers/pci/probe.c                |  9 +++--
 drivers/pci/setup-bus.c            | 41 +++++++++++++++++++-
 7 files changed, 124 insertions(+), 22 deletions(-)

-- 
2.15.1
