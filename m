Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:41463 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbHFENQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 00:13:16 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 6 Aug 2015 14:13:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 21/42] powerpc/powernv: Remove DMA32 list of PEs
Date: Thu,  6 Aug 2015 14:11:26 +1000
Message-Id: <1438834307-26960-22-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Every PHB maintains a list of PEs based on their DMA32 weight. After
patch "powerpc/powernv: Create PEs dynamically", the list is useless
and it's safe to remove it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 18 ------------------
 arch/powerpc/platforms/powernv/pci.h      |  6 ------
 2 files changed, 24 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 37847a3..84b771e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -938,20 +938,6 @@ out:
 	return 0;
 }
 
-static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
-				       struct pnv_ioda_pe *pe)
-{
-	struct pnv_ioda_pe *lpe;
-
-	list_for_each_entry(lpe, &phb->ioda.pe_dma_list, dma_link) {
-		if (lpe->dma32_weight < pe->dma32_weight) {
-			list_add_tail(&pe->dma_link, &lpe->dma_link);
-			return;
-		}
-	}
-	list_add_tail(&pe->dma_link, &phb->ioda.pe_dma_list);
-}
-
 static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
@@ -1169,9 +1155,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	/* Put PE to the list */
 	list_add_tail(&pe->list, &phb->ioda.pe_list);
 
-	/* Link the PE */
-	pnv_ioda_link_pe_by_weight(phb, pe);
-
 	return pe;
 }
 
@@ -3313,7 +3296,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->ioda.root_pe_idx = IODA_INVALID_PE;
 	}
 
-	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
 	mutex_init(&phb->ioda.pe_list_mutex);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index a160491..f8e6022 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -83,7 +83,6 @@ struct pnv_ioda_pe {
 	struct list_head	slaves;
 
 	/* Link in list of PE#s */
-	struct list_head	dma_link;
 	struct list_head	list;
 };
 
@@ -185,11 +184,6 @@ struct pnv_phb {
 			/* 32-bit TCE tables allocation */
 			unsigned long		dma32_segcount;
 
-			/* Sorted list of used PE's, sorted at
-			 * boot for resource allocation purposes
-			 */
-			struct list_head	pe_dma_list;
-
 			/* TCE cache invalidate registers (physical and
 			 * remapped)
 			 */
-- 
2.1.0

