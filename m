Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59120 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932435AbbG1Nqy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:46:54 -0400
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
	Duc Dang <dhdang@apm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 09/19] drivers: base: Add MSI domain support for non-PCI devices
Date: Tue, 28 Jul 2015 14:46:16 +0100
Message-Id: <1438091186-10244-10-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the msi_list and the msi_domain properties now being at the
generic device level, it is starting to be relatively easy to offer
a generic way of providing non-PCI MSIs.

The two major hurdles with this idea are:

- Lack of global ID that identifies a device: this is worked around by
  having a global ID allocator for each device that gets enrolled in
  the platform MSI subsystem

- Lack of standard way to write the message in the generating device.
  This is solved by mandating driver code to provide a write_msg
  callback, so that everyone can have their own square wheel

Apart from that, the API is fairly straightforward:

- platform_msi_create_irq_domain creates an MSI domain that gets
  tagged with DOMAIN_BUS_PLATFORM_MSI

- platform_msi_domain_alloc_irqs allocate MSIs for a given device,
  populating the msi_list

- platform_msi_domain_free_irqs does what is written on the tin

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/Makefile       |   1 +
 drivers/base/platform-msi.c | 282 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |  15 +++
 3 files changed, 298 insertions(+)
 create mode 100644 drivers/base/platform-msi.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 527d291..6b2a84e 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_REGMAP)	+= regmap/
 obj-$(CONFIG_SOC_BUS) += soc.o
 obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
+obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
new file mode 100644
index 0000000..1857a5d
--- /dev/null
+++ b/drivers/base/platform-msi.c
@@ -0,0 +1,282 @@
+/*
+ * MSI framework for platform devices
+ *
+ * Copyright (C) 2015 ARM Limited, All Rights Reserved.
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
+#include <linux/idr.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/slab.h>
+
+#define DEV_ID_SHIFT	24
+
+/*
+ * Internal data structure containing a (made up, but unique) devid
+ * and the callback to write the MSI message.
+ */
+struct platform_msi_priv_data {
+	irq_write_msi_msg_t	write_msg;
+	int			devid;
+};
+
+/* The devid allocator */
+static DEFINE_IDA(platform_msi_devid_ida);
+
+#ifdef GENERIC_MSI_DOMAIN_OPS
+/*
+ * Convert an msi_desc to a globaly unique identifier (per-device
+ * devid + msi_desc position in the msi_list).
+ */
+static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
+{
+	u32 devid;
+
+	devid = desc->platform.msi_priv_data->devid;
+
+	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
+}
+
+static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = platform_msi_calc_hwirq(desc);
+}
+
+static int platform_msi_init(struct irq_domain *domain,
+			     struct msi_domain_info *info,
+			     unsigned int virq, irq_hw_number_t hwirq,
+			     msi_alloc_info_t *arg)
+{
+	struct irq_data *data;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+				      info->chip, info->chip_data);
+
+	/*
+	 * Save the MSI descriptor in handler_data so that the
+	 * irq_write_msi_msg callback can retrieve it (and the
+	 * associated device).
+	 */
+	data = irq_domain_get_irq_data(domain, virq);
+	data->handler_data = arg->desc;
+
+	return 0;
+}
+#else
+#define platform_msi_set_desc		NULL
+#define platform_msi_init		NULL
+#endif
+
+static void platform_msi_update_dom_ops(struct msi_domain_info *info)
+{
+	struct msi_domain_ops *ops = info->ops;
+
+	BUG_ON(!ops);
+
+	if (ops->msi_init == NULL)
+		ops->msi_init = platform_msi_init;
+	if (ops->set_desc == NULL)
+		ops->set_desc = platform_msi_set_desc;
+}
+
+static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_irq_handler_data(data);
+	struct platform_msi_priv_data *priv_data;
+
+	priv_data = desc->platform.msi_priv_data;
+
+	priv_data->write_msg(desc, msg);
+}
+
+static void platform_msi_update_chip_ops(struct msi_domain_info *info)
+{
+	struct irq_chip *chip = info->chip;
+
+	BUG_ON(!chip);
+	if (!chip->irq_mask)
+		chip->irq_mask = irq_chip_mask_parent;
+	if (!chip->irq_unmask)
+		chip->irq_unmask = irq_chip_unmask_parent;
+	if (!chip->irq_eoi)
+		chip->irq_eoi = irq_chip_eoi_parent;
+	if (!chip->irq_set_affinity)
+		chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_write_msi_msg)
+		chip->irq_write_msi_msg = platform_msi_write_msg;
+}
+
+static void platform_msi_free_descs(struct device *dev)
+{
+	struct msi_desc *desc, *tmp;
+
+	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+		list_del(&desc->list);
+		free_msi_entry(desc);
+	}
+}
+
+static int platform_msi_alloc_descs(struct device *dev, int nvec,
+				    struct platform_msi_priv_data *data)
+
+{
+	int i;
+
+	for (i = 0; i < nvec; i++) {
+		struct msi_desc *desc;
+
+		desc = alloc_msi_entry(dev);
+		if (!desc)
+			break;
+
+		desc->platform.msi_priv_data = data;
+		desc->platform.msi_index = i;
+		desc->nvec_used = 1;
+
+		list_add_tail(&desc->list, dev_to_msi_list(dev));
+	}
+
+	if (i != nvec) {
+		/* Clean up the mess */
+		platform_msi_free_descs(dev);
+
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
+ * @np:		Optional device-tree node of the interrupt controller
+ * @info:	MSI domain info
+ * @parent:	Parent irq domain
+ *
+ * Updates the domain and chip ops and creates a platform MSI
+ * interrupt domain.
+ *
+ * Returns:
+ * A domain pointer or NULL in case of failure.
+ */
+struct irq_domain *platform_msi_create_irq_domain(struct device_node *np,
+						  struct msi_domain_info *info,
+						  struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
+		platform_msi_update_dom_ops(info);
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		platform_msi_update_chip_ops(info);
+
+	domain = msi_create_irq_domain(np, info, parent);
+	if (domain)
+		domain->bus_token = DOMAIN_BUS_PLATFORM_MSI;
+
+	return domain;
+}
+
+/**
+ * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
+ * @dev:		The device for which to allocate interrupts
+ * @nvec:		The number of interrupts to allocate
+ * @write_msi_msg:	Callback to write an interrupt message for @dev
+ *
+ * Returns:
+ * Zero for success, or an error code in case of failure
+ */
+int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
+				   irq_write_msi_msg_t write_msi_msg)
+{
+	struct platform_msi_priv_data *priv_data;
+	int err;
+
+	/*
+	 * Limit the number of interrupts to 256 per device. Should we
+	 * need to bump this up, DEV_ID_SHIFT should be adjusted
+	 * accordingly (which would impact the max number of MSI
+	 * capable devices).
+	 */
+	if (!dev->msi_domain || !write_msi_msg || !nvec ||
+	    nvec > (1 << (32 - DEV_ID_SHIFT)))
+		return -EINVAL;
+
+	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
+		dev_err(dev, "Incompatible msi_domain, giving up\n");
+		return -EINVAL;
+	}
+
+	/* Already had a helping of MSI? Greed... */
+	if (!list_empty(dev_to_msi_list(dev)))
+		return -EBUSY;
+
+	priv_data = kzalloc(sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	priv_data->devid = ida_simple_get(&platform_msi_devid_ida,
+					  0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
+	if (priv_data->devid < 0) {
+		err = priv_data->devid;
+		goto out_free_data;
+	}
+
+	priv_data->write_msg = write_msi_msg;
+
+	err = platform_msi_alloc_descs(dev, nvec, priv_data);
+	if (err)
+		goto out_free_id;
+
+	err = msi_domain_alloc_irqs(dev->msi_domain, dev, nvec);
+	if (err)
+		goto out_free_desc;
+
+	return 0;
+
+out_free_desc:
+	platform_msi_free_descs(dev);
+out_free_id:
+	ida_simple_remove(&platform_msi_devid_ida, priv_data->devid);
+out_free_data:
+	kfree(priv_data);
+
+	return err;
+}
+
+/**
+ * platform_msi_domain_free_irqs - Free MSI interrupts for @dev
+ * @dev:	The device for which to free interrupts
+ */
+void platform_msi_domain_free_irqs(struct device *dev)
+{
+	struct msi_desc *desc;
+
+	desc = first_msi_entry(dev);
+	if (desc) {
+		struct platform_msi_priv_data *data;
+
+		data = desc->platform.msi_priv_data;
+
+		ida_simple_remove(&platform_msi_devid_ida, data->devid);
+		kfree(data);
+	}
+
+	msi_domain_free_irqs(dev->msi_domain, dev);
+	platform_msi_free_descs(dev);
+}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index c10ec56..c4e6e83 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -18,6 +18,11 @@ struct pci_dev;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 
+typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
+				    struct msi_msg *msg);
+
+struct platform_msi_priv_data;
+
 struct msi_desc {
 	struct list_head		list;
 	unsigned int			irq;
@@ -42,6 +47,10 @@ struct msi_desc {
 				void __iomem *mask_base;
 			};
 		};
+		struct {
+			struct platform_msi_priv_data *msi_priv_data;
+			u16 msi_index;
+		} platform;
 	};
 };
 
@@ -228,6 +237,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
+struct irq_domain *platform_msi_create_irq_domain(struct device_node *np,
+						  struct msi_domain_info *info,
+						  struct irq_domain *parent);
+int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
+				   irq_write_msi_msg_t write_msi_msg);
+void platform_msi_domain_free_irqs(struct device *dev);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-- 
2.1.4

