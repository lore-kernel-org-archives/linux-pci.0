Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 18/30] PCI: Make "PRG Response PASID Required" handling
 common
Date: Mon, 27 Feb 2017 19:54:29 +0000
Message-Id: <20170227195441.5170-19-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The PASID ECN to the PCIe spec added a bit in the PRI status register that
allows a Function to declare whether a PRG Response should contain the
PASID prefix or not.

Move the helper that accesses it from amd_iommu into the PCI subsystem,
renaming it to something more consistent with the spec, and introducing
another obscure acronym to make it all fit.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/amd_iommu.c     | 19 +------------------
 drivers/pci/ats.c             | 17 +++++++++++++++++
 include/linux/pci-ats.h       |  8 ++++++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98940d1392cb..c5c598bf4ba3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2024,23 +2024,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	return ret;
 }
 
-/* FIXME: Move this to PCI code */
-#define PCI_PRI_TLP_OFF		(1 << 15)
-
-static bool pci_pri_tlp_required(struct pci_dev *pdev)
-{
-	u16 status;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return false;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	return (status & PCI_PRI_TLP_OFF) ? true : false;
-}
-
 /*
  * If a device is not yet associated with a domain, this function
  * assigns it visible for the hardware
@@ -2069,7 +2052,7 @@ static int attach_device(struct device *dev,
 
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			dev_data->pri_tlp     = pci_prg_resp_requires_prefix(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index eeb9fb2b47aa..331376e9bb8b 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -334,3 +334,20 @@ int pci_max_pasids(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_max_pasids);
 #endif /* CONFIG_PCI_PASID */
+
+#if defined(CONFIG_PCI_PASID) && defined(CONFIG_PCI_PRI)
+bool pci_prg_resp_requires_prefix(struct pci_dev *pdev)
+{
+	u16 status;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return false;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+
+	return !!(status & PCI_PRI_STATUS_PRPR);
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_requires_prefix);
+#endif /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 57e0b8250947..e21bcacbe80c 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -57,5 +57,13 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 
 #endif /* CONFIG_PCI_PASID */
 
+#if defined(CONFIG_PCI_PASID) && defined(CONFIG_PCI_PRI)
+bool pci_prg_resp_requires_prefix(struct pci_dev *pdev);
+#else
+static inline bool pci_prg_resp_requires_prefix(struct pci_dev *pdev)
+{
+	return false;
+}
+#endif /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
 
 #endif /* LINUX_PCI_ATS_H*/
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 634c9c44ed6c..bae815876be6 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -864,6 +864,7 @@
 #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
 #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
 #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PRPR	0x8000	/* PRG Response requires PASID prefix */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
