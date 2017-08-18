Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <nsekhar@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 01/18] PCI: endpoint: pci-epc-core: Use of_dma_configure() to set initial dma mask
Date: Fri, 18 Aug 2017 20:27:53 +0530
Message-ID: <20170818145810.17649-2-kishon@ti.com>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use of_dma_configure() to set the initial dma mask of epf device. This
helps to get rid of "Coherent DMA mask 0x0 (pfn 0x0-0x1) covers a smaller
range of system memory than the DMA zone pfn" warning in certain platforms
like TI's K2G resulting in coherent dma mask not being set.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index caa7be10e473..42c2a1156325 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -370,6 +371,7 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
+	struct device *dev = epc->dev.parent;
 
 	if (epf->epc)
 		return -EBUSY;
@@ -381,8 +383,12 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 		return -EINVAL;
 
 	epf->epc = epc;
-	dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
-	epf->dev.dma_mask = epc->dev.dma_mask;
+	if (dev->of_node) {
+		of_dma_configure(&epf->dev, dev->of_node);
+	} else {
+		dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
+		epf->dev.dma_mask = epc->dev.dma_mask;
+	}
 
 	spin_lock_irqsave(&epc->lock, flags);
 	list_add_tail(&epf->list, &epc->pci_epf);
@@ -500,6 +506,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	dma_set_coherent_mask(&epc->dev, dev->coherent_dma_mask);
 	epc->dev.class = pci_epc_class;
 	epc->dev.dma_mask = dev->dma_mask;
+	epc->dev.parent = dev;
 	epc->ops = ops;
 
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
-- 
2.11.0
