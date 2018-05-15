Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/8] PCI: Rename device node parameter of
 of_pci_get_host_bridge_resources()
Date: Tue, 15 May 2018 11:07:02 +0200
Message-Id: <4df503604897aebbcb6e7ab98ef5f24916c6d382.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We will add a real device parameter to this function soon.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c       | 18 +++++++++---------
 include/linux/of_pci.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a28355c273ae..8d4778ef5806 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -245,7 +245,7 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 #if defined(CONFIG_OF_ADDRESS)
 /**
  * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
- * @dev: device node of the host bridge having the range property
+ * @dev_node: device node of the host bridge having the range property
  * @busno: bus number associated with the bridge root bus
  * @bus_max: maximum number of buses for this bridge
  * @resources: list where the range of resources will be added after DT parsing
@@ -262,7 +262,7 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * It returns zero if the range parsing has been successful or a standard error
  * value if it failed.
  */
-int of_pci_get_host_bridge_resources(struct device_node *dev,
+int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
@@ -281,15 +281,15 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	if (!bus_range)
 		return -ENOMEM;
 
-	pr_info("host bridge %pOF ranges:\n", dev);
+	pr_info("host bridge %pOF ranges:\n", dev_node);
 
-	err = of_pci_parse_bus_range(dev, bus_range);
+	err = of_pci_parse_bus_range(dev_node, bus_range);
 	if (err) {
 		bus_range->start = busno;
 		bus_range->end = bus_max;
 		bus_range->flags = IORESOURCE_BUS;
 		pr_info("  No bus range found for %pOF, using %pR\n",
-			dev, bus_range);
+			dev_node, bus_range);
 	} else {
 		if (bus_range->end > bus_range->start + bus_max)
 			bus_range->end = bus_range->start + bus_max;
@@ -297,7 +297,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	pci_add_resource(resources, bus_range);
 
 	/* Check for ranges property */
-	err = of_pci_range_parser_init(&parser, dev);
+	err = of_pci_range_parser_init(&parser, dev_node);
 	if (err)
 		goto parse_failed;
 
@@ -327,7 +327,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 			goto parse_failed;
 		}
 
-		err = of_pci_range_to_resource(&range, dev, res);
+		err = of_pci_range_to_resource(&range, dev_node, res);
 		if (err) {
 			kfree(res);
 			continue;
@@ -336,13 +336,13 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 		if (resource_type(res) == IORESOURCE_IO) {
 			if (!io_base) {
 				pr_err("I/O range found for %pOF. Please provide an io_base pointer to save CPU base address\n",
-					dev);
+					dev_node);
 				err = -EINVAL;
 				goto conversion_failed;
 			}
 			if (*io_base != (resource_size_t)OF_BAD_ADDR)
 				pr_warn("More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
-					dev);
+					dev_node);
 			*io_base = range.cpu_addr;
 		}
 
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 091033a6b836..74eec1943ad2 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -71,11 +71,11 @@ of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 #endif
 
 #if defined(CONFIG_OF_ADDRESS)
-int of_pci_get_host_bridge_resources(struct device_node *dev,
+int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
 #else
-static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
+static inline int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
