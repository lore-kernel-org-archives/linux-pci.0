Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:35533
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087Ab2GPDxN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jul 2012 23:53:13 -0400
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>,
	Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH 2/2 v2] powerpc/fsl: PCI: add quirk_enable_non_msi_intx_interrupt
Date: Mon, 16 Jul 2012 11:31:27 +0800
Message-ID: <1342409487-28256-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On current fsl powerpc platforms, the PCIe root port doesn't support
generating MSI/MSI-X and INTx interrupt in RC mode (those interrupts
are supported only in EP mode). So we use the shared error interrupt
by flag PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ for PCIe port driver to
support AER, Hot-plug etc, services.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: separated platform-specific part to arch/powerpc/sysdev.

 arch/powerpc/sysdev/fsl_pci.c |    2 ++
 arch/powerpc/sysdev/fsl_pci.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 6073288..fb8862f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -498,6 +498,8 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
+			quirk_enable_non_msi_intx_interrupt);
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..a98c6d8 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -91,6 +91,7 @@ struct ccsr_pci {
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
+extern void __devinit quirk_enable_non_msi_intx_interrupt(struct pci_dev *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
 #endif /* __POWERPC_FSL_PCI_H */
-- 
1.6.4


