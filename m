Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54579 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851AbbCCRw7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2015 12:52:59 -0500
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
Subject: [PATCH v8 6/7] PCI: Update DMA configuration from DT
Date: Tue, 3 Mar 2015 12:52:13 -0500
Message-ID: <1425405134-24707-7-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
References: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If there is a DT node available for the root bridge's parent device, use
the DMA configuration from that device node.  For example, Keystone PCI
devices would require dma_pfn_offset to be set correctly in the device
structure of the PCI device in order to have the correct DMA mask.  The DT
node will have dma-ranges defined for this.  Also support using the DT
property dma-coherent to allow coherent DMA operation by the PCI device.

Use the new helper function of_pci_dma_configure() to update the device DMA
configuration.  This fixes DMA on systems where DMA addresses are a
constant offset from CPU physical addresses.

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
 drivers/pci/probe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400..413c1dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -1520,6 +1521,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
+	of_pci_dma_configure(dev);
 
 	pci_set_dma_max_seg_size(dev, 65536);
 	pci_set_dma_seg_boundary(dev, 0xffffffff);
-- 
1.7.9.5

