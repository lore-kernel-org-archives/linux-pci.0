Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49459 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbbBKRy1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Feb 2015 12:54:27 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v1] of: calculate masks of the device based on dma-range size
Date: Wed, 11 Feb 2015 12:53:35 -0500
Message-ID: <1423677215-28968-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch update of_dma_configure() API to calculate the
masks (dma_mask and coherent_dma_mask) based on the dma-range
values set in DT for the device. Also limit the mask to lower
of the default mask and mask calculated.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 - apply on top of the series "[PATCH v6 0/7] PCI: get DMA configuration
   from parent device" at www.spinics.net/lists/linux-pci/msg38699.html

 v1 - updated based on comments. Reverted to original
      code for of_dma_get_range() within the of_dma_configure()

 drivers/of/device.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 314c8a9..167ad2d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -90,10 +90,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	struct iommu_ops *iommu;
 
 	/*
-	 * Set default dma-mask to 32 bit. Drivers are expected to setup
-	 * the correct supported dma_mask.
+	 * Set default coherent_dma_mask to 32 bit. Drivers are expected to
+	 * setup the correct supported mask.
 	 */
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	/*
 	 * Set it to coherent_dma_mask by default if the architecture
@@ -102,6 +103,11 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;
 
+	/*
+	 * Use default size to cover 32 bit. Drivers need to set this in DT
+	 * to override the same.
+	 */
+	size = 1ULL << 32;
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
@@ -128,6 +134,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 
 	dev->dma_pfn_offset = offset;
 
+	/*
+	 * Limit coherent and dma mask based on size and default mask
+	 * set by the driver.
+	 */
+	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
+				     DMA_BIT_MASK(ilog2(dma_addr + size)));
+	*dev->dma_mask = min((*dev->dma_mask),
+			     DMA_BIT_MASK(ilog2(dma_addr + size)));
+
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
-- 
1.7.9.5

