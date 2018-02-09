Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:9007 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeBIMEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Feb 2018 07:04:02 -0500
From: Vignesh R <vigneshr@ti.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/3] PCI: dwc: pci-dra7xx: Handle legacy and MSI IRQs together
Date: Fri, 9 Feb 2018 17:34:15 +0530
Message-ID: <20180209120415.17590-4-vigneshr@ti.com>
In-Reply-To: <20180209120415.17590-1-vigneshr@ti.com>
References: <20180209120415.17590-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, pci-dra7xx driver handles MSI and Legacy IRQs exclusive of
each other. This is not true, as there maybe both legacy and MSI IRQs
raised at the same time. Fix this by making sure that driver handles
both MSI and legacy IRQs in the IRQ handler.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 3420cbf7b60a..1ddb62620acc 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -261,8 +261,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
 
-	switch (reg) {
-	case MSI:
+	if (reg & MSI) {
 		/*
 		 * Need to make sure no MSI IRQs are pending before
 		 * exiting handler, else the wrapper will not catch new
@@ -279,17 +278,13 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 					   reg);
 			return IRQ_HANDLED;
 		}
-		break;
-	case INTA:
-	case INTB:
-	case INTC:
-	case INTD:
+	}
+	if (reg & LEG_EP_INTERRUPTS) {
 		for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
 			virq = irq_find_mapping(dra7xx->irq_domain, bit);
 			if (virq)
 				generic_handle_irq(virq);
 		}
-		break;
 	}
 
 	return IRQ_HANDLED;
-- 
2.16.1
