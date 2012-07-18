Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [213.199.154.205] ([213.199.154.205]:14657 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751675Ab2GRG3v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jul 2012 02:29:51 -0400
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non MSI/INTx interrupt
Date: Wed, 18 Jul 2012 14:06:54 +0800
Message-ID: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, root port has neither MSI/MSI-X nor INTx interrupt
generated in RC mode. In this case, we have to use other interrupt(e.g.
system shared interrupt) for port service irq to have AER, Hot-plug, etc,
services to work.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/pci/pcie/portdrv_core.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 75915b3..49acf72 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -200,10 +200,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int i, irq = -1;
 
-	/* We have to use INTx if MSI cannot be used for PCIe PME or pciehp. */
+	/*
+	 * We have to use INTx or other interrupts(e.g. system shared interrupt)
+	 * if MSI cannot be used for PCIe PME or pciehp.
+	 */
 	if (((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) ||
 	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
-		if (dev->pin)
+		if (dev->irq)
 			irq = dev->irq;
 		goto no_msi;
 	}
@@ -212,8 +215,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (!pcie_port_enable_msix(dev, irqs, mask))
 		return 0;
 
-	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
-	if (!pci_enable_msi(dev) || dev->pin)
+	/*
+	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
+	 * If neither MSI/MSI-X nor INTx available, try other interrupt. (On
+	 * some platforms, root port doesn't support generating MSI/MSI-X/INTx
+	 * in RC mode)
+	 */
+	if (!pci_enable_msi(dev) || dev->irq)
 		irq = dev->irq;
 
  no_msi:
-- 
1.6.4


