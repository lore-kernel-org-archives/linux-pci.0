Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbbEUGzg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 May 2015 02:55:36 -0400
Date: Thu, 21 May 2015 14:54:51 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 08/10] iommu/vt-d: assign new page table for dma_map
Message-ID: <20150521065451.GA23661@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-9-git-send-email-zhen-hual@hp.com>
 <20150520235242.GA2342@dhcp-17-102.nay.redhat.com>
 <555D3470.7060902@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555D3470.7060902@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/21/15 at 09:27am, Li, ZhenHua wrote:
> Hi Baoquan,
> 
> In the early version of this patchset, old page tables are used by new
> kernel.  But as discussed, we need to make kernel use new pages when
> there is a new dma request , so we need to unmap the pages which were
> mapped in old kernel, and this is what this patch does.

OK, just a new page table allocated in init_domain(), right? I thought a
specific empty page-table is allocated for these new domains in kdump
kernel.

> 
> Thanks
> Zhenhua
> 
> On 05/21/2015 07:52 AM, Baoquan He wrote:
> >On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> >>When a device driver issues the first dma_map command for a device, we
> >>assign a new and empty page-table, thus removing all mappings from the
> >>old kernel for the device.
> >
> >Hi Zhenhua,
> >
> > From your patch I got it will remove all mappings, assign a new
> >page-table. But I didn't got why you stress an empty page-table. Did I
> >miss anything?
> >
> >Thanks
> >Baoquan
> >
> >>
> >>Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
> >>---
> >>  drivers/iommu/intel-iommu.c | 58 ++++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 50 insertions(+), 8 deletions(-)
> >>
> >>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> >>index 91545bf..3cc1027 100644
> >>--- a/drivers/iommu/intel-iommu.c
> >>+++ b/drivers/iommu/intel-iommu.c
> >>@@ -396,6 +396,9 @@ static int copy_root_entry_table(struct intel_iommu *iommu);
> >>
> >>  static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
> >>
> >>+static void unmap_device_dma(struct dmar_domain *domain,
> >>+				struct device *dev,
> >>+				struct intel_iommu *iommu);
> >>  static void iommu_check_pre_te_status(struct intel_iommu *iommu);
> >>  static u8 g_translation_pre_enabled;
> >>
> >>@@ -3115,6 +3118,7 @@ static struct iova *intel_alloc_iova(struct device *dev,
> >>  static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
> >>  {
> >>  	struct dmar_domain *domain;
> >>+	struct intel_iommu *iommu;
> >>  	int ret;
> >>
> >>  	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
> >>@@ -3124,14 +3128,30 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
> >>  		return NULL;
> >>  	}
> >>
> >>-	/* make sure context mapping is ok */
> >>-	if (unlikely(!domain_context_mapped(dev))) {
> >>-		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
> >>-		if (ret) {
> >>-			printk(KERN_ERR "Domain context map for %s failed",
> >>-			       dev_name(dev));
> >>-			return NULL;
> >>-		}
> >>+	/* if in kdump kernel, we need to unmap the mapped dma pages,
> >>+	 * detach this device first.
> >>+	 */
> >>+	if (likely(domain_context_mapped(dev))) {
> >>+		iommu = domain_get_iommu(domain);
> >>+		if (iommu->pre_enabled_trans) {
> >>+			unmap_device_dma(domain, dev, iommu);
> >>+
> >>+			domain = get_domain_for_dev(dev,
> >>+				DEFAULT_DOMAIN_ADDRESS_WIDTH);
> >>+			if (!domain) {
> >>+				pr_err("Allocating domain for %s failed",
> >>+				       dev_name(dev));
> >>+				return NULL;
> >>+			}
> >>+		} else
> >>+			return domain;
> >>+	}
> >>+
> >>+	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
> >>+	if (ret) {
> >>+		pr_err("Domain context map for %s failed",
> >>+		       dev_name(dev));
> >>+		return NULL;
> >>  	}
> >>
> >>  	return domain;
> >>@@ -5168,6 +5188,28 @@ static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
> >>  	return ret;
> >>  }
> >>
> >>+static void unmap_device_dma(struct dmar_domain *domain,
> >>+				struct device *dev,
> >>+				struct intel_iommu *iommu)
> >>+{
> >>+	struct context_entry *ce;
> >>+	struct iova *iova;
> >>+	phys_addr_t phys_addr;
> >>+	dma_addr_t dev_addr;
> >>+	struct pci_dev *pdev;
> >>+
> >>+	pdev = to_pci_dev(dev);
> >>+	ce = iommu_context_addr(iommu, pdev->bus->number, pdev->devfn, 1);
> >>+	phys_addr = context_address_root(ce) << VTD_PAGE_SHIFT;
> >>+	dev_addr = phys_to_dma(dev, phys_addr);
> >>+
> >>+	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
> >>+	if (iova)
> >>+		intel_unmap(dev, dev_addr);
> >>+
> >>+	domain_remove_one_dev_info(domain, dev);
> >>+}
> >>+
> >>  static void iommu_check_pre_te_status(struct intel_iommu *iommu)
> >>  {
> >>  	u32 sts;
> >>--
> >>2.0.0-rc0
> >>
> 
