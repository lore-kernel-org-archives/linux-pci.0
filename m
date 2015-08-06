Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:44152 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbHFENR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 00:13:17 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 6 Aug 2015 14:13:16 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 10/42] powerpc/powernv: pnv_ioda_setup_dma() configure one PE only
Date: Thu,  6 Aug 2015 14:11:15 +1000
Message-Id: <1438834307-26960-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The original implementation of pnv_ioda_setup_dma() iterates the
list of PEs and configures the DMA32 space for them one by one.
The function was designed to be called during PHB fixup time.
When configuring PE's DMA32 space in pcibios_setup_bridge(), in
order to support PCI hotplug, we have to have the function PE
oriented.

This renames pnv_ioda_setup_dma() to pnv_ioda1_setup_dma() and
adds one more argument "struct pnv_ioda_pe *pe" to it. The caller,
pnv_pci_ioda_setup_DMA(), gets PE from the list and passes to it
or pnv_pci_ioda2_setup_dma_pe(). The patch shouldn't cause behavioral
changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 75 +++++++++++++++----------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8456f37..cd22002 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2443,52 +2443,29 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
-static void pnv_ioda_setup_dma(struct pnv_phb *phb)
+static unsigned int pnv_ioda1_setup_dma(struct pnv_phb *phb,
+					struct pnv_ioda_pe *pe,
+					unsigned int base)
 {
 	struct pci_controller *hose = phb->hose;
-	struct pnv_ioda_pe *pe;
-	unsigned int dma_weight;
+	unsigned int dma_weight, segs;
 
 	/* Calculate the PHB's DMA weight */
 	dma_weight = pnv_ioda_phb_dma_weight(phb);
 	pr_info("PCI%04x has %ld DMA32 segments, total weight %d\n",
 		hose->global_number, phb->ioda.dma32_segcount, dma_weight);
 
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
-	/* Walk our PE list and configure their DMA segments, hand them
-	 * out one base segment plus any residual segments based on
-	 * weight
-	 */
-	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
-		if (!pe->dma32_weight)
-			continue;
-
-		/*
-		 * For IODA2 compliant PHB3, we needn't care about the weight.
-		 * The all available 32-bits DMA space will be assigned to
-		 * the specific PE.
-		 */
-		if (phb->type == PNV_PHB_IODA1) {
-			unsigned int segs, base = 0;
-
-			if (pe->dma32_weight <
-			    dma_weight / phb->ioda.dma32_segcount)
-				segs = 1;
-			else
-				segs = (pe->dma32_weight *
-					phb->ioda.dma32_segcount) / dma_weight;
-
-			pe_info(pe, "DMA32 weight %d, assigned %d segments\n",
-				pe->dma32_weight, segs);
-			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+	if (pe->dma32_weight <
+	    dma_weight / phb->ioda.dma32_segcount)
+		segs = 1;
+	else
+		segs = (pe->dma32_weight *
+			phb->ioda.dma32_segcount) / dma_weight;
+	pe_info(pe, "DMA weight %d, assigned %d segments\n",
+		pe->dma32_weight, segs);
+	pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
 
-			base += segs;
-		} else {
-			pe_info(pe, "Assign DMA32 space\n");
-			pnv_pci_ioda2_setup_dma_pe(phb, pe);
-		}
-	}
+	return segs;
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -2955,12 +2932,32 @@ static void pnv_pci_ioda_setup_DMA(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct pnv_phb *phb;
+	struct pnv_ioda_pe *pe;
+	unsigned int base;
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		pnv_ioda_setup_dma(hose->private_data);
+		phb = hose->private_data;
+		pnv_pci_ioda_setup_opal_tce_kill(phb);
+
+		base = 0;
+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
+			if (!pe->dma32_weight)
+				continue;
+
+			switch (phb->type) {
+			case PNV_PHB_IODA1:
+				base += pnv_ioda1_setup_dma(phb, pe, base);
+				break;
+			case PNV_PHB_IODA2:
+				pnv_pci_ioda2_setup_dma_pe(phb, pe);
+				break;
+			default:
+				pr_warn("%s: No DMA for PHB type %d\n",
+					__func__, phb->type);
+			}
+		}
 
 		/* Mark the PHB initialization done */
-		phb = hose->private_data;
 		phb->initialized = 1;
 	}
 }
-- 
2.1.0

