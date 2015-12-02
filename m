Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:13121 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbbLBWDy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 17:03:54 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 1/3] arm64: pci: Add ACPI support
Date: Thu, 3 Dec 2015 03:54:44 +0530
Message-ID: <1449095086-5138-2-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
References: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add functions needed for ACPI support.

pci_acpi_scan_root(struct acpi_pci_root *root) is marked as weak so
that it can be implemented by the generic acpi pci driver.
pcibios_root_bridge_prepare assumes that the sysdata is struct
acpi_pci_root_info and sets up the domain and ACPI companion

The functions pcibios_enable_device and pcibios_disable_device have
been update to handle ACPI irq enable and disable. And
pcibios_add_bus and pcibios_remove_bus have been added call the
corresponding ACPI functions.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/kernel/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3d098b..8597624 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/pci-acpi.h>
 #include <linux/slab.h>
 
 #include <asm/pci-bridge.h>
@@ -48,9 +49,22 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	if (pci_has_flag(PCI_PROBE_ONLY))
 		return 0;
 
+#ifdef CONFIG_ACPI
+	if (acpi_find_root_bridge_handle(dev))
+		acpi_pci_irq_enable(dev);
+#endif
+
 	return pci_enable_resources(dev, mask);
 }
 
+void pcibios_disable_device(struct pci_dev *dev)
+{
+#ifdef CONFIG_ACPI
+	if (acpi_find_root_bridge_handle(dev))
+		acpi_pci_irq_disable(dev);
+#endif
+}
+
 /*
  * Try to assign the IRQ number from DT when adding a new device
  */
@@ -78,9 +92,38 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+struct pci_bus *__weak pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	/* TODO: Should be revisited when implementing PCI on ACPI */
 	return NULL;
 }
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	if (!acpi_disabled) {
+		struct pci_bus *b = bridge->bus;
+		struct acpi_pci_root_info *ci = b->sysdata;
+
+		ACPI_COMPANION_SET(&bridge->dev, ci->bridge);
+		b->domain_nr = ci->root->segment;
+	}
+	return 0;
+}
+
+static int __init pcibios_assign_resources(void)
+{
+	pci_assign_unassigned_resources();
+	return 0;
+}
+
+fs_initcall(pcibios_assign_resources);
 #endif
-- 
1.9.1

