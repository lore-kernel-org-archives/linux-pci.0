Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24696 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab3EJVTU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 May 2013 17:19:20 -0400
Subject: [PATCH 3/3] pci: Remove pci_find_pcie_upstream_bridge
To: bhelgaas@google.com, stephen@networkplumber.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, ddutile@redhat.com
Date: Fri, 10 May 2013 15:18:58 -0600
Message-ID: <20130510211858.32592.20890.stgit@bling.home>
In-Reply-To: <20130510210937.32592.21950.stgit@bling.home>
References: <20130510210937.32592.21950.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This function no longer has any users.

Signed-off-by: Alex williamson <alex.williamson@redhat.com>
---
 drivers/pci/search.c |   35 -----------------------------------
 include/linux/pci.h  |   11 -----------
 2 files changed, 46 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 0357f74..bdbff05 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -74,41 +74,6 @@ struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
 	return NULL;
 }
 
-/*
- * find the upstream PCIe-to-PCI bridge of a PCI device
- * if the device is PCIE, return NULL
- * if the device isn't connected to a PCIe bridge (that is its parent is a
- * legacy PCI bridge and the bridge is directly connected to bus 0), return its
- * parent
- */
-struct pci_dev *
-pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
-{
-	struct pci_dev *tmp = NULL;
-
-	if (pci_is_pcie(pdev))
-		return NULL;
-	while (1) {
-		if (pci_is_root_bus(pdev->bus))
-			break;
-		pdev = pdev->bus->self;
-		/* a p2p bridge */
-		if (!pci_is_pcie(pdev)) {
-			tmp = pdev;
-			continue;
-		}
-		/* PCI device should connect to a PCIe bridge */
-		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_PCI_BRIDGE) {
-			/* Busted hardware? */
-			WARN_ON_ONCE(1);
-			return NULL;
-		}
-		return pdev;
-	}
-
-	return tmp;
-}
-
 static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
 {
 	struct pci_bus* child;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e87423a..9d9dcf5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1877,15 +1877,4 @@ struct pci_dev *pci_walk_up_to_first_match(struct pci_dev *pdev,
  */
 bool pci_is_pcie_bridge(struct pci_dev *pdev);
 
-/**
- * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a device
- * @pdev: the PCI device
- *
- * if the device is PCIE, return NULL
- * if the device isn't connected to a PCIe bridge (that is its parent is a
- * legacy PCI bridge and the bridge is directly connected to bus 0), return its
- * parent
- */
-struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
-
 #endif /* LINUX_PCI_H */

