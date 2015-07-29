Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbbG2WTe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 18:19:34 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgass <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Austin Bolen <Austin_Bolen@Dell.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH] pci: Default MPS tuning, match upstream port
Date: Wed, 29 Jul 2015 16:18:53 -0600
Message-Id: <1438208335-19457-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A hot plugged PCI-e device max payload size (MPS) defaults to 0 for
128bytes. The device is not usable if the upstream port is configured
to a higher setting.

Bus configuration was previously done by arch specific and hot plug code
after the root port or bridge was scanned, and default behavior logged a
warning without changing the setting if there was a problem. This patch
unifies tuning with a default policy that affects only misconfigured
downstream devices, and preserves existing end result if a non-default
bus tuning is used (ex: pci=pcie_bus_safe).

The new pcie tuning will check the device's MPS against the parent bridge
when it is initially added to the pci subsystem, prior to attaching
to a driver. If MPS is mismatched, the downstream port is set to the
parent bridge's if capable. This is safe to change here since the device
being configured is not bound to a driver and does not affect previously
configured devices in the domain hierarchy.

A device incapable of matching the upstream bridge will log a
warning message and not bind to a driver. This is the safe option since
proper MPS configuration must consider the entire hierarchy between
communicating end points, and we can't safely modify a root port's
subtree MPS settings while it is in use.

Since the bus is configured everytime a bridge is scanned, this
potentially creates unnecessary re-walking of an already configured
sub-tree, but the code only executes during root port initialization,
hot adding a switch, or explicit request to rescan.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Austin Bolen <Austin_Bolen@Dell.com>
Cc: Myron Stowe <mstowe@redhat.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c           |   12 ------------
 arch/powerpc/kernel/pci-common.c   |    7 -------
 arch/tile/kernel/pci_gx.c          |    4 ----
 arch/x86/pci/acpi.c                |    9 ---------
 drivers/pci/bus.c                  |    4 ++++
 drivers/pci/hotplug/acpiphp_glue.c |    1 -
 drivers/pci/hotplug/pciehp_pci.c   |    1 -
 drivers/pci/hotplug/shpchp_pci.c   |    1 -
 drivers/pci/probe.c                |   27 ++++++++++++++++++++++-----
 include/linux/pci.h                |    2 --
 10 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1..4fff58e 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -537,18 +537,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 		 */
 		pci_bus_add_devices(bus);
 	}
-
-	list_for_each_entry(sys, &head, node) {
-		struct pci_bus *bus = sys->bus;
-
-		/* Configure PCI Express settings */
-		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
-			struct pci_bus *child;
-
-			list_for_each_entry(child, &bus->children, node)
-				pcie_bus_configure_settings(child);
-		}
-	}
 }
 
 #ifndef CONFIG_PCI_HOST_ITE8152
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b9de34d..7f27ffe 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1682,13 +1682,6 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	 */
 	if (ppc_md.pcibios_fixup_phb)
 		ppc_md.pcibios_fixup_phb(hose);
-
-	/* Configure PCI Express settings */
-	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
-		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
 }
 EXPORT_SYMBOL_GPL(pcibios_scan_phb);
 
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index b1df847..67492fb 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -599,10 +599,6 @@ static void fixup_read_and_payload_sizes(struct pci_controller *controller)
 	__gxio_mmio_write32(trio_context->mmio_base_mac + reg_offset,
 			    rc_dev_cap.word);
 
-	/* Configure PCI Express MPS setting. */
-	list_for_each_entry(child, &root_bus->children, node)
-		pcie_bus_configure_settings(child);
-
 	/*
 	 * Set the mac_config register in trio based on the MPS/MRS of the link.
 	 */
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ff99117..ab5977a 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -478,15 +478,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		}
 	}
 
