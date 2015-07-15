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
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v4 17/19] irqchip: GICv2m: Add platform MSI support
Date: Wed, 15 Jul 2015 13:16:51 +0100
Message-Id: <1436962613-17359-18-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to support non-PCI MSI with GICv2m, add the minimal
required entry points for the MSI domain, which is actually almost
nothing (we just use the defaults provided by the core code).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index ec9c376..db04fc1 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -50,7 +50,6 @@ struct v2m_data {
 	u32 spi_start;		/* The SPI number that MSIs start */
 	u32 nr_spis;		/* The number of SPIs for MSIs */
 	unsigned long *bm;	/* MSI vector bitmap */
-	struct irq_domain *domain;
 };
 
 static void gicv2m_mask_msi_irq(struct irq_data *d)
@@ -212,12 +211,25 @@ static bool is_msi_spi_valid(u32 base, u32 num)
 	return true;
 }
 
+static struct irq_chip gicv2m_pmsi_irq_chip = {
+	.name			= "pMSI",
+};
+
+static struct msi_domain_ops gicv2m_pmsi_ops = {
+};
+
+static struct msi_domain_info gicv2m_pmsi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.ops	= &gicv2m_pmsi_ops,
+	.chip	= &gicv2m_pmsi_irq_chip,
+};
+
 static int __init gicv2m_init_one(struct device_node *node,
 				  struct irq_domain *parent)
 {
 	int ret;
 	struct v2m_data *v2m;
-	struct irq_domain *inner_domain;
+	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 
 	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
 	if (!v2m) {
@@ -270,10 +282,13 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
 	inner_domain->parent = parent;
-	v2m->domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
-						inner_domain);
-	if (!v2m->domain) {
-		pr_err("Failed to create MSI domain\n");
+	pci_domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
+					       inner_domain);
+	plat_domain = platform_msi_create_irq_domain(node,
+						     &gicv2m_pmsi_domain_info,
+						     inner_domain);
+	if (!pci_domain || !plat_domain) {
+		pr_err("Failed to create MSI domains\n");
 		ret = -ENOMEM;
 		goto err_free_domains;
 	}
@@ -287,8 +302,10 @@ static int __init gicv2m_init_one(struct device_node *node,
 	return 0;
 
 err_free_domains:
-	if (v2m->domain)
-		irq_domain_remove(v2m->domain);
+	if (plat_domain)
+		irq_domain_remove(plat_domain);
+	if (pci_domain)
+		irq_domain_remove(pci_domain);
 	if (inner_domain)
 		irq_domain_remove(inner_domain);
 err_free_bm:
-- 
2.1.4

