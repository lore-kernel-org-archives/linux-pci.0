Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:53059 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcANHIh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2016 02:08:37 -0500
From: Jayachandran C <jchandra@broadcom.com>
To: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Jayachandran C <jchandra@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH v6 4/5] arm64: pci: Add ACPI support
Date: Thu, 14 Jan 2016 13:02:40 +0530
Message-ID: <1452756761-29584-5-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
References: <1452756761-29584-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add functions needed for ACPI support.

pci_acpi_scan_root(), raw_pci_read and raw_pci_write are marked as
weak so that it can be implemented by the generic ACPI PCI driver.

pcibios_enable_device and pcibios_disable_device handle acpi irq enable
and disable. And, pcibios_add_bus and pcibios_remove_bus have been
added call the corresponding ACPI functions.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/arm64/Kconfig      |  3 +++
 arch/arm64/kernel/pci.c | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

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
index b3d098b..db0a6a9 100644
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
@@ -62,15 +76,15 @@ int pcibios_add_device(struct pci_dev *dev)
 }
 
 /*
- * raw_pci_read/write - Platform-specific PCI config space access.
+ * ACPI uses these - leave it to the generic ACPI PCI driver
  */
-int raw_pci_read(unsigned int domain, unsigned int bus,
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
 		  unsigned int devfn, int reg, int len, u32 *val)
 {
 	return -ENXIO;
 }
 
-int raw_pci_write(unsigned int domain, unsigned int bus,
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
 		unsigned int devfn, int reg, int len, u32 val)
 {
 	return -ENXIO;
@@ -78,9 +92,19 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+struct pci_bus * __weak pci_acpi_scan_root(struct acpi_pci_root *root)
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
 #endif
-- 
1.9.1

