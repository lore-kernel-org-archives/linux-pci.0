Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:60647 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975AbcBQDp5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:45:57 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 14/45] powerpc/powernv/ioda1: Rename pnv_pci_ioda_setup_dma_pe()
Date: Wed, 17 Feb 2016 14:43:57 +1100
Message-Id: <1455680668-23298-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This renames pnv_pci_ioda_setup_dma_pe() to pnv_pci_ioda1_setup_dma_pe()
as it's the counter-part of IODA2's pnv_pci_ioda2_setup_dma_pe().
No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8488238..d18b95e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2026,9 +2026,10 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.free = pnv_ioda2_table_free,
 };
 
-static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
-				      struct pnv_ioda_pe *pe, unsigned int base,
-				      unsigned int segs)
+static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
+				       struct pnv_ioda_pe *pe,
+				       unsigned int base,
+				       unsigned int segs)
 {
 
 	struct page *tce_mem = NULL;
@@ -2616,7 +2617,7 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 		if (phb->type == PNV_PHB_IODA1) {
 			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
 				pe->dma_weight, segs);
-			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
 		} else if (phb->type == PNV_PHB_IODA2) {
 			pe_info(pe, "Assign DMA32 space\n");
 			segs = 0;
-- 
2.1.0

