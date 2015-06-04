Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:38706 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbFDGoy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:44:54 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:44:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 18/42] powerpc/powernv: Helper function pnv_ioda_init_pe()
Date: Thu,  4 Jun 2015 16:41:47 +1000
Message-Id: <1433400131-18429-19-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch introduces helper function pnv_ioda_init_pe(), which
initialize PE instance after reserving or allocating PE#, to
simplify the code. The patch doesn't introduce behavioural
changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 07/21]
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6187f84..f0b54ab 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -132,6 +132,17 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
+{
+	struct pnv_ioda_pe *pe = &phb->ioda.pe_array[pe_no];
+
+	pe->phb = phb;
+	pe->pe_number = pe_no;
+	INIT_LIST_HEAD(&pe->list);
+
+	return pe;
+}
+
 static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 {
 	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
@@ -146,9 +157,7 @@ static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 		return NULL;
 	}
 
-	phb->ioda.pe_array[pe_no].phb = phb;
-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
-	return &phb->ioda.pe_array[pe_no];
+	return pnv_ioda_init_pe(phb, pe_no);
 }
 
 static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
@@ -167,9 +176,7 @@ static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 			return NULL;
 	} while (1);
 
-	phb->ioda.pe_array[pe_no].phb = phb;
-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
-	return &phb->ioda.pe_array[pe_no];
+	return pnv_ioda_init_pe(phb, pe_no);
 }
 
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
-- 
2.1.0

