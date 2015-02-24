Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34750 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbBXIew (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:34:52 -0500
Received: by pabrd3 with SMTP id rd3so34440757pab.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:34:52 -0800 (PST)
Subject: [PATCH v12 16/21] powerpc/powernv: Implement
 pcibios_iov_resource_alignment() on powernv
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:34:49 -0600
Message-ID: <20150224083449.32124.68975.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

Implement pcibios_iov_resource_alignment() on powernv platform.

On PowerNV platform, there are 3 cases for the IOV BAR:
1. initial state, the IOV BAR size is multiple times of VF BAR size
2. after expanded, the IOV BAR size is expanded to meet the M64 segment size
3. sizing stage, the IOV BAR is truncated to 0

pnv_pci_iov_resource_alignment() handle these three cases respectively.

[bhelgaas: adjust to drop "align" parameter, return pci_iov_resource_size()
if no ppc_md machdep_call version]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/machdep.h        |    1 +
 arch/powerpc/kernel/pci-common.c          |   10 ++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 965547c58497..045448f9e8b2 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -252,6 +252,7 @@ struct machdep_calls {
 
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
+	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 022e9feeb1f2..2f1ad9ef4402 100644
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
+	return pci_iov_resource_size(dev, resno);
+}
+#endif /* CONFIG_PCI_IOV */
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 36c533da5ccb..6a86690bb8de 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1980,6 +1980,25 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
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
@@ -2182,6 +2201,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
+	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
 #endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 

