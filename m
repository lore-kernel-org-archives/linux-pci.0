Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7499 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdJFOIA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2017 10:08:00 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <sudeep.holla@arm.com>, <will.deacon@arm.com>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
        <gabriele.paoloni@huawei.com>
CC: <john.garry@huawei.com>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devel@acpica.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>, <guohanjun@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v9 3/4] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
Date: Fri, 6 Oct 2017 15:04:49 +0100
Message-ID: <20171006140450.89652-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The HiSilicon erratum 161010801 describes the limitation of HiSilicon
platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.

On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the
MSI payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

This patch implements a ACPI table based quirk to reserve the hw msi
regions in the smmu-v3 driver which means these address regions will
not be translated and will be excluded from iova allocations.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c..dd42ae9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -608,6 +608,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
+#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 2)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1934,14 +1935,29 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
 	struct iommu_resv_region *region;
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+	struct arm_smmu_device *smmu = master->smmu;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	int resv = 0;
 
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
-	if (!region)
-		return;
+	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
 
-	list_add_tail(&region->list, head);
+		resv = iommu_dma_get_msi_resv_regions(dev, head);
+
+		if (resv < 0) {
+			dev_warn(dev, "HW MSI region resv failed: %d\n", resv);
+			return;
+		}
+	}
+
+	if (!resv) {
+		region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+						 prot, IOMMU_RESV_SW_MSI);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
 
 	iommu_dma_get_resv_regions(dev, head);
 }
@@ -2667,6 +2683,7 @@ static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 		break;
 	case ACPI_IORT_SMMU_HISILICON_HI161X:
 		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		smmu->options |= ARM_SMMU_OPT_RESV_HW_MSI;
 		break;
 	}
 
-- 
1.9.1
