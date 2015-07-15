Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38742 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbbGOMR0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 08:17:26 -0400
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
Subject: [PATCH v4 12/19] irqchip: gicv3-its: Register irq domain with NEXUS token
Date: Wed, 15 Jul 2015 13:16:46 +0100
Message-Id: <1436962613-17359-13-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we can distinguish between multiple domains carrying the
same device_node, tag the raw ITS domain with DOMAIN_BUS_NEXUS.
This will allow MSI providers built on top of the raw ITS domain
to identify it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7c01fe4..3f95826 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1407,13 +1407,14 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
 	if (of_property_read_bool(its->msi_chip.of_node, "msi-controller")) {
-		its->domain = irq_domain_add_tree(NULL, &its_domain_ops, its);
+		its->domain = irq_domain_add_tree(node, &its_domain_ops, its);
 		if (!its->domain) {
 			err = -ENOMEM;
 			goto out_free_tables;
 		}
 
 		its->domain->parent = parent;
+		its->domain->bus_token = DOMAIN_BUS_NEXUS_MSI;
 
 		its->msi_chip.domain = its_pci_msi_alloc_domain(node,
 								its->domain);
-- 
2.1.4

