Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
Date: Thu, 15 Oct 2015 16:39:25 +0100
Message-Id: <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The .prepare callbacks are so far only called from msi_domain_alloc_irqs.
In order to reuse that code, split that code and create a
msi_domain_prepare_irqs function that the existing code can call into.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/msi.h |  4 ++++
 kernel/irq/msi.c    | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 32a24b9..5bb36a9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -277,6 +277,10 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 				   irq_write_msi_msg_t write_msi_msg);
 void platform_msi_domain_free_irqs(struct device *dev);
+
+/* When an MSI domain is used as an intermediate domain */
+int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *args);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 95354bb..8e6e112 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -256,6 +256,22 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					   &msi_domain_ops, info);
 }
 
+int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *arg)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+	int ret;
+
+	ret = ops->msi_check(domain, info, dev);
+	if (ret == 0)
+		ret = ops->msi_prepare(domain, dev, nvec, arg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
@@ -274,9 +290,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct msi_desc *desc;
 	int i, ret, virq = -1;
 
-	ret = ops->msi_check(domain, info, dev);
-	if (ret == 0)
-		ret = ops->msi_prepare(domain, dev, nvec, &arg);
+	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
 		return ret;
 
-- 
2.1.4

