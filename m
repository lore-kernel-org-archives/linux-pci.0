Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60526 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759908AbaGYNbu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Jul 2014 09:31:50 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] PCI: export pci_get_dma_device() helper to other users
Date: Fri, 25 Jul 2014 16:31:42 +0300
Message-Id: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some chipsets use the function 0 for DMA on other functions of a
multifunctional device. One of the example is Intel EG20T PCH. This is also
applicable to Lynxpoint PCH when LPSS devices are switched to PCI mode.

This patch exports a useful helper to get a device of the DMA. This device is
needed to request a DMA channel from a proper controller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/quirks.c | 2 +-
 include/linux/pci.h  | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 80c2d01..8352e5b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3517,7 +3517,7 @@ static struct pci_dev *pci_func_0_dma_source(struct pci_dev *dev)
 	if (!PCI_FUNC(dev->devfn))
 		return pci_dev_get(dev);
 
-	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	return pci_get_dma_device(dev);
 }
 
 static const struct pci_dev_dma_source {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 61978a4..86caab7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1575,6 +1575,15 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 static inline void pci_dev_specific_enable_acs(struct pci_dev *dev) { }
 #endif
 
+/*
+ * Some chipsets use the function 0 for DMA on other functions of a
+ * multifunctional device.
+ */
+static inline struct pci_dev *pci_get_dma_device(struct pci_dev *dev)
+{
+	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+}
+
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
-- 
2.0.1

