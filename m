Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 7/7] iommu/arm-smmu-v3: Disable tagged pointers
Date: Wed, 24 May 2017 19:01:43 +0100
Message-Id: <20170524180143.19855-8-jean-philippe.brucker@arm.com>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com,
 joro@8bytes.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 okaya@codeaurora.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com, lenb@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
index 87ed6239b9a6..0b2674f8ba0f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -997,7 +997,6 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, EPD0);
 	val |= ARM_SMMU_TCR2CD(tcr, EPD1);
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
-	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
 	return val;
 }
-- 
2.12.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
