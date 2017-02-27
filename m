Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 05/30] iommu/arm-smmu-v3: Disable tagged pointers when ATS
 is in use
Date: Mon, 27 Feb 2017 19:54:16 +0000
Message-Id: <20170227195441.5170-6-jean-philippe.brucker@arm.com>
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

The ARM architecture has a "Top Byte Ignore" (TBI) option that makes the
MMU mask out bits [63:56] of an address, allowing a userspace application
to store data in its pointers.

The ATS doesn't have an architected mechanism to enable TBI, and might
create ATC entries for addresses that include a tag. Software would then
have to send ATC invalidation packets for each 255 possible alias of an
address, or just wipe the whole address space. This is not a viable
option, so disable TBI when ATS is in use.

It is unclear for the moment how this restriction will affect user
applications. One example I can imagine (with my complete lack of
knowledge about JIT engines and their use of tagged pointers) is a JIT
translating a WebCL applications that uses SVM. Since this kind of
interpreted language doesn't expose addresses, the interpreter and SVM
implementations will be given the opportunity to do the right thing and
remove tags before handing pointers to devices.

Ideally we should remove TBI only for domains that are susceptible to use
ATS. But at the point we're writing the context descriptor of a domain, we
are still probing the first device in the group. If that device doesn't
have an ATC but the next one does, we would then have to clear the TBI
bit, invalidate the ATCs of previous devices, and notify the drivers that
their devices cannot use tagged pointers anymore. Such a level of
complexity doesn't make any sense here since it is unlikely devices will
use tagged pointers at all.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e7b940146ae3..06b29d4fcf65 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -987,7 +987,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
-static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
+static u64 arm_smmu_cpu_tcr_to_cd(struct arm_smmu_device *smmu, u64 tcr)
 {
 	u64 val = 0;
 
@@ -1000,7 +1000,8 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
 	val |= ARM_SMMU_TCR2CD(tcr, EPD0);
 	val |= ARM_SMMU_TCR2CD(tcr, EPD1);
 	val |= ARM_SMMU_TCR2CD(tcr, IPS);
-	val |= ARM_SMMU_TCR2CD(tcr, TBI0);
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
+		val |= ARM_SMMU_TCR2CD(tcr, TBI0);
 
 	return val;
 }
@@ -1014,7 +1015,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	 * We don't need to issue any invalidation here, as we'll invalidate
 	 * the STE when installing the new entry anyway.
 	 */
-	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
+	val = arm_smmu_cpu_tcr_to_cd(smmu, cfg->cd.tcr) |
 #ifdef __BIG_ENDIAN
 	      CTXDESC_CD_0_ENDI |
 #endif
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
