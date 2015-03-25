Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0112.outbound.protection.outlook.com ([157.56.110.112]:34315
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807AbbCYG4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Mar 2015 02:56:45 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH 1/3] arm/pci: Add support architecture-independent PCIe driver
Date: Wed, 25 Mar 2015 14:42:39 +0800
Message-ID: <1427265761-31828-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1427265761-31828-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1427265761-31828-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe common driver of arm architecture uses private structure
pci_sys_data and hw_pci to associate with specific PCIe controller
ops which results in the PCIe controller driver not compatible
with other architectures. This patch provides another approach
to support architecture-independent PCIe driver which does not
need to use pci_sys_data and hw_pci and call pci_common_init_dev().

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/arm/kernel/bios32.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ab19b7c0..8820ed5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -7,6 +7,7 @@
  */
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -17,12 +18,16 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
+static int pci_commont_init_enable;
 
 #ifdef CONFIG_PCI_MSI
 struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
 {
 	struct pci_sys_data *sysdata = dev->bus->sysdata;
 
+	if (!pci_commont_init_enable)
+		return NULL;
+
 	return sysdata->msi_ctrl;
 }
 #endif
@@ -508,6 +513,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
 
+	pci_commont_init_enable = 1;
+
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
@@ -597,7 +604,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
+	if (pci_commont_init_enable && sys->align_resource)
 		return sys->align_resource(dev, res, start, size, align);
 
 	return start;
@@ -651,3 +658,13 @@ void __init pci_map_io_early(unsigned long pfn)
 	pci_io_desc.pfn = pfn;
 	iotable_init(&pci_io_desc, 1);
 }
+
+/*
+ * Try to assign the IRQ number from DT when adding a new device
+ */
+int pcibios_add_device(struct pci_dev *dev)
+{
+	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+
+	return 0;
+}
-- 
1.9.1

