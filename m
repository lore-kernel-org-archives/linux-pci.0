Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:54283 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdFEQUi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2017 12:20:38 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 6/9] pci: qcom SoC driver adapted to new irq API
Date: Mon,  5 Jun 2017 17:19:53 +0100
Message-Id: <5c1db0324bedd6d20dab5ee6d56c577bf7184859.1496677911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496677911.git.jpinto@synopsys.com>
References: <cover.1496677911.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496677911.git.jpinto@synopsys.com>
References: <cover.1496677911.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts Qcom SoC specific driver to use the new interrupt
api available in pcie-designware.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
Change v1->v2:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-qcom.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 289cda1..c9d24a4 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -145,13 +145,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
-static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct pcie_port *pp = arg;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
@@ -1029,14 +1022,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
