Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56065 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbcDNKEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Apr 2016 06:04:35 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/4] PCI: Add support for suspending (including runtime) of PCIe ports
Date: Thu, 14 Apr 2016 13:04:24 +0300
Message-Id: <1460628268-16204-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Current Linux PCI core does not do any kind of power management to PCIe
ports. This means that we waste energy and consume laptop battery even if
the port has nothing connected to. These patches aim to change that to the
right direction.

Previous versions of the patches can be found below:

  v1: http://www.spinics.net/lists/linux-pci/msg49313.html
  v2: http://www.spinics.net/lists/linux-pci/msg50167.html

This assumes that recent (starting from 2015) PCIe ports are capable of
transition to D3hot/D3cold. We add a new flag to struct pci_dev 'bridge_d3'
that is set whenever the PCI core thinks the port can be put to D3. The
check in pci_pm_suspend_noirq() is then extended to cover devices where
'bridge_d3' is set.

We then add two new functions pci_bridge_d3_device_changed/removed(). These
are used to set and clear 'bridge_d3' whenever there is a change in device
power management policy (or if the device is removed). For example when
userspace forbids the device to enter D3cold pci_bridge_d3_device_changed()
will clear 'bridge_d3' of the upstream bridge.

For all PCI ports where 'bridge_d3' is set we also enable and unblock
runtime PM automatically. Only exception is when the PCIe port claims to
support ACPI based hotplug. More information about that is in the changelog
of patch [4/4].

Since this also touches xhci, I'm adding Mathias and Greg to check if the
change looks reasonable.

Changes to v2:
  - Renamed and split pci_enable_d3cold() into two functions
    pci_d3cold_enable()/disable().

  - Renamed pci_bridge_pm_update() into two functions
    pci_bridge_d3_device_changed() and pci_bridge_d3_device_removed() that
    should match better what they are doing.

  - Propagate ->bridge_d3 change to upstream bridges in
    pci_bridge_d3_update().

  - Removed pci_can_suspend() in favor of doing ->bridge_d3 check directly
    in pci_pm_suspend_noirq().

  - Extend runtime PM enabling for ports that are using native PCIe
    hotplug.

  - Call pm_runtime_no_callbacks() for PCIe port service devices (the are
    handled by the parent device).

I did not change the cut-off date from 2015 yet to be on the safe side,
even if older Macs seem to work just fine. Maybe it can be lowered to 2013
or so but I would like to hear from Bjorn and Rafael what they think about
that.

I also tried this series on my Ivy Bridge laptop (from 2013) and I did not
see any problems.

Changes to v1:

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

Mika Westerberg (4):
  PCI: No need to set d3cold_allowed to PCIe ports
  PCI: Move PCIe ports to D3 during suspend
  ACPI / hotplug / PCI: Runtime resume bridge before rescan
  PCI: Add runtime PM support for PCIe ports

 drivers/pci/bus.c                  |   1 +
 drivers/pci/hotplug/acpiphp_glue.c |   8 +-
 drivers/pci/pci-driver.c           |   7 +-
 drivers/pci/pci-sysfs.c            |   1 +
 drivers/pci/pci.c                  | 156 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h                  |   2 +
 drivers/pci/pcie/portdrv_core.c    |   2 +
 drivers/pci/pcie/portdrv_pci.c     | 112 ++++++++++++++++++++++++--
 drivers/pci/remove.c               |   2 +
 drivers/usb/host/xhci-pci.c        |   2 +-
 include/linux/pci.h                |   3 +
 11 files changed, 287 insertions(+), 9 deletions(-)

-- 
2.8.0.rc3

