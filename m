Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36969 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbbGGRSg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 13:18:36 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 08/15] platform: of: Assign MSI domain to platform device
Date: Tue,  7 Jul 2015 18:17:58 +0100
Message-Id: <1436289485-28230-9-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As for PCI, we're able to populate the msi_domain field at probe time,
provided that the device tree has an "msi-parent" property.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/of/irq.c          | 16 ++++++++++++++++
 drivers/of/platform.c     |  1 +
 include/linux/irqdomain.h |  1 +
 include/linux/of_irq.h    |  1 +
 4 files changed, 19 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 3cf7a01..64392a6 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -18,6 +18,7 @@
  * driver.
  */
 
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -576,3 +577,18 @@ err:
 		kfree(desc);
 	}
 }
+
+void of_msi_configure(struct device *dev, struct device_node *np)
+{
+	struct device_node *msi_np;
+	struct irq_domain *d;
+
+	msi_np = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_np)
+		return;
+
+	d = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
+	if (!d)
+		d = irq_find_host(msi_np);
+	dev_set_msi_domain(dev, d);
+}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ddf8e42..8a002d6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -184,6 +184,7 @@ static struct platform_device *of_platform_device_create_pdata(
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 	of_dma_configure(&dev->dev, dev->dev.of_node);
+	of_msi_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
 		of_dma_deconfigure(&dev->dev);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 25e9e66..b4a74f7 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -55,6 +55,7 @@ struct irq_data;
 enum irq_domain_bus_token {
 	DOMAIN_BUS_ANY		= 0,
 	DOMAIN_BUS_PCI_MSI,
+	DOMAIN_BUS_PLATFORM_MSI,
 };
 
 /**
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index d884929..4bcbd58 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -74,6 +74,7 @@ static inline int of_irq_to_resource_table(struct device_node *dev,
  */
 extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);
 extern struct device_node *of_irq_find_parent(struct device_node *child);
+extern void of_msi_configure(struct device *dev, struct device_node *np);
 
 #else /* !CONFIG_OF */
 static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
-- 
2.1.4

