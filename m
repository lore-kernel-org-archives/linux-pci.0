Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([125.16.236.4]:60767 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcECNdc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 09:33:32 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 3 May 2016 18:53:19 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
	alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 05/22] powerpc/powernv: Allocate PE# in reverse order
Date: Tue,  3 May 2016 23:22:36 +1000
Message-Id: <1462281773-26438-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PE number for one particular PE can be allocated dynamically or
reserved according to the consumed M64 (64-bits prefetchable)
segments of the PE. The M64 segment can't be remapped to arbitrary
PE, meaning the PE number is determined according to the index
of the consumed M64 segment. As below figure shows, M64 resource
grows from low to high end, meaning the PE (number) reserved
according to M64 segment grows from low to high end as well,
so does the dynamically allocated PE number. It will lead to
conflict: PE number (M64 segment) reserved by dynamic allocation
is required by hot added PCI adapter at later point. It fails
the PCI hotplug because of the PE number can't be reserved
based on the index of the consumed M64 segment.

  +---+---+---+---+---+--------------------------------+-----+
  | 0 | 1 | 2 | 3 | 4 |      .......                   | 255 |
  +---+---+---+---+---+--------------------------------+-----+

  PE number for dynamic allocation          ----------------->
  PE number reserved for M64 segment        ----------------->

To resolve above conflicts, this forces the PE number to be
allocated dynamically in reverse order. With this patch applied,
the PE numbers are reserved in ascending order, but allocated
dynamically in reverse order.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cf96cb5..679e279 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -148,16 +148,14 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 
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

