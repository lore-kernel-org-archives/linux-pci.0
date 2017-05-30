Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60652 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdE3LdM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2017 07:33:12 -0400
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: bhelgaas@google.com, marc.zyngier@arm.com
Cc: m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH 2/8] pci: exynos SoC driver adapted to new irq API
Date: Tue, 30 May 2017 12:32:47 +0100
Message-Id: <ce8fe48093c7e7cc9768ebef188f97af5f8905b3.1496142978.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496142978.git.jpinto@synopsys.com>
References: <cover.1496142978.git.jpinto@synopsys.com>
In-Reply-To: <cover.1496142978.git.jpinto@synopsys.com>
References: <cover.1496142978.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adapts Exynos SoC specific driver to use the new interrupt api
available in pcie-designware.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/dwc/pci-exynos.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 546082a..e49c39a 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -490,15 +490,6 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
-{
-	struct exynos_pcie *ep = arg;
-	struct dw_pcie *pci = ep->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	return dw_handle_msi_irq(pp);
-}
-
 static void exynos_pcie_msi_init(struct exynos_pcie *ep)
 {
 	struct dw_pcie *pci = ep->pci;
@@ -622,15 +613,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 			dev_err(dev, "failed to get msi irq\n");
 			return -ENODEV;
 		}
-
-		ret = devm_request_irq(dev, pp->msi_irq,
-					exynos_pcie_msi_irq_handler,
-					IRQF_SHARED | IRQF_NO_THREAD,
-					"exynos-pcie", ep);
-		if (ret) {
-			dev_err(dev, "failed to request msi irq\n");
-			return ret;
-		}
 	}
 
 	pp->root_bus_nr = -1;
-- 
2.9.3
