Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:57095 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3HUXjY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:39:24 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so2143925oag.24
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:39:24 -0700 (PDT)
Subject: [PATCH v7 2/5] PCI: Simplify pcie_bus_configure_settings() interface
To: Yijing Wang <wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>
Date: Wed, 21 Aug 2013 17:39:22 -0600
Message-ID: <20130821233922.2300.55535.stgit@bhelgaas-glaptop>
In-Reply-To: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
References: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
index 9a33430..ecae7f2 100644
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
index 0fd1f15..57062b7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -675,7 +675,7 @@ struct pci_driver {
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
-void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
+void pcie_bus_configure_settings(struct pci_bus *bus);
 
 enum pcie_bus_config_types {
 	PCIE_BUS_TUNE_OFF,

