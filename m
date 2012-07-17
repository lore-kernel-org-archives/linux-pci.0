Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:6722 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753333Ab2GQC5e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jul 2012 22:57:34 -0400
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH] PCI: use dev->irq instead of dev->pin to enable non MSI/INTx interrupt
Date: Tue, 17 Jul 2012 10:35:51 +0800
Message-ID: <1342492551-13766-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, root port has neither MSI/MSI-X nor INTx interrupt
generated in RC mode. In this case, we have to use other interrupt(i.e.
system shared interrupt) for port service irq to have AER, Hot-plug, etc,
services to work.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/pci/pcie/portdrv_core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 75915b3..a855254 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -212,8 +212,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
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


