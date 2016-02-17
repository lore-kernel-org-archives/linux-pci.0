Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:35069 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbcBQDqF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:46:05 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:46:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 04/45] powerpc/powernv: Cleanup on pci_controller_ops instances
Date: Wed, 17 Feb 2016 14:43:47 +1100
Message-Id: <1455680668-23298-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This cleans up on below data struct instances to use tab instead of
space indent of statement to avoid complains from scripts/checkpatch.pl.
No logical changes introduced.

  @pnv_pci_ioda_controller_ops
  @pnv_npu_ioda_controller_ops

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c5baaf3..524c9c7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3210,31 +3210,31 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 }
 
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
-       .dma_dev_setup = pnv_pci_dma_dev_setup,
-       .dma_bus_setup = pnv_pci_dma_bus_setup,
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
+	.dma_bus_setup		= pnv_pci_dma_bus_setup,
 #ifdef CONFIG_PCI_MSI
-       .setup_msi_irqs = pnv_setup_msi_irqs,
-       .teardown_msi_irqs = pnv_teardown_msi_irqs,
+	.setup_msi_irqs		= pnv_setup_msi_irqs,
+	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
-       .enable_device_hook = pnv_pci_enable_device_hook,
-       .window_alignment = pnv_pci_window_alignment,
-       .reset_secondary_bus = pnv_pci_reset_secondary_bus,
-       .dma_set_mask = pnv_pci_ioda_dma_set_mask,
-       .dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask,
-       .shutdown = pnv_pci_ioda_shutdown,
+	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.window_alignment	= pnv_pci_window_alignment,
+	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
+	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
+	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
+	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
-	.dma_dev_setup = pnv_pci_dma_dev_setup,
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 #ifdef CONFIG_PCI_MSI
-	.setup_msi_irqs = pnv_setup_msi_irqs,
-	.teardown_msi_irqs = pnv_teardown_msi_irqs,
+	.setup_msi_irqs		= pnv_setup_msi_irqs,
+	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
-	.enable_device_hook = pnv_pci_enable_device_hook,
-	.window_alignment = pnv_pci_window_alignment,
-	.reset_secondary_bus = pnv_pci_reset_secondary_bus,
-	.dma_set_mask = pnv_npu_dma_set_mask,
-	.shutdown = pnv_pci_ioda_shutdown,
+	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.window_alignment	= pnv_pci_window_alignment,
+	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
+	.dma_set_mask		= pnv_npu_dma_set_mask,
+	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
-- 
2.1.0

