Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57285 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758956Ab3E1Wxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 May 2013 18:53:42 -0400
Subject: [PATCH v2 3/2] pci: Remove unused pci_find_upstream_pcie_bridge()
To: bhelgaas@google.com, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, joro@8bytes.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com
Date: Tue, 28 May 2013 16:53:11 -0600
Message-ID: <20130528225045.15653.3333.stgit@bling.home>
In-Reply-To: <20130528183527.3318.5365.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This no longer has any users.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

I figured I'd follow up with this after the series is accepted, but I
won't turn down an pre-emptive ack from Bjorn.

 drivers/pci/search.c |   35 -----------------------------------
 include/linux/pci.h  |   11 -----------
 2 files changed, 46 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index d0627fa..da2e82e 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -17,41 +17,6 @@
 DECLARE_RWSEM(pci_bus_sem);
 EXPORT_SYMBOL_GPL(pci_bus_sem);
 
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
index 710067f..890d426 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1851,15 +1851,4 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
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

