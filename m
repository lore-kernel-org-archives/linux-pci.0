Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 34/37] PCI: Make "PRG Response PASID Required" handling common
Date: Mon, 12 Feb 2018 18:33:49 +0000
Message-Id: <20180212183352.22730-35-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PASID ECN to the PCIe spec added a bit in the PRI status register that
allows a Function to declare whether a PRG Response should contain the
PASID prefix or not.

Move the helper that accesses it from amd_iommu into the PCI subsystem,
renaming it to be consistent with the current PCI Express specification
(PRPR - PRG Response PASID Required).

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/amd_iommu.c     | 19 +------------------
 drivers/pci/ats.c             | 17 +++++++++++++++++
 include/linux/pci-ats.h       |  8 ++++++++
 include/uapi/linux/pci_regs.h |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 74788fdeb773..4bf606747295 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2049,23 +2049,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
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
@@ -2094,7 +2077,7 @@ static int attach_device(struct device *dev,
 
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
-			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
+			dev_data->pri_tlp     = pci_prg_resp_requires_prefix(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 6ad80a1fd5a7..52bac62a0e40 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -390,3 +390,20 @@ int pci_max_pasids(struct pci_dev *pdev)
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
index 7c4b8e27268c..1825ca2c9bf4 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -68,5 +68,13 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 
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
index 0c79eac5e9b8..c8020391cfa4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -868,6 +868,7 @@
 #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
 #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
 #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PRPR	0x8000	/* PRG Response requires PASID prefix */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
-- 
2.15.1

