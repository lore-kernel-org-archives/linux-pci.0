Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23198 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbbGNKlA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 06:41:00 -0400
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
Subject: [PATCH v2]   PCI: Store PCIe bus address in struct of_pci_range
Date: Tue, 14 Jul 2015 18:46:39 +0800
Message-ID: <1436870799-207766-1-git-send-email-gabriele.paoloni@huawei.com>
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
    f4c55c5a3 "PCI: designware: Program ATU with untranslated address"
    added code to read the PCIe controller start address directly from the
    DT ranges.

    In the new DT parsing API of_pci_get_host_bridge_resources() hides the
    DT parser from the host controller drivers, so it is not possible
    for drivers to parse values directly from the DT.

    In http://www.spinics.net/lists/linux-pci/msg42540.html we already tried
    to use the new DT parsing API but there is a bug (obviously) in setting
    the <*>_mod_base addresses
    Applying this patch we can easily set "<*>_mod_base = win->__res.start"

    This patch adds a new field in "struct of_pci_range" to store the
    pci bus start address; it fills the field in of_pci_range_parser_one();
    in of_pci_get_host_bridge_resources() it retrieves the resource entry
    after it is created and added to the resource list and uses
    entry->__res.start to store the pci controller address

    the patch is based on 4.2-rc1

    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/of/address.c       | 2 ++
 drivers/of/of_pci.c        | 4 ++++
 include/linux/of_address.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8bfda6a..23a5793 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -253,6 +253,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 						struct of_pci_range *range)
 {
 	const int na = 3, ns = 2;
+	const int p_ns = of_n_size_cells(parser->node);
 
 	if (!range)
 		return NULL;
@@ -265,6 +266,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	range->pci_addr = of_read_number(parser->range + 1, ns);
 	range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+	range->bus_addr = of_read_number(parser->range + na, p_ns);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += parser->np;
diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 5751dc5..b171d02 100644
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
+		entry->__res.start = range.bus_addr;
 	}
 
 	return 0;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index d88e81b..865f96e 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -16,6 +16,7 @@ struct of_pci_range {
 	u32 pci_space;
 	u64 pci_addr;
 	u64 cpu_addr;
+	u64 bus_addr;
 	u64 size;
 	u32 flags;
 };
-- 
1.9.1

