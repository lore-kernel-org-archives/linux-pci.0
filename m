Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:34090 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbbEAGEh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2015 02:04:37 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 1 May 2015 16:04:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 82FA12BB0051
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2015 16:04:32 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4164OCQ36700190
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2015 16:04:32 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4163weW000654
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2015 16:03:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 08/21] powerpc/powernv: Drop pnv_ioda_setup_dev_PE()
Date: Fri,  1 May 2015 16:02:55 +1000
Message-Id: <1430460188-31343-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Nobody is using the this function. The patch drops it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 71 -------------------------------
 1 file changed, 71 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ef8c216..5cd8298 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1302,77 +1302,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 }
 #endif /* CONFIG_PCI_IOV */
 
-#if 0
-static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pci_get_pdn(dev);
-	struct pnv_ioda_pe *pe;
-	int pe_num;
-
-	if (!pdn) {
-		pr_err("%s: Device tree node not associated properly\n",
-			   pci_name(dev));
-		return NULL;
-	}
-	if (pdn->pe_number != IODA_INVALID_PE)
-		return NULL;
-
-	/* PE#0 has been pre-set */
-	if (dev->bus->number == 0)
-		pe_num = 0;
-	else
-		pe_num = pnv_ioda_alloc_pe(phb);
-	if (pe_num == IODA_INVALID_PE) {
-		pr_warning("%s: Not enough PE# available, disabling device\n",
-			   pci_name(dev));
-		return NULL;
-	}
-
-	/* NOTE: We get only one ref to the pci_dev for the pdn, not for the
-	 * pointer in the PE data structure, both should be destroyed at the
-	 * same time. However, this needs to be looked at more closely again
-	 * once we actually start removing things (Hotplug, SR-IOV, ...)
-	 *
-	 * At some point we want to remove the PDN completely anyways
-	 */
-	pe = &phb->ioda.pe_array[pe_num];
-	pci_dev_get(dev);
-	pdn->pcidev = dev;
-	pdn->pe_number = pe_num;
-	pe->pdev = dev;
-	pe->pbus = NULL;
-	pe->tce32_seg = -1;
-	pe->mve_number = -1;
-	pe->rid = dev->bus->number << 8 | pdn->devfn;
-
-	pe_info(pe, "Associated device to PE\n");
-
-	if (pnv_ioda_configure_pe(phb, pe)) {
-		/* XXX What do we do here ? */
-		if (pe_num)
-			pnv_ioda_free_pe(phb, pe_num);
-		pdn->pe_number = IODA_INVALID_PE;
-		pe->pdev = NULL;
-		pci_dev_put(dev);
-		return NULL;
-	}
-
-	/* Assign a DMA weight to the device */
-	pe->dma_weight = pnv_ioda_dma_weight(dev);
-	if (pe->dma_weight != 0) {
-		phb->ioda.dma_weight += pe->dma_weight;
-		phb->ioda.dma_pe_count++;
-	}
-
-	/* Link the PE */
-	pnv_ioda_link_pe_by_weight(phb, pe);
-
-	return pe;
-}
-#endif /* Useful for SRIOV case */
-
 static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *dev;
-- 
2.1.0

