Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56623 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab3LFDUx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Dec 2013 22:20:53 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiri Kosina <trivial@kernel.org>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [Patch Part1 V2 07/20] iommu/vt-d, trivial: check suitable flag in function detect_intel_iommu()
Date: Fri,  6 Dec 2013 11:21:10 +0800
Message-Id: <1386300083-6882-8-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Flag irq_remapping_enabled is only set by intel_enable_irq_remapping(),
which is called after detect_intel_iommu(). So we should check flag
disable_irq_remap instead of irq_remapping_enabled in function
detect_intel_iommu().

Reviewed-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/dmar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index c17dbf7..70612a9 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -560,7 +560,7 @@ int __init detect_intel_iommu(void)
 
 		dmar = (struct acpi_table_dmar *) dmar_tbl;
 
-		if (ret && irq_remapping_enabled && cpu_has_x2apic &&
+		if (ret && !disable_irq_remap && cpu_has_x2apic &&
 		    dmar->flags & 0x1)
 			pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
-- 
1.7.10.4

