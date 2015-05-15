Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:47818 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422697AbbEONkb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 09:40:31 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 15 May 2015 23:40:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id A4DF42BB0047
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 23:40:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4FDeKoY20316346
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 23:40:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4FDdthx011708
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 23:39:56 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V5 06/10] powerpc/eeh: create EEH_PE_VF for VF PE
Date: Fri, 15 May 2015 21:37:00 +0800
Message-Id: <1431697024-5710-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431697024-5710-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431697024-5710-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On powernv platform, VF PE is a special PE which is different from the Bus
PE.  On the EEH side, it needs a corresponding concept to handle the VF PE
properly. For example, we need to create VF PE when VF's pci_dev is
initialized in kernel. And add a flag to mark it is a VF PE.

This patch introduces the EEH_PE_VF type for VF PE and creates it for a VF.
At the mean time, it creates the sysfs and address cache for VF PE at PCI
device final fixup time.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c |   16 ++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 1b3614d..c1fde48 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -70,6 +70,7 @@ struct pci_dn;
 #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
 #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
 #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
+#define EEH_PE_VF	(1 << 4)	/* VF PE     */
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 35f0b62..260a701 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 	 * EEH device already having associated PE, but
 	 * the direct parent EEH device doesn't have yet.
 	 */
-	pdn = pdn ? pdn->parent : NULL;
+	if (edev->physfn)
+		pdn = pci_get_pdn(edev->physfn);
+	else
+		pdn = pdn ? pdn->parent : NULL;
 	while (pdn) {
 		/* We're poking out of PCI territory */
 		parent = pdn_to_eeh_dev(pdn);
@@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	}
 
 	/* Create a new EEH PE */
-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+	if (edev->physfn)
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
+	else
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
 	if (!pe) {
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 622f08c..c4ea2ad 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1540,3 +1540,19 @@ static int __init eeh_powernv_init(void)
 	return ret;
 }
 machine_early_initcall(powernv, eeh_powernv_init);
+
+static void pnv_eeh_vf_final_fixup(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	/*
+	 * The following operations will fail if VF's sysfs files aren't
+	 * created or its resources aren't finalized.
+	 */
+	if (!pdev->is_virtfn)
+		return;
+
+	eeh_add_device_early(pdn);
+	eeh_add_device_late(pdev);
+	eeh_sysfs_add_device(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_eeh_vf_final_fixup);
-- 
1.7.9.5

