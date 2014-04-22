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
Subject: [Patch Part3 V1 01/22] iommu/vt-d: match segment number when searching for dev_iotlb capable devices
Date: Tue, 22 Apr 2014 15:07:12 +0800
Message-Id: <1398150453-28141-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
References: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For virtual machine and static identity domains, there may be devices
from different PCI segments associated with the same domain.
So function iommu_support_dev_iotlb() should also match PCI segment
number (iommu unit) when searching for dev_iotlb capable devices.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f256ffc02e29..612fd441b225 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1274,7 +1274,8 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
-		if (info->bus == bus && info->devfn == devfn) {
+		if (info->iommu == iommu && info->bus == bus &&
+		    info->devfn == devfn) {
 			found = 1;
 			break;
 		}
-- 
1.7.10.4

