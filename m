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
Subject: [Patch Part2 V2 02/17] iommu/vt-d: avoid caching stale domain_device_info and fix memory leak
Date: Wed, 19 Feb 2014 14:07:22 +0800
Message-Id: <1392790057-32434-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function device_notifier() in intel-iommu.c fails to remove
device_domain_info data structures for PCI devices if they are
associated with si_domain because iommu_no_mapping() returns true
for those PCI devices. This will cause memory leak and caching of
stale information in domain->devices list.

So fix the issue by not calling iommu_no_mapping() and skipping check
of iommu_pass_through.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 52be755..f75d3ae 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3600,14 +3600,14 @@ static int device_notifier(struct notifier_block *nb,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dmar_domain *domain;
 
-	if (iommu_no_mapping(dev))
+	if (iommu_dummy(pdev))
 		return 0;
 
 	domain = find_domain(pdev);
 	if (!domain)
 		return 0;
 
-	if (action == BUS_NOTIFY_UNBOUND_DRIVER && !iommu_pass_through) {
+	if (action == BUS_NOTIFY_UNBOUND_DRIVER) {
 		domain_remove_one_dev_info(domain, pdev);
 
 		if (!(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) &&
-- 
1.7.10.4

