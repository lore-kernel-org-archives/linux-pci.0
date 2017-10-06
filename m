Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdJFNaq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:30:46 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 34/36] PCI: Make "PRG Response PASID Required" handling common
Date: Fri,  6 Oct 2017 14:32:01 +0100
Message-Id: <20171006133203.22803-35-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PASID ECN to the PCIe spec added a bit in the PRI status register that
allows a Function to declare whether a PRG Response should contain the
PASID prefix or not.

Move the helper that accesses it from amd_iommu into the PCI subsystem,
renaming it to be consistent with the current spec (PRPR - PRG Response
PASID Required).

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/amd_iommu.c     | 19 +------------------
 drivers/pci/ats.c             | 17 +++++++++++++++++
 include/linux/pci-ats.h       |  8 ++++++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 51f8215877f5..45036a253d63 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2039,23 +2039,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
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
@@ -2084,7 +2067,7 @@ static int attach_device(struct device *dev,
 
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			dev_data->pri_tlp     = pci_prg_resp_requires_prefix(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ad8ddbbbf245..f95e42df728b 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -389,3 +389,20 @@ int pci_max_pasids(struct pci_dev *pdev)
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
index 782fb8e0755f..367ea9448441 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -67,5 +67,13 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 
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
index f8d58045926f..a0eeb16a2bfe 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -862,6 +862,7 @@
 #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
 #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
 #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PRPR	0x8000	/* PRG Response requires PASID prefix */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
-- 
2.13.3
