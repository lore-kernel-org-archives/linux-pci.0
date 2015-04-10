Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:49524 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbDJIoI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 04:44:08 -0400
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
To: <dwmw2@infradead.org>, <indou.takao@jp.fujitsu.com>,
	<bhe@redhat.com>, <joro@8bytes.org>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>
Cc: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
	<alex.williamson@redhat.com>, <ddutile@redhat.com>,
	<ishii.hironobu@jp.fujitsu.com>, <bhelgaas@google.com>,
	<doug.hatch@hp.com>, <jerry.hoemann@hp.com>, <tom.vaden@hp.com>,
	<li.zhang6@hp.com>, <lisa.mitchell@hp.com>,
	<billsumnerlinux@gmail.com>, <zhen-hual@hp.com>, <rwright@hp.com>
Subject: [PATCH v10 08/10] iommu/vt-d: assign new page table for dma_map
Date: Fri, 10 Apr 2015 16:42:11 +0800
Message-Id: <1428655333-19504-9-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a device driver issues the first dma_map command for a device, we
assign a new and empty page-table, thus removing all mappings from the
old kernel for the device.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 58 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3d4ea43..a874426 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -398,6 +398,9 @@ static int copy_root_entry_table(struct intel_iommu *iommu);
 
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
 
+static void unmap_device_dma(struct dmar_domain *domain,
+				struct device *dev,
+				struct intel_iommu *iommu);
 static void iommu_check_pre_te_status(struct intel_iommu *iommu);
 static u8 g_translation_pre_enabled;
 
@@ -3096,6 +3099,7 @@ static struct iova *intel_alloc_iova(struct device *dev,
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
 	int ret;
 
 	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
@@ -3105,14 +3109,30 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 		return NULL;
 	}
 
-	/* make sure context mapping is ok */
-	if (unlikely(!domain_context_mapped(dev))) {
-		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
-		if (ret) {
-			printk(KERN_ERR "Domain context map for %s failed",
-			       dev_name(dev));
-			return NULL;
-		}
+	/* if in kdump kernel, we need to unmap the mapped dma pages,
+	 * detach this device first.
+	 */
+	if (likely(domain_context_mapped(dev))) {
+		iommu = domain_get_iommu(domain);
+		if (iommu->pre_enabled_trans) {
+			unmap_device_dma(domain, dev, iommu);
+
+			domain = get_domain_for_dev(dev,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH);
+			if (!domain) {
+				pr_err("Allocating domain for %s failed",
+				       dev_name(dev));
+				return NULL;
+			}
+		} else
+			return domain;
+	}
+
+	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
+	if (ret) {
+		pr_err("Domain context map for %s failed",
+		       dev_name(dev));
+		return NULL;
 	}
 
 	return domain;
@@ -5151,6 +5171,28 @@ static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 	return ret;
 }
 
+static void unmap_device_dma(struct dmar_domain *domain,
+				struct device *dev,
+				struct intel_iommu *iommu)
+{
+	struct context_entry *ce;
+	struct iova *iova;
+	phys_addr_t phys_addr;
+	dma_addr_t dev_addr;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	ce = device_to_context_entry(iommu, pdev->bus->number, pdev->devfn);
+	phys_addr = context_address_root(ce) << VTD_PAGE_SHIFT;
+	dev_addr = phys_to_dma(dev, phys_addr);
+
+	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
+	if (iova)
+		intel_unmap(dev, dev_addr);
+
+	domain_remove_one_dev_info(domain, dev);
+}
+
 static void iommu_check_pre_te_status(struct intel_iommu *iommu)
 {
 	u32 sts;
-- 
2.0.0-rc0

