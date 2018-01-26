Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:51257 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbeAZQfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jan 2018 11:35:54 -0500
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
Subject: [PATCH v6 6/9] PCI: dwc: qcom: Switch to use the IRQ chained API
Date: Fri, 26 Jan 2018 16:35:41 +0000
Message-Id: <52ec7aebc74e6dfdad4d45d8b2563a6ebb838dc3.1516984229.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
References: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
References: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes QCOM SoC specific driver to use the IRQ chained API available in
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

 drivers/pci/dwc/pcie-qcom.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index b3adc10..6e70073 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -188,13 +188,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
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
@@ -1270,15 +1263,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-				       qcom_pcie_msi_irq_handler,
-				       IRQF_SHARED | IRQF_NO_THREAD,
-				       "qcom-pcie-msi", pp);
-		if (ret) {
-			dev_err(dev, "cannot request msi irq\n");
-			return ret;
-		}
 	}
 
 	ret = phy_init(pcie->phy);
-- 
2.7.4
