Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 3/7] OF: Add missing I/O range exception for indirect-IO
 devices
Date: Thu, 25 May 2017 12:37:24 +0100
Message-ID: <1495712248-5232-4-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, minyard@acm.org, gabriele.paoloni@huawei.com,
 benh@kernel.crashing.org, john.garry@huawei.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, linux-pci@vger.kernel.org,
 olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

There are some special ISA/LPC devices that work on a specific I/O range
where it is not correct to specify a 'ranges' property in DTS parent node
as cpu addresses translated from DTS node are only for memory space on some
architectures, such as Arm64. Without the parent 'ranges' property, current
of_translate_address() return an error.
Here we add special handlings for this case.
During the OF address translation, some checkings will be perfromed to
identify whether the device node is registered as indirect-IO. If yes, the
I/O translation will be done in a different way from that one of PCI MMIO.
In this way, the I/O 'reg' property of the special ISA/LPC devices will be
parsed correctly.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>    #earlier draft
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 90 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 34a55e8..c51de70 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -552,9 +552,14 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
  * that translation is impossible (that is we are not dealing with a value
  * that can be mapped to a cpu physical address). This is not really specified
  * that way, but this is traditionally the way IBM at least do things
+ *
+ * Whenever the translation fails, the *host pointer will be set to the
+ * device that had registered logical PIO mapping, and the return code is
+ * relative to that node.
  */
 static u64 __of_translate_address(struct device_node *dev,
-				  const __be32 *in_addr, const char *rprop)
+				  const __be32 *in_addr, const char *rprop,
+				  struct device_node **host)
 {
 	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
@@ -567,6 +572,7 @@ static u64 __of_translate_address(struct device_node *dev,
 	/* Increase refcount at current level */
 	of_node_get(dev);
 
+	*host = NULL;
 	/* Get parent & match bus type */
 	parent = of_get_parent(dev);
 	if (parent == NULL)
@@ -587,6 +593,8 @@ static u64 __of_translate_address(struct device_node *dev,
 
 	/* Translate */
 	for (;;) {
+		struct logic_pio_hwaddr *iorange;
+
 		/* Switch to parent bus */
 		of_node_put(dev);
 		dev = parent;
@@ -599,6 +607,19 @@ static u64 __of_translate_address(struct device_node *dev,
 			break;
 		}
 
+		/*
+		 * For indirectIO device which has no ranges property, get
+		 * the address from reg directly.
+		 */
+		iorange = find_io_range_by_fwnode(&dev->fwnode);
+		if (iorange && (iorange->flags != PIO_CPU_MMIO)) {
+			result = of_read_number(addr + 1, na - 1);
+			pr_debug("indirectIO matched(%s) 0x%llx\n",
+					of_node_full_name(dev), result);
+			*host = of_node_get(dev);
+			break;
+		}
+
 		/* Get new parent bus and counts */
 		pbus = of_match_bus(parent);
 		pbus->count_cells(dev, &pna, &pns);
@@ -631,13 +652,32 @@ static u64 __of_translate_address(struct device_node *dev,
 
 u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, in_addr, "ranges");
+	struct device_node *host;
+	u64 ret;
+
+	ret =  __of_translate_address(dev, in_addr, "ranges", &host);
+	if (host) {
+		of_node_put(host);
+		return OF_BAD_ADDR;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(of_translate_address);
 
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, in_addr, "dma-ranges");
+	struct device_node *host;
+	u64 ret;
+
+	ret = __of_translate_address(dev, in_addr, "dma-ranges", &host);
+
+	if (host) {
+		of_node_put(host);
+		return OF_BAD_ADDR;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(of_translate_dma_address);
 
@@ -679,29 +719,47 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
 }
 EXPORT_SYMBOL(of_get_address);
 
+static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr)
+{
+	u64 taddr;
+	unsigned long port;
+	struct device_node *host;
+
+	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
+	if (host) {
+		/* host specific port access */
+		port = logic_pio_trans_hwaddr(&host->fwnode, taddr);
+		of_node_put(host);
+	} else {
+		/* memory mapped I/O range */
+		port = pci_address_to_pio(taddr);
+	}
+
+	if (port == (unsigned long)-1)
+		return OF_BAD_ADDR;
+
+	return port;
+}
+
 static int __of_address_to_resource(struct device_node *dev,
 		const __be32 *addrp, u64 size, unsigned int flags,
 		const char *name, struct resource *r)
 {
 	u64 taddr;
 
-	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
+	if (flags & IORESOURCE_MEM)
+		taddr = of_translate_address(dev, addrp);
+	else if (flags & IORESOURCE_IO)
+		taddr = of_translate_ioport(dev, addrp);
+	else
 		return -EINVAL;
-	taddr = of_translate_address(dev, addrp);
+
 	if (taddr == OF_BAD_ADDR)
 		return -EINVAL;
 	memset(r, 0, sizeof(struct resource));
-	if (flags & IORESOURCE_IO) {
-		unsigned long port;
-		port = pci_address_to_pio(taddr);
-		if (port == (unsigned long)-1)
-			return -EINVAL;
-		r->start = port;
-		r->end = port + size - 1;
-	} else {
-		r->start = taddr;
-		r->end = taddr + size - 1;
-	}
+
+	r->start = taddr;
+	r->end = taddr + size - 1;
 	r->flags = flags;
 	r->name = name ? name : dev->full_name;
 
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
