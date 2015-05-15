Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:60371 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbEOFyv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 01:54:51 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 15 May 2015 15:54:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9F43C2CE8040
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:54:48 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F5se6w28966944
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:54:48 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F5sFf2007306
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:54:16 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V4 11/11] powerpc/powernv: compound PE for VFs
Date: Fri, 15 May 2015 13:46:26 +0800
Message-Id: <1431668786-30371-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When VF BAR size is larger than 64MB, we group VFs in terms of M64 BAR,
which means those VFs in a group should form a compound PE.

This patch links those VF PEs into compound PE in this case.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 843457b..157305f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1345,6 +1345,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 				vf_index < (vf_group + 1) * vf_per_group &&
 				vf_index < num_vfs;
 				vf_index++)
+
 				for (vf_index1 = vf_group * vf_per_group;
 					vf_index1 < (vf_group + 1) * vf_per_group &&
 					vf_index1 < num_vfs;
@@ -1360,6 +1361,11 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 						__func__,
 						pdn->offset + vf_index1, rc);
 				}
+
+				/* Remove a Slave PE from Master PE */
+				pe = &phb->ioda.pe_array[pdn->offset + vf_index];
+				if (pe->flags & PNV_IODA_PE_SLAVE)
+					list_del(&pe->compound);
 	}
 
 	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
@@ -1418,7 +1424,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
-	struct pnv_ioda_pe    *pe;
+	struct pnv_ioda_pe    *pe, *master_pe;
 	int                    pe_num;
 	u16                    vf_index;
 	struct pci_dn         *pdn;
@@ -1480,10 +1486,29 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		vf_per_group = roundup_pow_of_two(num_vfs) / pdn->m64_per_iov;
 
 		for (vf_group = 0; vf_group < M64_PER_IOV; vf_group++) {
+			master_pe = NULL;
+
 			for (vf_index = vf_group * vf_per_group;
 			     vf_index < (vf_group + 1) * vf_per_group &&
 			     vf_index < num_vfs;
 			     vf_index++) {
+
+				/*
+				 * Figure out the master PE and put all slave
+				 * PEs to master PE's list.
+				 */
+				pe = &phb->ioda.pe_array[pdn->offset + vf_index];
+				if (!master_pe) {
+					pe->flags |= PNV_IODA_PE_MASTER;
+					INIT_LIST_HEAD(&pe->slaves);
+					master_pe = pe;
+				} else {
+					pe->flags |= PNV_IODA_PE_SLAVE;
+					pe->master = master_pe;
+					list_add_tail(&pe->compound,
+						&master_pe->slaves);
+				}
+
 				for (vf_index1 = vf_group * vf_per_group;
 				     vf_index1 < (vf_group + 1) * vf_per_group &&
 				     vf_index1 < num_vfs;
-- 
1.7.9.5

