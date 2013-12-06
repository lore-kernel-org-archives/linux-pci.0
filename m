Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56623 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754261Ab3LFDUm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Dec 2013 22:20:42 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [Patch Part1 V2 04/20] iommu/vt-d: fix resource leakage on error recovery path in iommu_init_domains()
Date: Fri,  6 Dec 2013 11:21:07 +0800
Message-Id: <1386300083-6882-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Release allocated resources on error recovery path in function
iommu_init_domains().

Acked-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b8e3b48..2398876 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1273,6 +1273,8 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 			GFP_KERNEL);
 	if (!iommu->domains) {
 		printk(KERN_ERR "Allocating domain array failed\n");
+		kfree(iommu->domain_ids);
+		iommu->domain_ids = NULL;
 		return -ENOMEM;
 	}
 
-- 
1.7.10.4

