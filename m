Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:50220 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeBWPKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 10:10:41 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, nsekhar@ti.com, gustavo.pimentel@synopsys.com
Subject: [PATCH v7 2/9] PCI: dwc: exynos: Switch to use the new IRQ API
Date: Fri, 23 Feb 2018 15:10:25 +0000
Message-Id: <500cc507a12f20c6b2892b6c76e05960fbd6bffd.1519318663.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
References: <cover.1519318663.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes Exynos SoC specific driver to use the new IRQ API available in
pcie-designware.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
Change v1->v2:
- Nothing changed, just to follow the patch set version.
Change v2->v3:
- Nothing changed, just to follow the patch set version.
Change v3->v4:
- Changed summary line to match the drivers/PCI convention and changelog to
maintain the consistency (thanks Bjorn).
Change v4->v5:
- Nothing changed, just to follow the patch set version.
Change v5->v6:
- Nothing changed, just to follow the patch set version.
Change v6->v7:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pci-exynos.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 56f32ae..0a6b283d 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -297,15 +297,6 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct exynos_pcie *ep = arg;
-	struct dw_pcie *pci = ep->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void exynos_pcie_msi_init(struct exynos_pcie *ep)
 {
 	struct dw_pcie *pci = ep->pci;
@@ -431,15 +422,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 			dev_err(dev, "failed to get msi irq\n");
 			return pp->msi_irq;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					exynos_pcie_msi_irq_handler,
-					IRQF_SHARED | IRQF_NO_THREAD,
-					"exynos-pcie", ep);
-		if (ret) {
-			dev_err(dev, "failed to request msi irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
-- 
2.7.4
