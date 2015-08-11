Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34257 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbbHKPvL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 11:51:11 -0400
Received: by igui7 with SMTP id i7so43098522igu.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 08:51:10 -0700 (PDT)
Subject: [PATCH v3 01/11] iommu/vt-d: Cache PCI ATS state and Invalidate
 Queue Depth
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>,
	iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 11 Aug 2015 10:51:07 -0500
Message-ID: <20150811155107.21078.24884.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
Queue Depth in performance-sensitive paths.  It's easy to cache these,
which removes dependencies on PCI.

Remember the ATS enabled state.  When enabling, read the queue depth once
and cache it in the device_domain_info struct.  This is similar to what
amd_iommu.c does.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a98a7b2..c22a549 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -408,6 +408,10 @@ struct device_domain_info {
 	struct list_head global; /* link to global list */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
+	struct {
+		u8 enabled:1;
+		u8 qdep;
+	} ats;			/* ATS state */
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
@@ -1391,19 +1395,26 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
+	struct pci_dev *pdev;
+
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
-	pci_enable_ats(to_pci_dev(info->dev), VTD_PAGE_SHIFT);
+	pdev = to_pci_dev(info->dev);
+	if (pci_enable_ats(pdev, VTD_PAGE_SHIFT))
+		return;
+
+	info->ats.enabled = 1;
+	info->ats.qdep = pci_ats_queue_depth(pdev);
 }
 
 static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
-	if (!info->dev || !dev_is_pci(info->dev) ||
-	    !pci_ats_enabled(to_pci_dev(info->dev)))
+	if (!info->ats.enabled)
 		return;
 
 	pci_disable_ats(to_pci_dev(info->dev));
+	info->ats.enabled = 0;
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -1415,16 +1426,11 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
-		struct pci_dev *pdev;
-		if (!info->dev || !dev_is_pci(info->dev))
-			continue;
-
-		pdev = to_pci_dev(info->dev);
-		if (!pci_ats_enabled(pdev))
+		if (!info->ats.enabled)
 			continue;
 
 		sid = info->bus << 8 | info->devfn;
-		qdep = pci_ats_queue_depth(pdev);
+		qdep = info->ats.qdep;
 		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -2272,6 +2278,8 @@ static struct dmar_domain *dmar_insert_dev_info(struct intel_iommu *iommu,
 
 	info->bus = bus;
 	info->devfn = devfn;
+	info->ats.enabled = 0;
+	info->ats.qdep = 0;
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;

