Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46191 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757846AbbCCRw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Mar 2015 12:52:56 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v8 3/7] of: Fix size when dma-range is not used
Date: Tue, 3 Mar 2015 12:52:10 -0500
Message-ID: <1425405134-24707-4-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
References: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the dma-range size when the DT attribute is missing, i.e., set size to
dev->coherent_dma_mask + 1 instead of dev->coherent_dma_mask.  Also add
code to check invalid values of size configured in DT and log error.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> (AMD Seattle)
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
CC: Joerg Roedel <joro@8bytes.org>
CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/device.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 31a7875..28e74388 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -105,9 +105,24 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask;
+		size = dev->coherent_dma_mask + 1;
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
+
+		/*
+		 * Add a work around to treat the size as mask + 1 in case
+		 * it is defined in DT as a mask.
+		 */
+		if (size & 1) {
+			dev_warn(dev, "Invalid size 0x%llx for dma-range\n",
+				 size);
+			size = size + 1;
+		}
+
+		if (!size) {
+			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
+			return;
+		}
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
-- 
1.7.9.5

