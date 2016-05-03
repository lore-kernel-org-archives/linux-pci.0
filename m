Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:37492 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926AbcECNX6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 09:23:58 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 3 May 2016 23:23:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
	alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 03/22] powerpc/powernv: Move pnv_pci_ioda_setup_opal_tce_kill() around
Date: Tue,  3 May 2016 23:22:34 +1000
Message-Id: <1462281773-26438-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pnv_pci_ioda_setup_opal_tce_kill() called by pnv_ioda_setup_dma()
to remap the TCE kill regiter. What's done in pnv_ioda_setup_dma()
will be covered in pcibios_setup_bridge() which is invoked on each
PCI bridge. It means we will possibly remap the TCE kill register
for multiple times and it's unnecessary.

This moves pnv_pci_ioda_setup_opal_tce_kill() to where the PHB is
initialized (pnv_pci_init_ioda_phb()) to avoid above issue.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5ee8a57..cbd4c0b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2599,8 +2599,6 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 	pr_info("PCI: Domain %04x has %d available 32-bit DMA segments\n",
 		hose->global_number, phb->ioda.dma32_count);
 
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
 	/* Walk our PE list and configure their DMA segments */
 	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
 		weight = pnv_pci_ioda_pe_dma_weight(pe);
@@ -3396,6 +3394,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (phb->regs == NULL)
 		pr_err("  Failed to map registers !\n");
 
+	/* Initialize TCE kill register */
+	pnv_pci_ioda_setup_opal_tce_kill(phb);
+
 	/* Initialize more IODA stuff */
 	phb->ioda.total_pe_num = 1;
 	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
-- 
2.1.0

