Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:49376 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965372AbbKDNNx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:13:53 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 23:13:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 24/50] powerpc/powernv: Allocate PE# in reverse order
Date: Thu,  5 Nov 2015 00:12:24 +1100
Message-Id: <1446642770-4681-25-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PE number for one particular PE can be allocated dynamically or
reserved according to the consumed M64 (64-bits prefetchable)
segments of the PE. The M64 resources, and hence their segments
and PE number are assigned/reserved in ascending order. The PE
numbers are allocated dynamically in ascending order as well.
It's not a problem as the PE numbers are reserved and then
allocated all at once in fine order. However, it will introduce
conflicts when PCI hotplug is supported: the PE number to be
reserved for newly added PE might have been assigned.

To resolve above conflicts, this forces the PE number to be
allocated dynamically in reverse order. With this patch applied,
the PE numbers are reserved in ascending order, but allocated
dynamically in reverse order.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ae82df1..eea1c96 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -154,16 +154,14 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
 static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
-	unsigned long pe;
+	unsigned long pe = phb->ioda.total_pe_num - 1;
 
-	do {
-		pe = find_next_zero_bit(phb->ioda.pe_alloc,
-					phb->ioda.total_pe_num, 0);
-		if (pe >= phb->ioda.total_pe_num)
-			return NULL;
-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
+	for (pe = phb->ioda.total_pe_num - 1; pe >= 0; pe--) {
+		if (!test_and_set_bit(pe, phb->ioda.pe_alloc))
+			return pnv_ioda_init_pe(phb, pe);
+	}
 
-	return pnv_ioda_init_pe(phb, pe);
+	return NULL;
 }
 
 static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
-- 
2.1.0

