Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:40266 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaKBPmO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Nov 2014 10:42:14 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 3 Nov 2014 01:42:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id B40842BB0023
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2014 02:42:09 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sA2Fg8vv24379498
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2014 02:42:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sA2Fg8Bt028415
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2014 02:42:09 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 13/18] powerpc/powernv: Implement pcibios_iov_resource_alignment() on powernv
Date: Sun,  2 Nov 2014 23:41:29 +0800
Message-Id: <1414942894-17034-14-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch implements the pcibios_iov_resource_alignment() on powernv
platform.

On PowerNV platform, there are 3 cases for the IOV BAR:
1. initial state, the IOV BAR size is multiple times of VF BAR size
2. after expanded, the IOV BAR size is expanded to meet the M64 segment size
3. sizing stage, the IOV BAR is truncated to 0

pnv_pci_iov_resource_alignment() handle these three cases respectively.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    3 +++
 arch/powerpc/kernel/pci-common.c          |   14 ++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 86d47ca..15a13e6 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -256,6 +256,9 @@ struct machdep_calls {
 
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
+	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *,
+			                                    int resno,
+							    resource_size_t align);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 4e3d87d..581e67b 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -131,6 +131,20 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
 	pci_reset_secondary_bus(dev);
 }
 
+#ifdef CONFIG_PCI_IOV
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev,
+						 int resno,
+						 resource_size_t align)
+{
+	if (ppc_md.pcibios_iov_resource_alignment)
+		return ppc_md.pcibios_iov_resource_alignment(pdev,
+							       resno,
+							       align);
+
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ef279d3..880d76d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1830,6 +1830,25 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+#ifdef CONFIG_PCI_IOV
+static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
+							    int resno,
+							    resource_size_t align)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	resource_size_t iov_align;
+
+	iov_align = resource_size(&pdev->resource[resno]);
+	if (iov_align)
+		return iov_align;
+
+	if (pdn->max_vfs)
+		return pdn->max_vfs * align;
+
+	return align;
+}
+#endif /* CONFIG_PCI_IOV */
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -2038,6 +2057,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
+	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
 #endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
-- 
1.7.9.5

