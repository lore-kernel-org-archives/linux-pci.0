Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:35402 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbbLGQ73 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2015 11:59:29 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v2 1/4] arm64: pci: Add ACPI support
Date: Mon, 7 Dec 2015 22:50:26 +0530
Message-ID: <1449508829-10797-2-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
References: <1449508829-10797-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add functions needed for ACPI support on arm64.

pci_acpi_scan_root(struct acpi_pci_root *root) is marked as weak so
that it can be implemented by the generic acpi pci driver.
pcibios_root_bridge_prepare is defined and it assumes that the
sysdata is struct acpi_pci_root_info.

pcibios_enable_device and pcibios_disable_device handle acpi irq enable
and disable. And, pcibios_add_bus and pcibios_remove_bus have been
added call the corresponding acpi functions.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/Kconfig      |  3 +++
 arch/arm64/kernel/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..8c93af2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -203,6 +203,9 @@ config PCI_DOMAINS_GENERIC
 config PCI_SYSCALL
 	def_bool PCI
 
+config PCI_MMCONFIG
+	def_bool PCI && ACPI
+
 source "drivers/pci/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3d098b..ffa0ab2 100644
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
@@ -77,10 +91,40 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 }
 
 #ifdef CONFIG_ACPI
-/* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
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
+	/* ACPI root bus is created with NULL parent */
+	if (!acpi_disabled && bridge->dev.parent == NULL) {
+		struct pci_bus *b = bridge->bus;
+		struct acpi_pci_root_info *ci = b->sysdata;
+
+		ACPI_COMPANION_SET(&bridge->dev, ci->bridge);
+		b->domain_nr = ci->root->segment;
+	}
+	return 0;
+}
+
+/*
+ * Provide weak implementations of ACPI PCI hooks needed.
+ * Leave it to the ACPI PCI driver implementation to do it
+ */
+struct pci_bus *__weak pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	/* TODO: Should be revisited when implementing PCI on ACPI */
 	return NULL;
 }
+
+void __init __weak pci_mmcfg_late_init(void)
+{
+}
 #endif
-- 
1.9.1

