Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22842 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbGJInM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2015 04:43:12 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <gabriele.paoloni@huawei.com>, <arnd@arndb.de>,
	<lorenzo.pieralisi@arm.com>, <wangzhou1@hisilicon.com>,
	<bhelgaas@google.com>, <robh+dt@kernel.org>, <james.morse@arm.com>,
	<Liviu.Dudau@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH] Store PCIe controllers address in struct of_pci_range
Date: Fri, 10 Jul 2015 16:48:19 +0800
Message-ID: <1436518099-98633-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch is needed port PCIe designware to new DT parsing API
As discussed in
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317743.html
in designware we have a problem as the PCI addresses in the PCIe controller
address space are required in order to perform correct HW operation.

In order to solve this problem commit
f4c55c5a3f7f68c06cc559ed7af8b2d017cbb0a7 "PCI: designware:
Program ATU with untranslated address" added code to read the PCIe
controller start address directly from the DT ranges.

In the new DT parsing API of_pci_get_host_bridge_resources() hides the
DT parser from the host controller drivers, so it is not possible
for drivers to parse values directly from the DT.

In http://www.spinics.net/lists/linux-pci/msg42540.html we already tried
to use the new DT parsing API but there is a bug (obviously) in setting
the <*>_mod_base addresses
Applying this patch we can easily set "<*>_mod_base = win->__res.start"

This patch adds a new field in "struct of_pci_range" to store the
pci controller start address; it fills the field in of_pci_range_parser_one();
in of_pci_get_host_bridge_resources() it retrieve the resource entry
after it is created and added to the resource list and uses
entry->__res.start to store the pci controller address

the patch is based on 4.2-rc1

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/of/address.c               | 1 +
 drivers/of/of_pci.c                | 4 ++++
 drivers/pci/host/pcie-designware.c | 9 +++------
 include/linux/of_address.h         | 1 +
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8bfda6a..52f9321 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -265,6 +265,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	range->pci_addr = of_read_number(parser->range + 1, ns);
 	range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+	range->pci_ctrl_addr = of_read_number(parser->range + na, ns);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += parser->np;
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 5751dc5..2ccc749 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -198,6 +198,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 
 	pr_debug("Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
+		struct resource_entry *entry;
 		/* Read next ranges element */
 		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
 			snprintf(range_type, 4, " IO");
@@ -240,6 +241,9 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 		}
 
 		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
+		entry = list_last_entry(resources, struct resource_entry, node);
+		/*we are using __res for storing the PCI controller address*/
+		entry->__res.start = range.pci_ctrl_addr;
 	}
 
 	return 0;
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..106dae6 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -416,8 +416,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_base = range.cpu_addr;
 
 			/* Find the untranslated IO space address */
-			pp->io_mod_base = of_read_number(parser.range -
-							 parser.np + na, ns);
+			pp->io_mod_base = range.pci_ctrl_addr;
 		}
 		if (restype == IORESOURCE_MEM) {
 			of_pci_range_to_resource(&range, np, &pp->mem);
@@ -426,8 +425,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->mem_bus_addr = range.pci_addr;
 
 			/* Find the untranslated MEM space address */
-			pp->mem_mod_base = of_read_number(parser.range -
-							  parser.np + na, ns);
+			pp->mem_mod_base = range.pci_ctrl_addr;
 		}
 		if (restype == 0) {
 			of_pci_range_to_resource(&range, np, &pp->cfg);
@@ -437,8 +435,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
 
 			/* Find the untranslated configuration space address */
-			pp->cfg0_mod_base = of_read_number(parser.range -
-							   parser.np + na, ns);
+			pp->cfg0_mod_base = range.pci_ctrl_addr;
 			pp->cfg1_mod_base = pp->cfg0_mod_base +
 					    pp->cfg0_size;
 		}
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index d88e81b..55bb1ae 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -16,6 +16,7 @@ struct of_pci_range {
 	u32 pci_space;
 	u64 pci_addr;
 	u64 cpu_addr;
+	u64 pci_ctrl_addr;
 	u64 size;
 	u32 flags;
 };
-- 
1.9.1

