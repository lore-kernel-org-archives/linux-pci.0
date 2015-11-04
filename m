Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:41945 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965184AbbKDOHw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 09:07:52 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 19:37:49 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 04/50] powerpc/powernv: Cleanup on pnv_pci_ioda_controller_ops
Date: Thu,  5 Nov 2015 00:12:04 +1100
Message-Id: <1446642770-4681-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This cleans up on pnv_pci_ioda_controller_ops struct to use tab
instead of space indent of statement to avoid complains from
scripts/checkpatch.pl. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2e2bedb..aa3645c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3064,17 +3064,17 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 }
 
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
-       .dma_dev_setup = pnv_pci_dma_dev_setup,
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
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
 
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
-- 
2.1.0

