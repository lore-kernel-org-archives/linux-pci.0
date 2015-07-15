Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38768 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbbGOMRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 08:17:33 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v4 15/19] irqchip: gicv3-its: Add platform MSI support
Date: Wed, 15 Jul 2015 13:16:49 +0100
Message-Id: <1436962613-17359-16-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to support non-PCI MSI with the GICv3 ITS, add the minimal
required entry points for the MSI domain (an msi_prepare implementation).

The rest is only boilerplate code to find the raw ITS domain.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/Makefile                      |  2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 93 +++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0d5f2a9..11d08c9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
new file mode 100644
index 0000000..a865505
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+
+static struct irq_chip its_pmsi_irq_chip = {
+	.name			= "ITS-pMSI",
+};
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	msi_info = msi_get_domain_info(domain->parent);
+
+	/* Suck the DeviceID out of the msi-parent property */
+	ret = of_property_read_u32_index(dev->of_node, "msi-parent",
+					 1, &dev_id);
+	if (ret)
+		return ret;
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = dev_id;
+
+	return msi_info->ops->msi_prepare(domain->parent,
+					  dev, nvec, info);
+}
+
+static struct msi_domain_ops its_pmsi_ops = {
+	.msi_prepare	= its_pmsi_prepare,
+};
+
+static struct msi_domain_info its_pmsi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &its_pmsi_ops,
+	.chip	= &its_pmsi_irq_chip,
+};
+
+static struct of_device_id its_device_id[] = {
+	{	.compatible	= "arm,gic-v3-its",	},
+	{},
+};
+
+static int __init its_pmsi_init(void)
+{
+	struct device_node *np;
+	struct irq_domain *parent;
+
+	for (np = of_find_matching_node(NULL, its_device_id); np;
+	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_property_read_bool(np, "msi-controller"))
+			continue;
+
+		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
+		if (!parent || !msi_get_domain_info(parent)) {
+			pr_err("%s: unable to locate ITS domain\n",
+			       np->full_name);
+			continue;
+		}
+
+		if (!platform_msi_create_irq_domain(np, &its_pmsi_domain_info,
+						    parent)) {
+			pr_err("%s: unable to create platform domain\n",
+			       np->full_name);
+			continue;
+		}
+
+		pr_info("Platform MSI: %s domain created\n", np->full_name);
+	}
+
+	return 0;
+}
+early_initcall(its_pmsi_init);
-- 
2.1.4

