Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55278 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbbBFUQW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Feb 2015 15:16:22 -0500
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
Subject: [PATCH] of: calculate masks of the device based on dma-range size
Date: Fri, 6 Feb 2015 15:15:20 -0500
Message-ID: <1423253720-2785-1-git-send-email-m-karicheri2@ti.com>
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
 drivers/of/device.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 314c8a9..44209fa 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -83,17 +83,18 @@ int of_device_add(struct platform_device *ofdev)
  */
 void of_dma_configure(struct device *dev, struct device_node *np)
 {
-	u64 dma_addr, paddr, size;
+	u64 dma_addr = 0, paddr, size;
 	int ret;
 	bool coherent;
-	unsigned long offset;
+	unsigned long offset = 0;
 	struct iommu_ops *iommu;
 
 	/*
 	 * Set default dma-mask to 32 bit. Drivers are expected to setup
 	 * the correct supported dma_mask.
 	 */
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	/*
 	 * Set it to coherent_dma_mask by default if the architecture
@@ -102,11 +103,14 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;
 
+	/*
+	 * Set default size to cover the 32-bit. Drivers are expected to setup
+	 * the correct size and dma_mask.
+	 */
+	size = 1ULL << 32;
+
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
-	if (ret < 0) {
-		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask + 1;
-	} else {
+	if (!ret) {
 		offset = PFN_DOWN(paddr - dma_addr);
 
 		/*
@@ -128,6 +132,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 
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

