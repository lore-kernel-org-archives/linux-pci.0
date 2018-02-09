Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:9006 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIMEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Feb 2018 07:04:01 -0500
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/3] PCI: dwc: pci-dra7xx: Improve MSI IRQ handling
Date: Fri, 9 Feb 2018 17:34:14 +0530
Message-ID: <20180209120415.17590-3-vigneshr@ti.com>
In-Reply-To: <20180209120415.17590-1-vigneshr@ti.com>
References: <20180209120415.17590-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to ensure that there are no pending MSI IRQ vector set (i.e
PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting
dra7xx_pcie_msi_irq_handler(). Else, the dra7xx PCIe wrapper will not
register new MSI IRQs even though PCIE_MSI_INTR0_STATUS shows IRQs are
pending. Therefore, keep calling dra7xx_pcie_msi_irq_handler() until it
returns IRQ_NONE, which suggests that PCIE_MSI_INTR0_STATUS is 0.

This fixes a bug, where PCIe wifi cards with 4 DMA queues like Intel
8260 used to throw following error and stall during ping/iperf3 tests.

[   97.776310] iwlwifi 0000:01:00.0: Queue 9 stuck for 2500 ms.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index ed8558d638e5..3420cbf7b60a 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -254,14 +254,31 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	struct dra7xx_pcie *dra7xx = arg;
 	struct dw_pcie *pci = dra7xx->pci;
 	struct pcie_port *pp = &pci->pp;
+	int count = 0;
 	unsigned long reg;
 	u32 virq, bit;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
 
 	switch (reg) {
 	case MSI:
-		dw_handle_msi_irq(pp);
+		/*
+		 * Need to make sure no MSI IRQs are pending before
+		 * exiting handler, else the wrapper will not catch new
+		 * IRQs. So loop around till dw_handle_msi_irq() returns
+		 * IRQ_NONE
+		 */
+		while (dw_handle_msi_irq(pp) != IRQ_NONE && count < 1000)
+			count++;
+
+		if (count == 1000) {
+			dev_err(pci->dev, "too much work in msi irq\n");
+			dra7xx_pcie_writel(dra7xx,
+					   PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
+					   reg);
+			return IRQ_HANDLED;
+		}
 		break;
 	case INTA:
 	case INTB:
@@ -275,8 +292,6 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 		break;
 	}
 
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.16.1
