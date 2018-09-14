Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-01.yadro.com ([89.207.88.251]:60244 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbeINVgp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:45 -0400
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to reset during rescan
Date: Fri, 14 Sep 2018 19:14:01 +0300
Message-ID: <20180914161404.4685-2-s.miroshnichenko@yadro.com>
In-Reply-To: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce a new command line option "pci=pcie_movable_bars" that indicates
support of PCIe hotplug without prior reservation of memory regions by
BIOS/bootloader.

If a new PCIe device has been hot-plugged between two active ones, which
have no (or not big enough) gap between their BARs, allocating new BARs
requires to move BARs of the following working devices:

1)                   dev 4
                       |
                       v
.. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
.. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |

2)                             dev 4
                                 |
                                 v
.. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
.. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |

3)

.. |  dev 3  |  dev 3  |  dev 4  |  dev 4  |  dev 5  |  dev 7  |
.. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |

Not only BARs, but also bridge windows can be updated during a PCIe rescan,
threatening all memory transactions during this procedure, so the PCI
subsystem will instruct the drivers to pause by calling the reset_prepare()
and reset_done() callbacks.

If a device may be affected by BAR movement, the BAR changes tracking must
be implemented in its driver.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 drivers/pci/pci.c                             |  2 +
 drivers/pci/probe.c                           | 43 +++++++++++++++++++
 include/linux/pci.h                           |  1 +
 4 files changed, 52 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 64a3bf54b974..f8132a709061 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3311,6 +3311,12 @@
 				bridges without forcing it upstream. Note:
 				this removes isolation between devices and
 				may put more devices in an IOMMU group.
+		pcie_movable_bars	Arrange a space at runtime for BARs of
+				hotplugged PCIe devices - usable if bootloader
+				doesn't reserve memory regions for them. Freeing
+				a space may require moving BARs of active devices
+				to higher addresses, so device drivers will be
+				paused during rescan.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1835f3a7aa8d..5f07a59b5924 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6105,6 +6105,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "pcie_movable_bars", 17)) {
+				pci_add_flags(PCI_MOVABLE_BARS);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5ff55c..bdaafc48dc4c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3138,6 +3138,45 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+/*
+ * Put all devices of the bus and its children to reset
+ */
+static void pci_bus_reset_prepare(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child) {
+			pci_bus_reset_prepare(child);
+		} else if (dev->driver &&
+			   dev->driver->err_handler &&
+			   dev->driver->err_handler->reset_prepare) {
+			dev->driver->err_handler->reset_prepare(dev);
+		}
+	}
+}
+
+/*
+ * Complete the reset of all devices for the bus and its children
+ */
+static void pci_bus_reset_done(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child) {
+			pci_bus_reset_done(child);
+		} else if (dev->driver && dev->driver->err_handler &&
+			   dev->driver->err_handler->reset_done) {
+			dev->driver->err_handler->reset_done(dev);
+		}
+	}
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3151,8 +3190,12 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
 
+	if (pci_has_flag(PCI_MOVABLE_BARS))
+		pci_bus_reset_prepare(bus);
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	if (pci_has_flag(PCI_MOVABLE_BARS))
+		pci_bus_reset_done(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..a8cb1a367c34 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -847,6 +847,7 @@ enum {
 	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
 	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
+	PCI_MOVABLE_BARS	= 0x00000080,	/* Runtime BAR reassign after hotplug */
 };
 
 /* These external functions are only available when PCI support is enabled */
-- 
2.17.1
