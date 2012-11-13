Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] intel-iommu: Fix lookup in add device
To: iommu@lists.linux-foundation.org, joro@8bytes.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: prometheanfire@gentoo.org, cardoe@gentoo.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mthode@mthode.org, ddutile@redhat.com, bhelgaas@google.com,
	dwmw2@infradead.org
Date: Tue, 13 Nov 2012 10:22:03 -0700
Message-ID: <20121113172144.6783.37724.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can't assume this device exists, fall back to the bridge itself.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Matthew Thode <prometheanfire@gentoo.org>
Cc: stable@vger.kernel.org
---
 drivers/iommu/intel-iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d4a4cd4..0badfa4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4108,7 +4108,7 @@ static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *bridge, *dma_pdev;
+	struct pci_dev *bridge, *dma_pdev = NULL;
 	struct iommu_group *group;
 	int ret;
 
@@ -4122,7 +4122,7 @@ static int intel_iommu_add_device(struct device *dev)
 			dma_pdev = pci_get_domain_bus_and_slot(
 						pci_domain_nr(pdev->bus),
 						bridge->subordinate->number, 0);
-		else
+		if (!dma_pdev)
 			dma_pdev = pci_dev_get(bridge);
 	} else
 		dma_pdev = pci_dev_get(pdev);

