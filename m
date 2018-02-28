Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:53870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeB1MEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 07:04:37 -0500
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
Subject: [PATCH v8 5/9] PCI: dwc: designware: Switch to use the new IRQ API
Date: Wed, 28 Feb 2018 12:04:18 +0000
Message-Id: <416285337899baa87d7d42ab81c00ff3ec48530e.1519819020.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
References: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
References: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes designware generic driver to use the new IRQ API available in
pcie-designware.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
Change v7->v8:
- Rebased against v4.16-rc1.

 drivers/pci/dwc/pcie-designware-plat.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index ebdf28b..5416aa8 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -25,13 +25,6 @@ struct dw_plat_pcie {
 	struct dw_pcie		*pci;
 };
 
-static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int dw_plat_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -63,15 +56,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					dw_plat_pcie_msi_irq_handler,
-					IRQF_SHARED | IRQF_NO_THREAD,
-					"dw-plat-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "failed to request MSI IRQ\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
-- 
2.7.4
