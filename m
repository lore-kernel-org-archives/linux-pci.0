Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59202 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbbHFENR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 00:13:17 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 6 Aug 2015 14:13:15 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 18/42] powerpc/powernv: Allocate PE# in deasending order
Date: Thu,  6 Aug 2015 14:11:23 +1000
Message-Id: <1438834307-26960-19-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The available PE#, represented by a bitmap in the PHB, is allocated
in ascending order. It conflicts with the fact that M64 segments are
assigned in same order. In order to avoid the conflict, the patch
allocates PE# in descending order.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 56b058c..1c950e8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -161,13 +161,18 @@ static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
+	unsigned long limit = phb->ioda.total_pe_num - 1;
 
 	do {
 		pe = find_next_zero_bit(phb->ioda.pe_alloc,
-					phb->ioda.total_pe_num, 0);
-		if (pe >= phb->ioda.total_pe_num)
+					phb->ioda.total_pe_num, limit);
+		if (pe < phb->ioda.total_pe_num &&
+		    !test_and_set_bit(pe, phb->ioda.pe_alloc))
+			break;
+
+		if (--limit >= phb->ioda.total_pe_num)
 			return NULL;
-	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
+	} while (1);
 
 	return pnv_ioda_init_pe(phb, pe);
 }
-- 
2.1.0

