Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53857 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029Ab3EONZd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 May 2013 09:25:33 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCHv9 3/9] of/pci: Add of_pci_get_devfn() function
Date: Wed, 15 May 2013 15:25:17 +0200
Message-Id: <1368624323-24311-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@avionic-design.de>

This function can be used to parse the device and function number from a
standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
the returned value obtain the device and function numbers respectively.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/of/of_pci.c    |   34 +++++++++++++++++++++++++++++-----
 include/linux/of_pci.h |    1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 13e37e2..4dd7b9b 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -5,14 +5,15 @@
 #include <asm/prom.h>
 
 static inline int __of_pci_pci_compare(struct device_node *node,
-				       unsigned int devfn)
+				       unsigned int data)
 {
-	unsigned int size;
-	const __be32 *reg = of_get_property(node, "reg", &size);
+	int devfn;
 
-	if (!reg || size < 5 * sizeof(__be32))
+	devfn = of_pci_get_devfn(node);
+	if (devfn < 0)
 		return 0;
-	return ((be32_to_cpup(&reg[0]) >> 8) & 0xff) == devfn;
+
+	return devfn == data;
 }
 
 struct device_node *of_pci_find_child_device(struct device_node *parent,
@@ -40,3 +41,26 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_pci_find_child_device);
+
+/**
+ * of_pci_get_devfn() - Get device and function numbers for a device node
+ * @np: device node
+ *
+ * Parses a standard 5-cell PCI resource and returns an 8-bit value that can
+ * be passed to the PCI_SLOT() and PCI_FUNC() macros to extract the device
+ * and function numbers respectively. On error a negative error code is
+ * returned.
+ */
+int of_pci_get_devfn(struct device_node *np)
+{
+	unsigned int size;
+	const __be32 *reg;
+
+	reg = of_get_property(np, "reg", &size);
+
+	if (!reg || size < 5 * sizeof(__be32))
+		return -EINVAL;
+
+	return (be32_to_cpup(reg) >> 8) & 0xff;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_devfn);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index bb115de..91ec484 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -10,5 +10,6 @@ int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
+int of_pci_get_devfn(struct device_node *np);
 
 #endif
-- 
1.7.9.5

