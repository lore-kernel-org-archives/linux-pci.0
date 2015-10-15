Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36754 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbbJOPjl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 11:39:41 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Ma Jun <majun258@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 5/7] genirq/msi: Add msi_domain_populate_irqs
Date: Thu, 15 Oct 2015 16:39:26 +0100
Message-Id: <1444923568-17413-6-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To be able to allocate interrupts from the MSI layer down,
add a new msi_domain_populate_irqs entry point.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5bb36a9..e35558c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -281,6 +281,8 @@ void platform_msi_domain_free_irqs(struct device *dev);
 /* When an MSI domain is used as an intermediate domain */
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *args);
+int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
+			     int virq, int nvec, msi_alloc_info_t *args);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8e6e112..53118e9 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -272,6 +272,33 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 	return 0;
 }
 
+int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
+			     int virq, int nvec, msi_alloc_info_t *arg)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev) {
+		int i, ret;
+
+		if (!(desc->irq >= virq && desc->irq < (virq + nvec)))
+			continue;
+
+		ops->set_desc(arg, desc);
+		/* Assumes the domain mutex is held! */
+		ret = irq_domain_alloc_irqs_recursive(domain, virq, nvec, arg);
+		/* FIXME: Error handling */
+		if (ret)
+			return ret;
+
+		for (i = 0; i < desc->nvec_used; i++)
+			irq_set_msi_desc_off(virq, i, desc);
+	}
+
+	return 0;
+}
+
 /**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
-- 
2.1.4

