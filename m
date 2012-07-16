Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:28627
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087Ab2GPDxH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jul 2012 23:53:07 -0400
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH 1/2 v2] PCI: Add PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ to enable non MSI/INTx interrupt
Date: Mon, 16 Jul 2012 11:31:26 +0800
Message-ID: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, in RC mode, root port has neither MSI/MSI-X nor INTx
interrupt generated, which are available only in EP mode on those platform.
In this case, we try to use other interrupt for port service driver to have
AER, Hot-plug, etc, services to work.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: separated platform-specific part to arch/powerpc/sysdev.

 drivers/pci/pcie/portdrv_core.c |   10 ++++++++--
 drivers/pci/quirks.c            |    9 +++++++++
 include/linux/pci.h             |    5 +++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 75915b3..837ad15 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -212,8 +212,14 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (!pcie_port_enable_msix(dev, irqs, mask))
 		return 0;
 
-	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
-	if (!pci_enable_msi(dev) || dev->pin)
+	/*
+	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
+	 * Eventually, if neither MSI/MSI-X nor INTx available, try other
+	 * interrupt. (On some platforms, root port doesn't support generating
+	 * MSI/MSI-X/INTx in RC mode)
+	 */
+	if (!pci_enable_msi(dev) || dev->pin || ((dev->dev_flags &
+			PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ) && dev->irq))
 		irq = dev->irq;
 
  no_msi:
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2a75216..2922cb8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2640,6 +2640,15 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x1083,
 			quirk_msi_intx_disable_bug);
 #endif /* CONFIG_PCI_MSI */
 
+/*
+ * Under some circumstances, root port has neither MSI/MSI-X nor INTx generated,
+ * so try other interrupt if supported.
+ */
+void __devinit quirk_enable_non_msi_intx_interrupt(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ;
+}
+
 /* Allow manual resource allocation for PCI hotplug bridges
  * via pci=hpmemsize=nnM and pci=hpiosize=nnM parameters. For
  * some PCI-PCI hotplug bridges, like PLX 6254 (former HINT HB6),
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d8c379d..f051a66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -176,6 +176,11 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_D3 = (__force pci_dev_flags_t) 2,
 	/* Provide indication device is assigned by a Virtual Machine Manager */
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
+	/*
+	 * Use other interrupt (i.e. system shared interrupt) when MSI/MSI-X
+	 * and INTx are not supported in RC mode on some platforms.
+	 */
+	PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ = (__force pci_dev_flags_t) 8,
 };
 
 enum pci_irq_reroute_variant {
-- 
1.6.4


