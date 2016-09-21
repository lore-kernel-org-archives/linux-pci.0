Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933869AbcIUMPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2016 08:15:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8LCDOEZ026257
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 08:15:38 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0b-001b2d01.pphosted.com with ESMTP id 25khh8wmph-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 08:15:37 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 21 Sep 2016 22:15:34 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id CB2312CE8046
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u8LCFVIM6816058
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u8LCFVBY010335
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:31 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/powernv: Unfreeze PE on allocation
Date: Wed, 21 Sep 2016 22:15:29 +1000
In-Reply-To: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1474460130-8316-4-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This unfreezes PE when it's initialized because the PE might be put
into frozen state in the last hot remove path. It's not harmful to
do so if the PE is already in unfrozen state.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c38a6a1..5122257 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -126,9 +126,21 @@ static inline bool pnv_pci_is_m64(struct pnv_phb *phb, struct resource *r)
 
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
+	s64 rc;
+
 	phb->ioda.pe_array[pe_no].phb = phb;
 	phb->ioda.pe_array[pe_no].pe_number = pe_no;
 
+	/* Clear the PE frozen state as it might be put into frozen state
+	 * in the last PCI remove path. It's not harmful to do so when the
+	 * PE is already in unfrozen state.
+	 */
+	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
+				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+	if (rc != OPAL_SUCCESS)
+		pr_warn("%s: Error %lld unfreezing PHB#%d-PE#%d\n",
+			__func__, rc, phb->hose->global_number, pe_no);
+
 	return &phb->ioda.pe_array[pe_no];
 }
 
-- 
2.1.0

