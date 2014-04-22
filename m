Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17579 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbaDVHF5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Apr 2014 03:05:57 -0400
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
Subject: [Patch Part3 V1 07/22] iommu/vt-d: avoid freeing virtual machine domain in free_dmar_iommu()
Date: Tue, 22 Apr 2014 15:07:18 +0800
Message-Id: <1398150453-28141-8-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
References: <1398150453-28141-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Virtual machine domains are created by intel_iommu_domain_init() and
should be destroyed by intel_iommu_domain_destroy(). So avoid freeing
virtual machine domain data structure in free_dmar_iommu() when
doamin->iommu_count reaches zero, otherwise it may cause invalid
memory access because the IOMMU framework still holds references
to the domain structure.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1f10fcd1c696..5e865c1265ad 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1482,7 +1482,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 
 			domain = iommu->domains[i];
 			clear_bit(i, iommu->domain_ids);
-			if (domain_detach_iommu(domain, iommu) == 0)
+			if (domain_detach_iommu(domain, iommu) == 0 &&
+			    !domain_type_is_vm(domain))
 				domain_exit(domain);
 		}
 	}
-- 
1.7.10.4

