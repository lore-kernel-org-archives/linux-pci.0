Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:63519 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbeH3OeV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Aug 2018 10:34:21 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI: Switch to bitmap_zalloc()
Date: Thu, 30 Aug 2018 13:32:36 +0300
Message-Id: <20180830103236.60736-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pci.c   | 3 +--
 drivers/pci/probe.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff9619b5fa..c6de7e0dd3fa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5689,8 +5689,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
-					      sizeof(long), GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec784009a36b..b6465a59aeb1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2140,7 +2140,7 @@ static void pci_release_dev(struct device *dev)
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
 	kfree(pci_dev->driver_override);
-	kfree(pci_dev->dma_alias_mask);
+	bitmap_free(pci_dev->dma_alias_mask);
 	kfree(pci_dev);
 }
 
-- 
2.18.0
