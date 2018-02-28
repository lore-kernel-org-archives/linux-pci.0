Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53858 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeB1MEh (ORCPT
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
Subject: [PATCH v8 6/9] PCI: dwc: qcom: Switch to use the new IRQ API
Date: Wed, 28 Feb 2018 12:04:19 +0000
Message-Id: <72e1aa7e77c31872a40246cbb5858d20a0fcfd4a.1519819020.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
References: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
References: <cover.1519819020.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes QCOM SoC specific driver to use the new IRQ API available in
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

 drivers/pci/dwc/pcie-qcom.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 6310c66..89e5cc5 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -180,13 +180,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
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
@@ -1262,15 +1255,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
