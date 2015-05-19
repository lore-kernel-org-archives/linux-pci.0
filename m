Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:41397 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbESBhX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 21:37:23 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 19 May 2015 11:37:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4815E2CE8052
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 11:37:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4J1bBlw30081178
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 11:37:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4J1akSK029655
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2015 11:36:46 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V6 02/10] powerpc/pci: Cache VF index in pci_dn
Date: Tue, 19 May 2015 09:35:04 +0800
Message-Id: <1431999312-10517-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch caches the VF index in pci_dn, which can be used to calculate
VF's bus, device and function number. Those information helps to locate
the VF's PCI device instance when doing hotplug during EEH recovery if
necessary.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    1 +
 arch/powerpc/kernel/pci_dn.c          |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1811c44..d78afe4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -199,6 +199,7 @@ struct pci_dn {
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
+	int     vf_index;		/* VF index in the PF */
 	int     offset;			/* PE# for the first VF PE */
 #define M64_PER_IOV 4
 	int     m64_per_iov;
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b3b4df9..f771130 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 					   struct pci_dev *pdev,
+					   int vf_index,
 					   int busno, int devfn)
 {
 	struct pci_dn *pdn;
@@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
+	pdn->vf_index = vf_index;
 #ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
 #endif
@@ -196,7 +198,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 		return NULL;
 
 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
-		pdn = add_one_dev_pci_data(parent, NULL,
+		pdn = add_one_dev_pci_data(parent, NULL, i,
 					   pci_iov_virtfn_bus(pdev, i),
 					   pci_iov_virtfn_devfn(pdev, i));
 		if (!pdn) {
-- 
1.7.9.5

