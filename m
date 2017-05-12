Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:59977 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756954AbdELQ4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2017 12:56:39 -0400
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
Subject: [RFC 3/8] pci: imx6 SoC driver adapted to new irq API
Date: Fri, 12 May 2017 17:56:12 +0100
Message-Id: <31c0ce86402fbcccb22a5f1aab7cd184e2c5ba9e.1494606911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts imx6 SoC specific driver to use the new interrupt api
available in pcie-designware.


Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/dwc/pci-imx6.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index a98cba5..f22ce1f 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -490,15 +490,6 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 	return -EINVAL;
 }
 
-static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
-{
-	struct imx6_pcie *imx6_pcie = arg;
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -620,15 +611,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 			dev_err(dev, "failed to get MSI irq\n");
 			return -ENODEV;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       imx6_pcie_msi_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "mx6-pcie-msi", imx6_pcie);
-		if (ret) {
-			dev_err(dev, "failed to request MSI irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
-- 
2.9.3
