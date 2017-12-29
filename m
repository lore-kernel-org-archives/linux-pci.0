Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:51346 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeABTIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 14:08:24 -0500
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
Subject: [PATCH v4 03/10] PCI: dwc: imx6: Switch to use the IRQ chained API
Date: Fri, 29 Dec 2017 14:21:35 +0000
Message-Id: <9e3fee4c8b7097878b42211ef7540ff4b59c8efb.1514524551.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes iMX6 SoC specific driver to use the IRQ chained API available in
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

 drivers/pci/dwc/pci-imx6.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index b734835..d2314cb 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -545,15 +545,6 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
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
@@ -677,15 +668,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
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
2.7.4
