Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55862 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab2GZTzZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:25 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 09/10] of: Add of_pci_parse_ranges()
Date: Thu, 26 Jul 2012 21:55:11 +0200
Message-Id: <1343332512-28762-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This new function parses the ranges property of PCI device nodes into
an array of struct resource elements. It is useful in multiple-port PCI
host controller drivers to collect information about the ranges that it
needs to forward to the respective ports.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- new patch

 drivers/of/of_pci.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/of_pci.h |  2 ++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 13e37e2..bcff301 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -1,7 +1,8 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
-#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/slab.h>
 #include <asm/prom.h>
 
 static inline int __of_pci_pci_compare(struct device_node *node,
@@ -40,3 +41,84 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_pci_find_child_device);
+
+struct resource *of_pci_parse_ranges(struct device_node *node,
+				     unsigned int *countp)
+{
+	unsigned int count, i = 0;
+	struct resource *ranges;
+	const __be32 *values;
+	int len, pna, np;
+
+	values = of_get_property(node, "ranges", &len);
+	if (!values)
+		return NULL;
+
+	pna = of_n_addr_cells(node);
+	np = pna + 5;
+
+	count = len / (np * sizeof(*values));
+
+	ranges = kzalloc(sizeof(*ranges) * count, GFP_KERNEL);
+	if (!ranges)
+		return NULL;
+
+	pr_debug("PCI ranges:\n");
+
+	while ((len -= np * sizeof(*values)) >= 0) {
+		u64 addr = of_translate_address(node, values + 3);
+		u64 size = of_read_number(values + 3 + pna, 2);
+		u32 type = be32_to_cpup(values);
+		const char *suffix = "";
+		struct resource range;
+
+		memset(&range, 0, sizeof(range));
+		range.start = addr;
+		range.end = addr + size - 1;
+
+		switch ((type >> 24) & 0x3) {
+		case 0:
+			range.flags = IORESOURCE_MEM | IORESOURCE_PCI_CS;
+			pr_debug("  CS  %#x-%#x\n", range.start, range.end);
+			break;
+
+		case 1:
+			range.flags = IORESOURCE_IO;
+			pr_debug("  IO  %#x-%#x\n", range.start, range.end);
+			break;
+
+		case 2:
+			range.flags = IORESOURCE_MEM;
+
+			if (type & 0x40000000) {
+				range.flags |= IORESOURCE_PREFETCH;
+				suffix = "prefetch";
+			}
+
+			pr_debug("  MEM %#x-%#x %s\n", range.start, range.end,
+				 suffix);
+			break;
+
+		case 3:
+			range.flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
+
+			if (type & 0x40000000) {
+				range.flags |= IORESOURCE_PREFETCH;
+				suffix = "prefetch";
+			}
+
+			pr_debug("  MEM %#x-%#x 64-bit %s\n", range.start,
+				 range.end, suffix);
+			break;
+		}
+
+		memcpy(&ranges[i++], &range, sizeof(range));
+		values += np;
+	}
+
+	if (countp)
+		*countp = count;
+
+	return ranges;
+}
+EXPORT_SYMBOL_GPL(of_pci_parse_ranges);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index bb115de..c0db6ea 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -10,5 +10,7 @@ int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
+struct resource *of_pci_parse_ranges(struct device_node *node,
+				     unsigned int *countp);
 
 #endif
-- 
1.7.11.2

