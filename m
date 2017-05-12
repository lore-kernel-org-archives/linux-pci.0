Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:44414 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756965AbdELQ4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2017 12:56:45 -0400
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
Subject: [RFC 4/8] pci: artpec6 SoC driver adapted to new irq API
Date: Fri, 12 May 2017 17:56:13 +0100
Message-Id: <6068a528f4112f5c8583051b7f7e702f43108878.1494606911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts artpec6 SoC specific driver to use the new interrupt api
available in pcie-designware.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/dwc/pcie-artpec6.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 82a04ac..d81789b 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -188,15 +188,6 @@ static struct dw_pcie_host_ops artpec6_pcie_host_ops = {
 	.host_init = artpec6_pcie_host_init,
 };
 
-static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
-{
-	struct artpec6_pcie *artpec6_pcie = arg;
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 				 struct platform_device *pdev)
 {
@@ -211,15 +202,6 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 			dev_err(dev, "failed to get MSI irq\n");
 			return -ENODEV;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       artpec6_pcie_msi_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "artpec6-pcie-msi", artpec6_pcie);
-		if (ret) {
-			dev_err(dev, "failed to request MSI irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
-- 
2.9.3
