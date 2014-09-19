Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32397 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756854AbaISFRG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Sep 2014 01:17:06 -0400
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
	linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [Patch Part3 V6 6/8] iommu/vt-d: Enhance error recovery in function intel_enable_irq_remapping()
Date: Fri, 19 Sep 2014 13:18:53 +0800
Message-Id: <1411103935-31301-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1411103935-31301-1-git-send-email-jiang.liu@linux.intel.com>
References: <1411103935-31301-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhance error recovery in function intel_enable_irq_remapping()
by tearing down all created data structures.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Reviewed-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/iommu/intel_irq_remapping.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 1edbbed8c6bc..ddf98a8782a2 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -701,9 +701,11 @@ static int __init intel_enable_irq_remapping(void)
 	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
 
 error:
-	/*
-	 * handle error condition gracefully here!
-	 */
+	for_each_iommu(iommu, drhd)
+		if (ecap_ir_support(iommu->ecap)) {
+			iommu_disable_irq_remapping(iommu);
+			intel_teardown_irq_remapping(iommu);
+		}
 
 	if (x2apic_present)
 		pr_warn("Failed to enable irq remapping.  You are vulnerable to irq-injection attacks.\n");
-- 
1.7.10.4

