Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Subject: [RFCv2 PATCH 32/36] iommu/arm-smmu-v3: Hook ATC invalidation to process ops
Date: Fri,  6 Oct 2017 14:31:59 +0100
Message-Id: <20171006133203.22803-33-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The core calls us when a process is modified. Perform the required ATC
invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d03bec4d4b82..f591f1974228 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2839,7 +2839,7 @@ static void arm_smmu_process_detach(struct iommu_domain *domain,
 		arm_smmu_write_ctx_desc(smmu_domain, process->pasid, NULL);
 	}
 
-	/* TODO: Invalidate ATC. */
+	arm_smmu_atc_inv_master_all(master, process->pasid);
 	/* TODO: Invalidate all mappings if last and not DVM. */
 }
 
@@ -2847,8 +2847,9 @@ static void arm_smmu_process_invalidate(struct iommu_domain *domain,
 					struct iommu_process *process,
 					unsigned long iova, size_t size)
 {
+	arm_smmu_atc_inv_domain(to_smmu_domain(domain), process->pasid,
+				iova, size);
 	/*
-	 * TODO: Invalidate ATC.
 	 * TODO: Invalidate mapping if not DVM
 	 */
 }
@@ -2871,7 +2872,7 @@ static void arm_smmu_process_exit(struct iommu_domain *domain,
 		domain->process_exit(domain, master->dev, process->pasid,
 				     domain->process_exit_token);
 
-		/* TODO: inval ATC */
+		arm_smmu_atc_inv_master_all(master, process->pasid);
 	}
 	spin_unlock(&smmu_domain->devices_lock);
 
-- 
2.13.3

