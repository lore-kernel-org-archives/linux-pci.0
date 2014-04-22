Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [Patch Part3 V1 02/22] iommu/vt-d: use correct domain id to flush virtual machine domains
Date: Tue, 22 Apr 2014 15:07:13 +0800
Message-Id: <1398150453-28141-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
References: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For virtual machine domains, domain->id is a virtual id, and the real
domain id written into context entry is dynamically allocated.
So use the real domain id instead of domain->id when flushing iotlbs
for virtual machine domains.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 612fd441b225..0b3e6981a2da 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1824,7 +1824,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					   (((u16)bus) << 8) | devfn,
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, domain->id, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.flush_iotlb(iommu, id, 0, 0, DMA_TLB_DSI_FLUSH);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
-- 
1.7.10.4

