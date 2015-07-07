Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH v3 03/15] device core: Introduce per-device MSI domain pointer
Date: Tue,  7 Jul 2015 18:17:53 +0100
Message-Id: <1436289485-28230-4-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As MSI-type features are creeping into non-PCI devices, it is
starting to make sense to give our struct device some form of
support for this, by allowing a pointer to an MSI irq domain to
be set/retrieved.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/device.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5a31bf3..4421f2a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -713,6 +713,7 @@ struct device_dma_parameters {
  * 		along with subsystem-level and driver-level callbacks.
  * @pins:	For device pin management.
  *		See Documentation/pinctrl.txt for details.
+ * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
@@ -773,6 +774,9 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain	*msi_domain; /* MSI domain device uses */
+#endif
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
@@ -860,6 +864,22 @@ static inline void set_dev_node(struct device *dev, int node)
 }
 #endif
 
+static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	return dev->msi_domain;
+#else
+	return NULL;
+#endif
+}
+
+static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	dev->msi_domain = d;
+#endif
+}
+
 static inline void *dev_get_drvdata(const struct device *dev)
 {
 	return dev->driver_data;
-- 
2.1.4