-	/* After the PCI-E bus has been walked and all devices discovered,
-	 * configure any settings of the fabric that might be necessary.
-	 */
-	if (bus) {
-		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
-
 	if (bus && node != NUMA_NO_NODE)
 		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
 
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6fbd3f2..8f8428a 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -277,6 +277,10 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
 
+	if (dev->bus->self &&
+			pcie_get_mps(dev) != pcie_get_mps(dev->bus->self))
+		return;
+
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ff53856..cd98649 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -509,7 +509,6 @@ static void enable_slot(struct acpiphp_slot *slot)
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 
 	acpiphp_sanitize_bus(bus);
-	pcie_bus_configure_settings(bus);
 	acpiphp_set_acpi_region(slot);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 9e69403..93bc7f6 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -65,7 +65,6 @@ int pciehp_configure_device(struct slot *p_slot)
 			pci_hp_add_bridge(dev);
 
 	pci_assign_unassigned_bridge_resources(bridge);
-	pcie_bus_configure_settings(parent);
 	pci_bus_add_devices(parent);
 
  out:
diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index f8cd3a2..ca3dc3c 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -69,7 +69,6 @@ int shpchp_configure_device(struct slot *p_slot)
 	}
 
 	pci_assign_unassigned_bridge_resources(bridge);
-	pcie_bus_configure_settings(parent);
 	pci_bus_add_devices(parent);
 
  out:
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..b469298 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -37,6 +37,9 @@ struct pci_domain_busn_res {
 	int domain_nr;
 };
 
+static void pcie_bus_detect_mps(struct pci_dev *dev);
+static void pcie_bus_configure_settings(struct pci_bus *bus);
+
 static struct resource *get_pci_domain_busn_res(int domain_nr)
 {
 	struct pci_domain_busn_res *r;
@@ -929,6 +932,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 		(is_cardbus ? "PCI CardBus %04x:%02x" : "PCI Bus %04x:%02x"),
 		pci_domain_nr(bus), child->number);
 
+	pcie_bus_configure_settings(bus);
+
 	/* Has only triggered on CardBus, fixup is in yenta_socket */
 	while (bus->parent) {
 		if ((child->busn_res.end > bus->busn_res.end) ||
@@ -1589,6 +1594,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+
+	if (pci_is_pcie(dev))
+		pcie_bus_detect_mps(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
@@ -1802,9 +1810,17 @@ static void pcie_bus_detect_mps(struct pci_dev *dev)
 	mps = pcie_get_mps(dev);
 	p_mps = pcie_get_mps(bridge);
 
-	if (mps != p_mps)
-		dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
-			 mps, pci_name(bridge), p_mps);
+	if (mps != p_mps) {
+		if (128 << dev->pcie_mpss < p_mps) {
+			dev_warn(&dev->dev,
+				"Max Payload Size Supported %d, but upstream %s set to %d. If problems are experienced, try running with pci=pcie_bus_safe\n",
+				128 << dev->pcie_mpss, pci_name(bridge), p_mps);
+			return;
+		}
+		pcie_write_mps(dev, p_mps);
+		dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d)\n",
+			pcie_get_mps(dev), 128 << dev->pcie_mpss, mps);
+	}
 }
 
 static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
@@ -1836,7 +1852,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
  * parents then children fashion.  If this changes, then this code will not
  * work as designed.
  */
-void pcie_bus_configure_settings(struct pci_bus *bus)
+static void pcie_bus_configure_settings(struct pci_bus *bus)
 {
 	u8 smpss = 0;
 
@@ -1863,7 +1879,6 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
 	pcie_bus_configure_set(bus->self, &smpss);
 	pci_walk_bus(bus, pcie_bus_configure_set, &smpss);
 }
-EXPORT_SYMBOL_GPL(pcie_bus_configure_settings);
 
 unsigned int pci_scan_child_bus(struct pci_bus *bus)
 {
@@ -1895,6 +1910,8 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 				max = pci_scan_bridge(bus, dev, max, pass);
 		}
 
+	pcie_bus_configure_settings(bus);
+
 	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..e1df5f9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -735,8 +735,6 @@ struct pci_driver {
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-void pcie_bus_configure_settings(struct pci_bus *bus);
-
 enum pcie_bus_config_types {
 	PCIE_BUS_TUNE_OFF,
 	PCIE_BUS_SAFE,
-- 
1.7.10.4

