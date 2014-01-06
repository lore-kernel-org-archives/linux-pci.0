Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37985 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbaAFGSt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jan 2014 01:18:49 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Jiri Kosina <trivial@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [Patch Part1 V3 18/20] iommu/vt-d, PCI, trivial: use dev_is_pci() instead of hardcoding
Date: Mon,  6 Jan 2014 14:18:25 +0800
Message-Id: <1388989107-4795-19-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use helper dev_is_pci() instead of hardcoding.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 03780eb..6fce741 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2703,7 +2703,7 @@ static int iommu_no_mapping(struct device *dev)
 	struct pci_dev *pdev;
 	int found;
 
-	if (unlikely(dev->bus != &pci_bus_type))
+	if (unlikely(!dev_is_pci(dev)))
 		return 1;
 
 	pdev = to_pci_dev(dev);
-- 
1.7.10.4

