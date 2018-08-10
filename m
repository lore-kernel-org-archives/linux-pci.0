Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com ([104.47.32.55]:19140
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727539AbeHJSPs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:48 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 3/4] PCI/portdrv: Check platform supported service IRQ's
Date: Fri, 10 Aug 2018 21:09:39 +0530
Message-ID: <1533915580-31805-4-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Platforms may have dedicated IRQ lines for PCIe services like
AER/PME etc., check for such IRQ lines.
Check mask and fill legacy irq line for services other than
platform supported service IRQ number.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/portdrv_core.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e0261ad..a7d024c 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -166,6 +166,19 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 		irqs[i] = -1;
 
 	/*
+	 * Some platforms have dedicated interrupt line from root complex to
+	 * interrupt controller for PCIe services like AER/PME etc., check
+	 * if platform registered with any such IRQ.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		int plat_mask;
+
+		plat_mask = pci_check_platform_service_irqs(dev, irqs, mask);
+		if (plat_mask > 0)
+			mask = mask & plat_mask;
+	}
+
+	/*
 	 * If we support PME but can't use MSI/MSI-X for it, we have to
 	 * fall back to INTx or other interrupts, e.g., a system shared
 	 * interrupt.
@@ -183,8 +196,10 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (ret < 0)
 		return -ENODEV;
 
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = pci_irq_vector(dev, 0);
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		if (mask & (1 << i))
+			irqs[i] = pci_irq_vector(dev, 0);
+	}
 
 	return 0;
 }
-- 
1.7.1
