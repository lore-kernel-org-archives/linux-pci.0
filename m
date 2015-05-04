Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:33499 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbEDHKI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2015 03:10:08 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 4 May 2015 17:10:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id B99AD2CE8052
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2015 17:10:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4479tVZ17105106
	for <linux-pci@vger.kernel.org>; Mon, 4 May 2015 17:10:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4479U42001212
	for <linux-pci@vger.kernel.org>; Mon, 4 May 2015 17:09:31 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V3 5/9] powerpc/eeh: create EEH_PE_VF for VF PE
Date: Mon,  4 May 2015 15:07:34 +0800
Message-Id: <1430723258-21299-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On powernv platform, VF PE is a special PE which is different from the Bus
PE.  On the EEH side, it needs a corresponding concept to handle the VF PE
properly. For example, we need to create VF PE when VF's pci_dev is
initialized in kernel. And add a flag to mark it is a VF PF.

This patch introduces the EEH_PE_VF type for VF PE and creates it for a VF.
At the mean time, it creates the sysfs and address cache for VF PE.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/kernel/eeh_pe.c                 |   12 ++++++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c |   12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a52db28..56e8cd9 100644
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
index 35f0b62..edfe63a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -299,7 +299,12 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 	 * EEH device already having associated PE, but
 	 * the direct parent EEH device doesn't have yet.
 	 */
-	pdn = pdn ? pdn->parent : NULL;
+#ifdef CONFIG_PCI_IOV
+	if (edev->mode & EEH_DEV_VF)
+		pdn = pci_get_pdn(edev->physfn);
+	else
+#endif
+		pdn = pdn ? pdn->parent : NULL;
 	while (pdn) {
 		/* We're poking out of PCI territory */
 		parent = pdn_to_eeh_dev(pdn);
@@ -382,7 +387,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	}
 
 	/* Create a new EEH PE */
-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+	if (edev->mode & EEH_DEV_VF)
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
+	else
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
 	if (!pe) {
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 622f08c..5447481 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1540,3 +1540,15 @@ static int __init eeh_powernv_init(void)
 	return ret;
 }
 machine_early_initcall(powernv, eeh_powernv_init);
+
+#ifdef CONFIG_PCI_IOV
+static void pnv_pci_fixup_vf_eeh(struct pci_dev *pdev)
+{
+	/* sysfs files should only be added after devices are added */
+	if (pdev->is_virtfn) {
+		eeh_add_device_late(pdev);
+		eeh_sysfs_add_device(pdev);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_eeh);
+#endif /* CONFIG_PCI_IOV */
-- 
1.7.9.5

