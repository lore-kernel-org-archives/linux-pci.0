Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44198 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbcBXToT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:44:19 -0500
Subject: [PATCH v4 4/6] PCI: Rename dma_alias_is_enabled() to
 pci_devs_are_dma_aliases()
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Wed, 24 Feb 2016 13:44:15 -0600
Message-ID: <20160224194415.7585.37290.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This should be folded into the previous patch.  I left it separate to show
the interface difference more clearly.

Also, pci_devs_are_dma_aliases() uses PCI internals (dma_alias_mask), so I
think it should be in PCI code instead of in IOMMU code.  That would mean
both it and pci_add_dma_alias() should probably be declared in
include/linux/pci.h (but not exported to modules with EXPORT_SYMBOL()).
---
 drivers/iommu/iommu.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a214e19..031d06b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -659,10 +659,12 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	return NULL;
 }
 
-static bool dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
+static bool pci_devs_are_dma_aliases(struct pci_dev *pdev1, struct pci_dev *pdev2)
 {
-	return dev->dma_alias_mask &&
-	       test_bit(devfn, dev->dma_alias_mask);
+	return (pdev1->dma_alias_mask &&
+		test_bit(pdev2->devfn, pdev1->dma_alias_mask)) ||
+	       (pdev2->dma_alias_mask &&
+		test_bit(pdev1->devfn, pdev2->dma_alias_mask));
 }
 
 /*
@@ -692,8 +694,7 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 			continue;
 
 		/* We alias them or they alias us */
-		if (dma_alias_is_enabled(pdev, tmp->devfn) ||
-		    dma_alias_is_enabled(tmp, pdev->devfn)) {
+		if (pci_devs_are_dma_aliases(pdev, tmp)) {
 			group = get_pci_alias_group(tmp, devfns);
 			if (group) {
 				pci_dev_put(tmp);

