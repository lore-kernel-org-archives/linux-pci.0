Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Duc Dang <dhdang@apm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 18/19] PCI/MSI: pci-xgene-msi: Get rid of struct msi_controller
Date: Wed, 15 Jul 2015 13:16:52 +0100
Message-Id: <1436962613-17359-19-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The XGene MSI driver only uses the msi_controller structure as
a way to match the host bridge  with its MSI HW, and thus the
msi_domain.

But now that we can directly associate an msi_domain with a device,
there is no use keeping this msi_controller around.

Just remove all traces of msi_controller from the driver.

Tested-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/host/pci-xgene-msi.c | 41 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 2d31d4d..ec5a14b 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -40,8 +40,8 @@ struct xgene_msi_group {
 
 struct xgene_msi {
 	struct device_node	*node;
-	struct msi_controller	mchip;
-	struct irq_domain	*domain;
+	struct irq_domain	*inner_domain;
+	struct irq_domain	*msi_domain;
 	u64			msi_addr;
 	void __iomem		*msi_regs;
 	unsigned long		*bitmap;
@@ -252,17 +252,17 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int xgene_allocate_domains(struct xgene_msi *msi)
 {
-	msi->domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
-					    &msi_domain_ops, msi);
-	if (!msi->domain)
+	msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
+						  &msi_domain_ops, msi);
+	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->mchip.domain = pci_msi_create_irq_domain(msi->mchip.of_node,
-						      &xgene_msi_domain_info,
-						      msi->domain);
+	msi->msi_domain = pci_msi_create_irq_domain(msi->node,
+						    &xgene_msi_domain_info,
+						    msi->inner_domain);
 
-	if (!msi->mchip.domain) {
-		irq_domain_remove(msi->domain);
+	if (!msi->msi_domain) {
+		irq_domain_remove(msi->inner_domain);
 		return -ENOMEM;
 	}
 
@@ -271,10 +271,10 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 
 static void xgene_free_domains(struct xgene_msi *msi)
 {
-	if (msi->mchip.domain)
-		irq_domain_remove(msi->mchip.domain);
-	if (msi->domain)
-		irq_domain_remove(msi->domain);
+	if (msi->msi_domain)
+		irq_domain_remove(msi->msi_domain);
+	if (msi->inner_domain)
+		irq_domain_remove(msi->inner_domain);
 }
 
 static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
@@ -340,7 +340,7 @@ static void xgene_msi_isr(unsigned int irq, struct irq_desc *desc)
 			 * CPU0
 			 */
 			hw_irq = hwirq_to_canonical_hwirq(hw_irq);
-			virq = irq_find_mapping(xgene_msi->domain, hw_irq);
+			virq = irq_find_mapping(xgene_msi->inner_domain, hw_irq);
 			WARN_ON(!virq);
 			if (virq != 0)
 				generic_handle_irq(virq);
@@ -497,7 +497,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-
+	xgene_msi->node = pdev->dev.of_node;
 	xgene_msi->num_cpus = num_possible_cpus();
 
 	rc = xgene_msi_init_allocator(xgene_msi);
@@ -561,19 +561,10 @@ static int xgene_msi_probe(struct platform_device *pdev)
 
 	cpu_notifier_register_done();
 
-	xgene_msi->mchip.of_node = pdev->dev.of_node;
-	rc = of_pci_msi_chip_add(&xgene_msi->mchip);
-	if (rc) {
-		dev_err(&pdev->dev, "failed to add MSI controller chip\n");
-		goto error_notifier;
-	}
-
 	dev_info(&pdev->dev, "APM X-Gene PCIe MSI driver loaded\n");
 
 	return 0;
 
-error_notifier:
-	unregister_hotcpu_notifier(&xgene_msi_cpu_notifier);
 error:
 	xgene_msi_remove(pdev);
 	return rc;
-- 
2.1.4

