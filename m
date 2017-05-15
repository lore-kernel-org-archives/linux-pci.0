Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:41345 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755111AbdEORET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 13:04:19 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: jingoohan1@gmail.com, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [RFC v2 5/8] pci: generic PCIe DW driver adapted to new irq API
Date: Mon, 15 May 2017 18:03:45 +0100
Message-Id: <3d440aad766cfae56181a108d9028b01b7baf952.1494867112.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494867112.git.jpinto@synopsys.com>
References: <cover.1494867112.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494867112.git.jpinto@synopsys.com>
References: <cover.1494867112.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts the generic PCIe DW driver to use the new interrupt api
available in pcie-designware.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v1->v2:
- just to keep up patch set version

 drivers/pci/dwc/pcie-designware-plat.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 32091b3..3b9717b 100644
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
 static void dw_plat_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -64,14 +57,6 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					dw_plat_pcie_msi_irq_handler,
-					IRQF_SHARED, "dw-plat-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "failed to request MSI IRQ\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
-- 
2.9.3
