Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:33893 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbCTDPO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 23:15:14 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 20 Mar 2015 13:15:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 54A8E3578055
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:15:10 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2K3F22K40566804
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:15:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2K3EaSK012144
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:14:36 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V14 16/21] powerpc/powernv: Implement pcibios_iov_resource_alignment() on powernv
Date: Fri, 20 Mar 2015 11:06:32 +0800
Message-Id: <1426820797-6267-17-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement pcibios_iov_resource_alignment() on powernv platform.

On PowerNV platform, there are 3 cases for the IOV BAR:
1. initial state, the IOV BAR size is multiple times of VF BAR size
2. after expanded, the IOV BAR size is expanded to meet the M64 segment size
3. sizing stage, the IOV BAR is truncated to 0

pnv_pci_iov_resource_alignment() handle these three cases respectively.

[bhelgaas: adjust to drop "align" parameter, return pci_iov_resource_size()
if no ppc_md machdep_call version]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    1 +
 arch/powerpc/kernel/pci-common.c          |   10 ++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 1d72fda..37e451f 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -252,6 +252,7 @@ struct machdep_calls {
 
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
+	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 375bf70..9a306ff 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -130,6 +130,16 @@ void pcibios_reset_secondary_bus(struct pci_dev *dev)
 	pci_reset_secondary_bus(dev);
 }
 
+#ifdef CONFIG_PCI_IOV
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
+{
+	if (ppc_md.pcibios_iov_resource_alignment)
+		return ppc_md.pcibios_iov_resource_alignment(pdev, resno);
+
+	return pci_iov_resource_size(pdev, resno);
+}
+#endif /* CONFIG_PCI_IOV */
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cadd3fb..93ec16c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1965,6 +1965,25 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+#ifdef CONFIG_PCI_IOV
+static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
+						      int resno)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	resource_size_t align, iov_align;
+
+	iov_align = resource_size(&pdev->resource[resno]);
+	if (iov_align)
+		return iov_align;
+
+	align = pci_iov_resource_size(pdev, resno);
+	if (pdn->vfs_expanded)
+		return pdn->vfs_expanded * align;
+
+	return align;
+}
+#endif /* CONFIG_PCI_IOV */
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -2167,6 +2186,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
+	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
 #endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
-- 
1.7.9.5

