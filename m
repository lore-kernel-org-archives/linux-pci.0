Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34026 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbbI3WrN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2015 18:47:13 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v3 4/4] irqchip/gic-v3-its:  Add handling of PCI requester id.
Date: Wed, 30 Sep 2015 15:47:02 -0700
Message-Id: <1443653222-24924-5-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1443653222-24924-1-git-send-email-ddaney.cavm@gmail.com>
References: <1443653222-24924-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Replace open coded generation PCI/MSI requester id with call to the
new function pci_msi_domain_get_msi_rid() which applies the "msi-map"
to the id value.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cf351c6..7bbf64a 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -42,7 +42,6 @@ static struct irq_chip its_msi_irq_chip = {
 
 struct its_pci_alias {
 	struct pci_dev	*pdev;
-	u32		dev_id;
 	u32		count;
 };
 
@@ -60,7 +59,6 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct its_pci_alias *dev_alias = data;
 
-	dev_alias->dev_id = alias;
 	if (pdev != dev_alias->pdev)
 		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
 
@@ -86,7 +84,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = dev_alias.dev_id;
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
 
 	return msi_info->ops->msi_prepare(domain->parent,
 					  dev, dev_alias.count, info);
-- 
1.9.1

