Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbeEKTK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 May 2018 15:10:57 -0400
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
Subject: [PATCH v2 37/40] iommu/arm-smmu-v3: Disable tagged pointers
Date: Fri, 11 May 2018 20:06:38 +0100
Message-Id: <20180511190641.23008-38-jean-philippe.brucker@arm.com>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
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
tagged pointers, much less SVA. But the requirement introduced by this
patch doesn't seem excessive: a userspace application using both tagged
pointers and SVA should now sanitize addresses (clear the tag) before
using them for device DMA.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3-context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3-context.c b/drivers/iommu/arm-smmu-v3-context.c
index bdc9bfd1f35d..22e7b80a7682 100644
--- a/drivers/iommu/arm-smmu-v3-context.c
+++ b/drivers/iommu/arm-smmu-v3-context.c
@@ -200,7 +200,6 @@ static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_context_cfg *cfg, u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, EPD0);
 	val |= ARM_SMMU_TCR2CD(tcr, EPD1);
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
-	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
 	if (cfg->hw_access)
 		val |= ARM_SMMU_TCR2CD(tcr, HA);
-- 
2.17.0
