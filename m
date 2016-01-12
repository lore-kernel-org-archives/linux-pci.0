Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0051.outbound.protection.outlook.com ([104.47.38.51]:16806
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752067AbcALRhD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 12:37:03 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <michals@xilinx.com>,
	<lorenzo.pieralisi@arm.com>, <paul.burton@imgtec.com>,
	<yinghai@kernel.org>, <wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <arnd@arndb.de>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: [PATCH V2 5/5] Microblaze: Modifying microblaze PCI subsytem to support  generic Xilinx  AXI PCIe Host Bridge IP driver
Date: Tue, 12 Jan 2016 23:06:13 +0530
Message-ID: <1452620173-4905-6-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch does required modifications to microblaze PCI subsystem, to
work with generic driver (drivers/pci/host/pcie-xilinx.c) on Microblaze
and Zynq.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
---
Changes:
Modified pcibios_fixup_bus in pci-common.c, as per generic architecuture.
Modified pcibios_align_resource in pci-common.c, as per generic
architecuture.
Modified pcibios_get_phb_of_node function in pci-common.c, to remove
dependency on struct pci_controller.
Removed pci_domain_nr in pci-common.c, instead using generic code.
Added pcibios_add_device in pci-common.c, as per generic architecuture.
Adding Kernel configuration in arch/microblaze as required for generic PCI
domains.
Added kernel configuration for driver to support Microblaze.
---
 arch/microblaze/Kconfig          |  3 ++
 arch/microblaze/pci/pci-common.c | 61 +++++++++++++++-------------------------
 drivers/pci/host/Kconfig         |  2 +-
 3 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 0bce820..c3702b9 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -271,6 +271,9 @@ config PCI
 config PCI_DOMAINS
 	def_bool PCI
 
+config PCI_DOMAINS_GENERIC
+	def_bool PCI_DOMAINS
+
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ae838ed..bc72856 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -123,17 +123,6 @@ unsigned long pci_address_to_pio(phys_addr_t address)
 }
 EXPORT_SYMBOL_GPL(pci_address_to_pio);
 
-/*
- * Return the domain number for this bus.
- */
-int pci_domain_nr(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-
-	return hose->global_number;
-}
-EXPORT_SYMBOL(pci_domain_nr);
-
 /* This routine is meant to be used early during boot, when the
  * PCI bus numbers have not yet been assigned, and you need to
  * issue PCI config cycles to an OF device.
@@ -863,26 +852,10 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
 
 void pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* When called from the generic PCI probe, read PCI<->PCI bridge
-	 * bases. This is -not- called when generating the PCI tree from
-	 * the OF device-tree.
-	 */
-	if (bus->self != NULL)
-		pci_read_bridge_bases(bus);
-
-	/* Now fixup the bus bus */
-	pcibios_setup_bus_self(bus);
-
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
+	/* nothing to do */
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-static int skip_isa_ioresource_align(struct pci_dev *dev)
-{
-	return 0;
-}
-
 /*
  * We need to avoid collisions with `mirrored' VGA ports
  * and other strange ISA hardware, so we always want the
@@ -899,20 +872,20 @@ static int skip_isa_ioresource_align(struct pci_dev *dev)
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
 
-	if (res->flags & IORESOURCE_IO) {
-		if (skip_isa_ioresource_align(dev))
-			return start;
-		if (start & 0x300)
-			start = (start + 0x3ff) & ~0x3ff;
-	}
-
 	return start;
 }
 EXPORT_SYMBOL(pcibios_align_resource);
 
+int pcibios_add_device(struct pci_dev *dev)
+{
+	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL(pcibios_add_device);
+
 /*
  * Reparent resource children of pr that conflict with res
  * under res, and make res replace those children.
@@ -1335,9 +1308,21 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 {
-	struct pci_controller *hose = bus->sysdata;
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		const void *prop;
+		unsigned int bus_min;
+
+		prop = of_get_property(np, "bus-range", NULL);
+		if (!prop)
+			continue;
+		bus_min = be32_to_cpup(prop);
+		if (bus->number == bus_min)
+			return np;
+	}
 
-	return of_node_get(hose->dn);
+	return NULL;
 }
 
 static void pcibios_scan_phb(struct pci_controller *hose)
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d5e58ba..7c56c2e 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -79,7 +79,7 @@ config PCI_KEYSTONE
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || MICROBLAZE
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.1.1

