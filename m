Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:45627 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbFRIG7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 04:06:59 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 18 Jun 2015 13:36:57 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6C617125805A
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 13:39:29 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5I86p7t15597728
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 13:36:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5I86o1L027174
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 13:36:51 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V8 02/10] powerpc/pci: Cache VF index in pci_dn
Date: Thu, 18 Jun 2015 16:06:37 +0800
Message-Id: <1434614805-19002-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1434614805-19002-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1434614805-19002-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
index 1811c44..c324882 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -196,6 +196,7 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+	int     vf_index;		/* VF index in the PF */
 #ifdef CONFIG_PCI_IOV
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
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

