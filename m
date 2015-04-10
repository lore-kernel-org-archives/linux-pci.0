Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:41788 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbDJInP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 04:43:15 -0400
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
Subject: [PATCH v10 01/10] iommu/vt-d: New function to attach domain with id
Date: Fri, 10 Apr 2015 16:42:04 +0800
Message-Id: <1428655333-19504-2-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow specification of the domain-id for the new domain.
This patch only adds a new function iommu_attach_domain_with_id, it is like
the function iommu_attach_domain(), only adding a parameter "did".

Bill Sumner:
    (In older versions) Add new 'did' parameter to iommu_attach_domain();
    The caller of this function.

Li, Zhenhua:
    New function iommu_attach_domain_with_id(), instead of updating function
    iommu_attach_domain();

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2d1e05b..3a93ce0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1558,6 +1558,16 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 	return num;
 }
 
+static int iommu_attach_domain_with_id(struct dmar_domain *domain,
+			       struct intel_iommu *iommu,
+			       int domain_number)
+{
+	if (domain_number >= 0)
+		return domain_number;
+
+	return iommu_attach_domain(domain, iommu);
+}
+
 static int iommu_attach_vm_domain(struct dmar_domain *domain,
 				  struct intel_iommu *iommu)
 {
@@ -2224,6 +2234,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
+	int did = -1;   /* Default to "no domain_id supplied" */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2257,7 +2268,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	domain->id = iommu_attach_domain(domain, iommu);
+	domain->id = iommu_attach_domain_with_id(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
 		return NULL;
-- 
2.0.0-rc0

