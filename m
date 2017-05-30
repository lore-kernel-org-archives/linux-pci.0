Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60696 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdE3Ldb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2017 07:33:31 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 6/8] pci: qcom SoC driver adapted to new irq API
Date: Tue, 30 May 2017 12:32:51 +0100
Message-Id: <5fa4cebbfaaf3e310a34ec40f065a41ea3ff4ce1.1496142978.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496142978.git.jpinto@synopsys.com>
References: <cover.1496142978.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496142978.git.jpinto@synopsys.com>
References: <cover.1496142978.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts Qcom SoC specific driver to use the new interrupt api
available in pcie-designware.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/dwc/pcie-qcom.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 5bf23d4..4e1cc02 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -126,13 +126,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -724,14 +717,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       qcom_pcie_msi_irq_handler,
-				       IRQF_SHARED, "qcom-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "cannot request msi irq\n");
-			return ret;
-		}
 	}
 
 	ret = phy_init(pcie->phy);
-- 
2.9.3
