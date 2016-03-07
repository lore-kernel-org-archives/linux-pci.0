Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	alex.williamson@redhat.com, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 7/7] powerpc/powernv/pci-ioda: Add IOMMU_CAP_INTR_REMAP for IODA host bridge
Date: Mon,  7 Mar 2016 15:48:38 +0800
Message-Id: <1457336918-3893-8-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds IOMMU_CAP_INTR_REMAP for IODA host bridge so that
we can mmap MSI-X table in vfio driver.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f90dc04..f01b9ab 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1955,6 +1955,20 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.free = pnv_ioda2_table_free,
 };
 
+static bool pnv_ioda_iommu_capable(enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_INTR_REMAP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct iommu_ops pnv_ioda_iommu_ops = {
+	.capable = pnv_ioda_iommu_capable,
+};
+
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -3078,6 +3092,9 @@ static void pnv_pci_ioda_fixup(void)
 
 	/* Link NPU IODA tables to their PCI devices. */
 	pnv_npu_ioda_fixup();
+
+	/* Add IOMMU_CAP_INTR_REMAP */
+	bus_set_iommu(&pci_bus_type, &pnv_ioda_iommu_ops);
 }
 
 /*
-- 
1.7.9.5
