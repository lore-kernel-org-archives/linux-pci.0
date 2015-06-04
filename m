Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:36403 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbFDGoy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:44:54 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:44:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 14/42] powerpc/powernv: Allocate PE# in deasending order
Date: Thu,  4 Jun 2015 16:41:43 +1000
Message-Id: <1433400131-18429-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The available PE#, represented by a bitmap in the PHB, is allocated
in asending order. It conflicts with the fact that M64 segments are
assigned in same order. In order to avoid the conflict, the patch
allocates PE# in deasending order.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from [PATCH v5 v4 06/21]
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8b0ef5..0d6539a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -152,18 +152,23 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
 static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
-	unsigned long pe;
+	unsigned long pe_no;
+	unsigned long limit = phb->ioda.total_pe - 1;
 
 	do {
-		pe = find_next_zero_bit(phb->ioda.pe_alloc,
-					phb->ioda.total_pe, 0);
-		if (pe >= phb->ioda.total_pe)
+		pe_no = find_next_zero_bit(phb->ioda.pe_alloc,
+					   phb->ioda.total_pe, limit);
+		if (pe_no < phb->ioda.total_pe &&
+		    !test_and_set_bit(pe_no, phb->ioda.pe_alloc))
+			break;
+
+		if (--limit >= phb->ioda.total_pe)
 			return IODA_INVALID_PE;
-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
+	} while (1);
 
-	phb->ioda.pe_array[pe].phb = phb;
-	phb->ioda.pe_array[pe].pe_number = pe;
-	return pe;
+	phb->ioda.pe_array[pe_no].phb = phb;
+	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+	return pe_no;
 }
 
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
-- 
2.1.0

