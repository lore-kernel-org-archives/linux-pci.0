Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/10] PCI: Replace pr_*() with dev_*() in
 __of_pci_get_host_bridge_resources()
Date: Mon, 30 Apr 2018 07:48:39 +0200
Message-Id: <63f2e316090ea3284b4be62e446b3b28f998ac55.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that we have a device reference, make use of it for printing. And as
long as dev can still be NULL, we will still get some reasonable output
nevertheless.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index bfa282b538d5..8f6cbf13e18d 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -266,15 +266,15 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
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
@@ -286,7 +286,7 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
 	if (err)
 		goto parse_failed;
 
-	pr_debug("Parsing ranges property...\n");
+	dev_dbg(dev, "Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
 		/* Read next ranges element */
 		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
@@ -295,9 +295,9 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
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
@@ -324,14 +324,16 @@ static int __of_pci_get_host_bridge_resources(struct device *dev,
 
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
