Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:51332 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeABTIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 14:08:24 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v4 08/10] PCI: dwc: keystone: Reuse designware domain allocation
Date: Fri, 29 Dec 2017 14:21:40 +0000
Message-Id: <886911bf51e149b1c739a26d514f93f874b2c3e8.1514524551.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes msi_host_init function content in order to reuse designware domain
allocation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Didn't exist.
Change v2->v3:
- Didn't exist.
Change v3->v4:
- New patch file.

 drivers/pci/dwc/pci-keystone-dw.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 76e73d5..0390478 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -165,24 +165,8 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-	struct device *dev = pci->dev;
-	int i;
-
-	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
-					       MAX_MSI_IRQS,
-					       &ks_dw_pcie_msi_domain_ops,
-					       chip);
 
-	if (!pp->irq_domain) {
-		dev_err(dev, "irq domain init failed\n");
-		return -ENXIO;
-	}
-
-	for (i = 0; i < MAX_MSI_IRQS; i++)
-		irq_create_mapping(pp->irq_domain, i);
-
-	return 0;
+	return dw_pcie_allocate_domains(pci);
 }
 
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
-- 
2.7.4
