Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53529 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839Ab3CZQSt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:18:49 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [PATCHv6 03/17] of/pci: Add of_pci_parse_bus_range() function
Date: Tue, 26 Mar 2013 17:18:25 +0100
Message-Id: <1364314719-1049-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@avionic-design.de>

This function can be used to parse a bus-range property as specified by
device nodes representing PCI bridges.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/of/of_pci.c    |   25 +++++++++++++++++++++++++
 include/linux/of_pci.h |    1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 4dd7b9b..42c687a 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -64,3 +64,28 @@ int of_pci_get_devfn(struct device_node *np)
 	return (be32_to_cpup(reg) >> 8) & 0xff;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_devfn);
+
+/**
+ * of_pci_parse_bus_range() - parse the bus-range property of a PCI device
+ * @node: device node
+ * @res: address to a struct resource to return the bus-range
+ *
+ * Returns 0 on success or a negative error-code on failure.
+ */
+int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
+{
+	const __be32 *values;
+	int len;
+
+	values = of_get_property(node, "bus-range", &len);
+	if (!values || len < sizeof(*values) * 2)
+		return -EINVAL;
+
+	res->name = node->name;
+	res->start = be32_to_cpup(values++);
+	res->end = be32_to_cpup(values);
+	res->flags = IORESOURCE_BUS;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 91ec484..7a04826 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -11,5 +11,6 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
+int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 
 #endif
-- 
1.7.9.5

