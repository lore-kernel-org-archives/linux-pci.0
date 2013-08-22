Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:44922 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab3HVDZp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 23:25:45 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: [PATCH v8 2/6] PCI: Simplify pcie_bus_configure_settings() interface
Date: Thu, 22 Aug 2013 11:24:44 +0800
Message-ID: <1377141888-7000-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Based on a patch by Jon Mason (see URL below).

All users of pcie_bus_configure_settings() pass arguments of the form
"bus, bus->self->pcie_mpss".  The "mpss" argument is redundant since we
can easily look it up internally.  In addition, all callers check
"bus->self" for NULL, which we can also do internally.

This patch simplifies the interface and the callers.  No functional change.

Reference: http://lkml.kernel.org/r/1317048850-30728-2-git-send-email-mason@myri.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/pci-common.c |    8 ++------
 arch/tile/kernel/pci_gx.c        |    9 ++-------
 arch/x86/pci/acpi.c              |    9 ++-------
 drivers/pci/hotplug/pcihp_slot.c |    5 ++---
 drivers/pci/probe.c              |    7 +++++--
 include/linux/pci.h              |    2 +-
 6 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f46914a..d35ec34 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1672,12 +1672,8 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	/* Configure PCI Express settings */
 	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node) {
-			struct pci_dev *self = child->self;
-			if (!self)
-				continue;
-			pcie_bus_configure_settings(child, self->pcie_mpss);
-		}
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
 	}
 }
 
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index 1142563..6640e7b 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -508,13 +508,8 @@ static void fixup_read_and_payload_sizes(struct pci_controller *controller)
 						rc_dev_cap.word);
 
 	/* Configure PCI Express MPS setting. */
-	list_for_each_entry(child, &root_bus->children, node) {
-		struct pci_dev *self = child->self;
-		if (!self)
-			continue;
-
-		pcie_bus_configure_settings(child, self->pcie_mpss);
-	}
+	list_for_each_entry(child, &root_bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	/*
 	 * Set the mac_config register in trio based on the MPS/MRS of the link.
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index d641897..b30e937 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -568,13 +568,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	 */
 	if (bus) {
 		struct pci_bus *child;
-		list_for_each_entry(child, &bus->children, node) {
-			struct pci_dev *self = child->self;
-			if (!self)
-				continue;
-
-			pcie_bus_configure_settings(child, self->pcie_mpss);
-		}
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
 	}
 
 	if (bus && node != -1) {
diff --git a/drivers/pci/hotplug/pcihp_slot.c b/drivers/pci/hotplug/pcihp_slot.c
index fec2d5b..16f9203 100644
--- a/drivers/pci/hotplug/pcihp_slot.c
+++ b/drivers/pci/hotplug/pcihp_slot.c
@@ -160,9 +160,8 @@ void pci_configure_slot(struct pci_dev *dev)
 			(dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)))
 		return;
 
-	if (dev->bus && dev->bus->self)
-		pcie_bus_configure_settings(dev->bus,
-					    dev->bus->self->pcie_mpss);
+	if (dev->bus)
+		pcie_bus_configure_settings(dev->bus);
 
 	memset(&hpp, 0, sizeof(hpp));
 	ret = pci_get_hp_params(dev, &hpp);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1fa9e5e..627cc88 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1607,10 +1607,13 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
  * parents then children fashion.  If this changes, then this code will not
  * work as designed.
  */
-void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
+void pcie_bus_configure_settings(struct pci_bus *bus)
 {
 	u8 smpss;
 
+	if (!bus->self)
+		return;
+
 	if (!pci_is_pcie(bus->self))
 		return;
 
@@ -1625,7 +1628,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 		smpss = 0;
 
 	if (pcie_bus_config == PCIE_BUS_SAFE) {
-		smpss = mpss;
+		smpss = bus->self->pcie_mpss;
 
 		pcie_find_smpss(bus->self, &smpss);
 		pci_walk_bus(bus, pcie_find_smpss, &smpss);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 408f047..13ee987 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -675,7 +675,7 @@ struct pci_driver {
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
+void pcie_bus_configure_settings(struct pci_bus *bus);
 
 enum pcie_bus_config_types {
 	PCIE_BUS_TUNE_OFF,
-- 
1.7.1


