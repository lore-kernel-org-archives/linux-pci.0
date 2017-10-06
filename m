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
Subject: [RFCv2 PATCH 33/36] iommu/arm-smmu-v3: Disable tagged pointers
Date: Fri,  6 Oct 2017 14:32:00 +0100
Message-Id: <20171006133203.22803-34-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ARM architecture has a "Top Byte Ignore" (TBI) option that makes the
MMU mask out bits [63:56] of an address, allowing a userspace application
to store data in its pointers. This option is incompatible with PCI ATS.

If TBI is enabled in the SMMU and userspace triggers DMA transactions on
tagged pointers, the endpoint might create ATC entries for addresses that
include a tag. Software would then have to send ATC invalidation packets
for each 255 possible alias of an address, or just wipe the whole address
space. This is not a viable option, so disable TBI.

The impact of this change is unclear, since there are very few users of
tagged pointers, much less SVM. But the requirement introduced by this
patch doesn't seem excessive: a userspace application using both tagged
pointers and SVM should now sanitize addresses (clear the tag) before
using them for device DMA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f591f1974228..f008b4617cd4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1332,7 +1332,6 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, EPD0);
 	val |= ARM_SMMU_TCR2CD(tcr, EPD1);
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
-	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
 	if (smmu->features & ARM_SMMU_FEAT_HA)
 		val |= ARM_SMMU_TCR2CD(tcr, HA);
-- 
2.13.3

