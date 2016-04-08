Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8579 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756517AbcDHKgm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 06:36:42 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] PCI: Add support for suspending (including runtime) of PCIe ports
Date: Fri,  8 Apr 2016 13:36:26 +0300
Message-Id: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current Linux PCI core does not do any kind of power management to PCIe
ports. This means that we waste energy and consume laptop battery even if
the port has nothing connected to. These patches aim to change that to the
right direction.

The first version of the patches can be found here:

  http://www.spinics.net/lists/linux-pci/msg49313.html

This assumes that recent (starting from 2015) PCIe ports are capable of
transition to D3hot/D3cold. We add a new flag to struct pci_dev 'bridge_d3'
that is set whenever the PCI core thinks the port can be put to D3. The
check in pci_pm_suspend_noirq() is then extended to cover devices where
'bridge_d3' is set.

We then add pci_bridge_pm_update() that tries to set/clear 'bridge_d3'
whenever power management status of a device is changed. For example when
userspace writes to 'd3cold_allowed' sysfs file.

For all PCI ports where 'bridge_d3' is set we also enable and unblock
runtime PM automatically. Only exception is when the PCIe port claims to
support hotplug. More information about that is in the changelog of patch
[4/4].

Since this also touches xhci, I'm adding Mathias and Greg to check if the
change looks reasonable.

Changes to the previous version:

  - Dropped patch [2/6] as there is no need to use that function from other
    files anymore.

  - Dropped patches [5-6/6] in favor of using cut-off date.

  - Updated changelog of [1/4] to mention where in the PCI core PCI bridge
    and PCIe ports are skipped from being power managed.

  - Instead of checking at suspend time if it is possible to transition the
    port to D3, do it whenever power management status of a device (below a
    port) is changed or when it is added or removed to the bus.

  - Added patch [3/4] to runtime resume a bridge when ACPI hotplug event is
    received.

Please review.

Mika Westerberg (4):
  PCI: No need to set d3cold_allowed to PCIe ports
  PCI: Move PCIe ports to D3 during suspend
  ACPI / hotplug / PCI: Runtime resume bridge before rescan
  PCI: Add runtime PM support for PCIe ports

 drivers/pci/bus.c                  |   1 +
 drivers/pci/hotplug/acpiphp_glue.c |   8 ++-
 drivers/pci/pci-driver.c           |  15 +++++-
 drivers/pci/pci-sysfs.c            |   1 +
 drivers/pci/pci.c                  | 103 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h                  |   1 +
 drivers/pci/pcie/portdrv_pci.c     |  90 ++++++++++++++++++++++++++++++--
 drivers/pci/remove.c               |   2 +
 drivers/usb/host/xhci-pci.c        |   2 +-
 include/linux/pci.h                |   2 +
 10 files changed, 216 insertions(+), 9 deletions(-)

-- 
2.8.0.rc3

