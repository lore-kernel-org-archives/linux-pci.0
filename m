Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org
Cc: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, liudongdong3@huawei.com,
        shunyong.yang@hxt-semitech.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com, rgummal@xilinx.com
Subject: [PATCH v2 36/40] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date: Fri, 11 May 2018 20:06:37 +0100
Message-Id: <20180511190641.23008-37-jean-philippe.brucker@arm.com>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The core calls us when an mm is modified. Perform the required ATC
invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7034b0bdcbdf..6cb69ace371b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1735,6 +1735,15 @@ static int arm_smmu_atc_inv_master_all(struct arm_smmu_master_data *master,
 	return arm_smmu_atc_inv_master(master, &cmd);
 }
 
+static int arm_smmu_atc_inv_master_range(struct arm_smmu_master_data *master,
+					 int ssid, unsigned long iova, size_t size)
+{
+	struct arm_smmu_cmdq_ent cmd;
+
+	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+	return arm_smmu_atc_inv_master(master, &cmd);
+}
+
 static size_t
 arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			unsigned long iova, size_t size)
@@ -2389,11 +2398,12 @@ static void arm_smmu_mm_detach(struct iommu_domain *domain, struct device *dev,
 	struct arm_smmu_mm *smmu_mm = to_smmu_mm(io_mm);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct iommu_pasid_table_ops *ops = smmu_domain->s1_cfg.ops;
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
 
 	if (detach_domain)
 		ops->clear_entry(ops, io_mm->pasid, smmu_mm->cd);
 
-	/* TODO: Invalidate ATC. */
+	arm_smmu_atc_inv_master_all(master, io_mm->pasid);
 	/* TODO: Invalidate all mappings if last and not DVM. */
 }
 
@@ -2401,8 +2411,10 @@ static void arm_smmu_mm_invalidate(struct iommu_domain *domain,
 				   struct device *dev, struct io_mm *io_mm,
 				   unsigned long iova, size_t size)
 {
+	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+
+	arm_smmu_atc_inv_master_range(master, io_mm->pasid, iova, size);
 	/*
-	 * TODO: Invalidate ATC.
 	 * TODO: Invalidate mapping if not DVM
 	 */
 }
-- 
2.17.0

