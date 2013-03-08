Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35881 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757836Ab3CHPTe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 10:19:34 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Olof Johansson <olof@lixom.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v4 03/18] of/pci: Add of_pci_get_bus() function
Date: Fri,  8 Mar 2013 16:19:05 +0100
Message-Id: <1362755960-30791-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@avionic-design.de>

This function can be used to parse the number of a device's parent PCI
bus from a standard 5-cell PCI resource.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/of/of_pci.c    |   21 +++++++++++++++++++++
 include/linux/of_pci.h |    1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 4dd7b9b..d6e6de5 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -43,6 +43,27 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 EXPORT_SYMBOL_GPL(of_pci_find_child_device);
 
 /**
+ * of_pci_get_bus() - Get bus number for a device node
+ * @np: device node
+ *
+ * Parses a standard 5-cell PCI resource and returns the 8-bit bus number of
+ * the device's parent PCI bus. On error a negative error code is returned.
+ */
+int of_pci_get_bus(struct device_node *np)
+{
+	unsigned int size;
+	const __be32 *reg;
+
+	reg = of_get_property(np, "reg", &size);
+
+	if (!reg || size < 5 * sizeof(__be32))
+		return -EINVAL;
+
+	return (be32_to_cpup(reg) >> 16) & 0xff;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_bus);
+
+/**
  * of_pci_get_devfn() - Get device and function numbers for a device node
  * @np: device node
  *
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 91ec484..9118321 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -10,6 +10,7 @@ int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
+int of_pci_get_bus(struct device_node *np);
 int of_pci_get_devfn(struct device_node *np);
 
 #endif
-- 
1.7.9.5

