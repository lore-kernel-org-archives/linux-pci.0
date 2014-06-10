Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:38590 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933775AbaFJB5Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jun 2014 21:57:16 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Jun 2014 07:27:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6EACA3940048
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:12 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5A1vP1w8323486
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5A1vBdq013441
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:12 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [RFC PATCH V3 12/17] powerpc/powernv: implement pcibios_sriov_resource_alignment on powernv
Date: Tue, 10 Jun 2014 09:56:34 +0800
Message-Id: <1402365399-5121-13-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch implements the pcibios_sriov_resource_alignment() on powernv
platform.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    1 +
 arch/powerpc/kernel/pci-common.c          |    8 ++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 2f2e770..3bbc55f 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -242,6 +242,7 @@ struct machdep_calls {
 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
 #ifdef CONFIG_PCI_IOV
 	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
+	resource_size_t (*__pci_sriov_resource_alignment)(struct pci_dev *, int resno, resource_size_t align);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c4e2e92..35345ac 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -128,6 +128,14 @@ resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
 
 	return 0;
 }
+
+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *pdev, int resno, resource_size_t align)
+{
+	if (ppc_md.__pci_sriov_resource_alignment)
+		return ppc_md.__pci_sriov_resource_alignment(pdev, resno, align);
+
+	return 0;
+}
 #endif /* CONFIG_PCI_IOV */
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7dfad6a..b0ac851 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1573,6 +1573,22 @@ static resource_size_t __pnv_pci_sriov_resource_size(struct pci_dev *pdev, int r
 
 	return size;
 }
+
+static resource_size_t __pnv_pci_sriov_resource_alignment(struct pci_dev *pdev, int resno,
+		resource_size_t align)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	resource_size_t iov_align;
+
+	iov_align = resource_size(&pdev->resource[resno]);
+	if (iov_align)
+		return iov_align;
+
+	if (pdn->vfs)
+		return pdn->vfs * align;
+
+	return align;
+}
 #endif /* CONFIG_PCI_IOV */
 
 /* Prevent enabling devices for which we couldn't properly
@@ -1777,6 +1793,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 #ifdef CONFIG_PCI_IOV
 	ppc_md.__pci_sriov_resource_size = __pnv_pci_sriov_resource_size;
+	ppc_md.__pci_sriov_resource_alignment = __pnv_pci_sriov_resource_alignment;
 #endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
-- 
1.7.9.5

