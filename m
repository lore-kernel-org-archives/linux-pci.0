Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:39164 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130AbcBQDp7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:45:59 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 08/45] powerpc/powernv: Fix initial IO and M32 segmap
Date: Wed, 17 Feb 2016 14:43:51 +1100
Message-Id: <1455680668-23298-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are two arrays for IO and M32 segment maps on every PHB.
The index of the arrays are segment number and the value stored
in the corresponding element is PE number, indicating the segment
is assigned to the PE. Initially, all elements in those two arrays
are zeroes, meaning all segments are assigned to PE#0. It's wrong.

This fixes the initial values in the elements of those two arrays
to IODA_INVALID_PE, meaning all segments aren't assigned to any
PE. In order to use IODA_INVALID_PE (-1) to represent invalid PE
number, the types of those two arrays are changed from "unsigned int"
to "int".

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++++--
 arch/powerpc/platforms/powernv/pci.h      | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1d2514f..44cc5f3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3239,7 +3239,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
 	const __be64 *prop64;
 	const __be32 *prop32;
-	int len;
+	int i, len;
 	u64 phb_id;
 	void *aux;
 	long rc;
@@ -3334,8 +3334,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	aux = memblock_virt_alloc(size, 0);
 	phb->ioda.pe_alloc = aux;
 	phb->ioda.m32_segmap = aux + m32map_off;
-	if (phb->type == PNV_PHB_IODA1)
+	for (i = 0; i < phb->ioda.total_pe_num; i++)
+		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
+	if (phb->type == PNV_PHB_IODA1) {
 		phb->ioda.io_segmap = aux + iomap_off;
+		for (i = 0; i < phb->ioda.total_pe_num; i++)
+			phb->ioda.io_segmap[i] = IODA_INVALID_PE;
+	}
 	phb->ioda.pe_array = aux + pemap_off;
 	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 784882a..36c4965 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -146,8 +146,8 @@ struct pnv_phb {
 		struct pnv_ioda_pe	*pe_array;
 
 		/* M32 & IO segment maps */
-		unsigned int		*m32_segmap;
-		unsigned int		*io_segmap;
+		int			*m32_segmap;
+		int			*io_segmap;
 
 		/* IRQ chip */
 		int			irq_chip_init;
-- 
2.1.0

