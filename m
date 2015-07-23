Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39441 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbbGWJ1K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jul 2015 05:27:10 -0400
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
Subject: [PATCH v5 07/19] PCI/MSI: Let pci_msi_get_domain use struct device's msi_domain
Date: Thu, 23 Jul 2015 10:26:26 +0100
Message-Id: <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we can easily find which MSI domain a PCI device is
using, use dev_get_msi_domain as a way to retrieve the information.

The original code is still used as a fallback.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ef4ec6e..da3c607 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -39,14 +39,16 @@ struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
 
 static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
 {
-	struct irq_domain *domain = NULL;
+	struct irq_domain *domain;
+
+	domain = dev_get_msi_domain(&dev->dev);
+	if (domain)
+		return domain;
 
-	if (dev->bus->msi)
-		domain = dev->bus->msi->domain;
-	if (!domain)
-		domain = arch_get_pci_msi_domain(dev);
+	if (dev->bus->msi && (domain = dev->bus->msi->domain))
+		return domain;
 
-	return domain;
+	return arch_get_pci_msi_domain(dev);
 }
 
 static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-- 
2.1.4

