Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49154 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbbCJP0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Mar 2015 11:26:08 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <grant.likely@linaro.org>, <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<arnd@arndb.de>, <Suravee.Suthikulpanit@amd.com>,
	<will.deacon@arm.com>, <joro@8bytes.org>, <linux@arm.linux.org.uk>
CC: Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH] pci: of : fix BUG: unable to handle kernel
Date: Tue, 10 Mar 2015 11:25:39 -0400
Message-ID: <1426001139-18419-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms such as that based on x86, ia64 etc, root bus is
created with parent node passed in as NULL to pci_create_root_bus().
On these platforms, the patch series "PCI: get DMA configuration from
parent device" when applied causes kernel crash. So add a check for this
in of_pci_dma_configure()

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/of/of_pci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 86d3c38..a8e485c 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -129,6 +129,10 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
 	struct device *dev = &pci_dev->dev;
 	struct device *bridge = pci_get_host_bridge_device(pci_dev);
 
+	/* Some platforms can have bridge->parent set to NULL */
+	if (!bridge->parent)
+		return;
+
 	of_dma_configure(dev, bridge->parent->of_node);
 	pci_put_host_bridge_device(bridge);
 }
-- 
1.7.9.5

