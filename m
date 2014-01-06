Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [Patch Part1 V3 03/20] iommu/vt-d: fix a race window in allocating domain ID for virtual machines
Date: Mon,  6 Jan 2014 14:18:10 +0800
Message-Id: <1388989107-4795-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function intel_iommu_domain_init() may be concurrently called by upper
layer without serialization, so use atomic_t to protect domain id
allocation.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/intel-iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfe..b8e3b48 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3877,7 +3877,7 @@ static void vm_domain_remove_all_dev_info(struct dmar_domain *domain)
 }
 
 /* domain id for virtual machine, it won't be set in context */
-static unsigned long vm_domid;
+static atomic_t vm_domid = ATOMIC_INIT(0);
 
 static struct dmar_domain *iommu_alloc_vm_domain(void)
 {
@@ -3887,7 +3887,7 @@ static struct dmar_domain *iommu_alloc_vm_domain(void)
 	if (!domain)
 		return NULL;
 
-	domain->id = vm_domid++;
+	domain->id = atomic_inc_return(&vm_domid);
 	domain->nid = -1;
 	memset(domain->iommu_bmp, 0, sizeof(domain->iommu_bmp));
 	domain->flags = DOMAIN_FLAG_VIRTUAL_MACHINE;
-- 
1.7.10.4

