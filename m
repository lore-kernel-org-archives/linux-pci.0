Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38796 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbbGOMRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 08:17:42 -0400
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
Subject: [PATCH v4 19/19] PCI/MSI: Drop domain field from msi_controller
Date: Wed, 15 Jul 2015 13:16:53 +0100
Message-Id: <1436962613-17359-20-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The only three users of that field are not using the msi_controller
structure anymore, so drop it altogether.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c   | 2 --
 include/linux/msi.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c77fdaf..31bae50 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -42,8 +42,6 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
 	struct irq_domain *domain = NULL;
 
 	domain = dev_get_msi_domain(&dev->dev);
-	if (!domain && dev->bus->msi)
-		domain = dev->bus->msi->domain;
 	if (!domain)
 		domain = arch_get_pci_msi_domain(dev);
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b55cf63..e29c31f 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -124,9 +124,6 @@ struct msi_controller {
 	struct device *dev;
 	struct device_node *of_node;
 	struct list_head list;
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	struct irq_domain *domain;
-#endif
 
 	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
-- 
2.1.4

