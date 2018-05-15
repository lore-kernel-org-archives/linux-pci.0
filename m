Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:51056 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeEOJI0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 05:08:26 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH v4 5/8] PCI: Replace pr_*() with dev_*() in of_pci_get_host_bridge_resources()
Date: Tue, 15 May 2018 11:07:04 +0200
Message-Id: <95f6ca417e2bc74d15f707e577b098e46b4b3ba4.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that we have a device reference, make use of it for printing.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ac97491ba377..4f21514cb4e4 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -282,15 +282,15 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 	if (!bus_range)
 		return -ENOMEM;
 
-	pr_info("host bridge %pOF ranges:\n", dev_node);
+	dev_info(dev, "host bridge %pOF ranges:\n", dev_node);
 
 	err = of_pci_parse_bus_range(dev_node, bus_range);
 	if (err) {
 		bus_range->start = busno;
 		bus_range->end = bus_max;
 		bus_range->flags = IORESOURCE_BUS;
-		pr_info("  No bus range found for %pOF, using %pR\n",
-			dev_node, bus_range);
+		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
+			 dev_node, bus_range);
 	} else {
 		if (bus_range->end > bus_range->start + bus_max)
 			bus_range->end = bus_range->start + bus_max;
@@ -302,7 +302,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 	if (err)
 		goto parse_failed;
 
-	pr_debug("Parsing ranges property...\n");
+	dev_dbg(dev, "Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
 		/* Read next ranges element */
 		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
@@ -311,9 +311,9 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 			snprintf(range_type, 4, "MEM");
 		else
 			snprintf(range_type, 4, "err");
-		pr_info("  %s %#010llx..%#010llx -> %#010llx\n", range_type,
-			range.cpu_addr, range.cpu_addr + range.size - 1,
-			range.pci_addr);
+		dev_info(dev, "  %s %#010llx..%#010llx -> %#010llx\n",
+			 range_type, range.cpu_addr,
+			 range.cpu_addr + range.size - 1, range.pci_addr);
 
 		/*
 		 * If we failed translation or got a zero-sized region
@@ -336,14 +336,16 @@ int of_pci_get_host_bridge_resources(struct device *dev,
 
 		if (resource_type(res) == IORESOURCE_IO) {
 			if (!io_base) {
-				pr_err("I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
+				dev_err(dev,
+					"I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
 					dev_node);
 				err = -EINVAL;
 				goto conversion_failed;
 			}
 			if (*io_base != (resource_size_t)OF_BAD_ADDR)
-				pr_warn("More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
-					dev_node);
+				dev_warn(dev,
+					 "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
+					 dev_node);
 			*io_base = range.cpu_addr;
 		}
 
-- 
2.13.6
