Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:39780 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeABTIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 14:08:22 -0500
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
Subject: [PATCH v4 05/10] PCI: dwc: designware: Switch to use the IRQ chained API
Date: Fri, 29 Dec 2017 14:21:37 +0000
Message-Id: <e160d2dba4025a3f0f58f02763c18c05b10db7cf.1514524551.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes designware generic driver to use the IRQ chained API available in
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

 drivers/pci/dwc/pcie-designware-plat.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 168e238..c148152 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -28,13 +28,6 @@ struct dw_plat_pcie {
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
@@ -66,15 +59,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
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
