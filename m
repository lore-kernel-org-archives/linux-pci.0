Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
To: <grant.likely@linaro.org>, <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<arnd@arndb.de>, <Suravee.Suthikulpanit@amd.com>,
	<will.deacon@arm.com>, <joro@8bytes.org>, <linux@arm.linux.org.uk>
CC: Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH v1] of/pci : fix of_pci_dma_configure parent ptr NULL
Date: Wed, 11 Mar 2015 12:40:03 -0400
Message-ID: <1426092003-16925-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms such as that based on x86, ia64 etc, root bus is
created with parent node passed in as NULL to pci_create_root_bus().
On these platforms, the patch series "PCI: get DMA configuration from
parent device" when applied causes kernel crash. So add a check for this
in of_pci_dma_configure()

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Rob Herring<robh@kernel.org>
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

