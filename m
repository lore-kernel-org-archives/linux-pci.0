Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0140.outbound.protection.outlook.com ([157.56.110.140]:23728
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752073AbbDOJrh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 05:47:37 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Minghuan Lian" <Minghuan.Lian@freescale.com>
Subject: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Date: Wed, 15 Apr 2015 17:49:23 +0800
Message-ID: <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SMMU of some platforms can only isolate limited device ID.
This may require that all PCI devices share the same ITS
device with the fixed device ID. The patch adds function
arch_msi_share_devid_update used for these platforms to update
the fixed device ID and maximum MSI interrupts number.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d0374a6..be78d0a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1169,6 +1169,15 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
+void __weak
+arch_msi_share_devid_update(struct pci_dev *pdev, u32 *dev_id, u32 *nvesc)
+{
+	/*
+	 * use PCI_DEVID NOT share device ID as default
+	 * so nothing need to do
+	 */
+}
+
 static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 			   int nvec, msi_alloc_info_t *info)
 {
@@ -1185,6 +1194,8 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	dev_alias.count = nvec;
 
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+	arch_msi_share_devid_update(pdev, &dev_alias.dev_id, &dev_alias.count);
+
 	its = domain->parent->host_data;
 
 	its_dev = its_find_device(its, dev_alias.dev_id);
-- 
1.9.1

