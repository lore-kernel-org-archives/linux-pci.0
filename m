Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>
Subject: [PATCH] of: Devices with pci_epf_bus_type require DMA configuration
Date: Wed, 11 Oct 2017 13:30:41 +0530
Message-ID: <20171011080041.12918-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci-epc-core.c invokes of_dma_configure in order to configure
the coherent_dma_mask/dma_mask of endpoint function device. This is
required for dma_alloc_coherent to succeed in pci function driver
(pci-epf-test.c). However after
commit 723288836628bc1c08 ("of: restrict DMA configuration"),
of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
of endpoint function device (since it doesn't have dma-ranges
property), resulting in dma_alloc_coherent in pci endpoint function
driver to to fail. Fix it by making sure of_dma_configure configures
coherent_dma_mask/dma_mask irrespective of whether the node has
dma-ranges property or not.

Fixes: 723288836628bc1c08 ("of: restrict DMA configuration")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/of/device.c                 | 4 +++-
 drivers/pci/endpoint/pci-epf-core.c | 3 +--
 include/linux/pci-epf.h             | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 64b710265d39..881cf80a3d69 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/pci-epf.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
@@ -105,7 +106,8 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 #ifdef CONFIG_ARM_AMBA
 		    dev->bus != &amba_bustype &&
 #endif
-		    dev->bus != &platform_bus_type)
+		    dev->bus != &platform_bus_type &&
+		    dev->bus != &pci_epf_bus_type)
 			return ret == -ENODEV ? 0 : ret;
 
 		dma_addr = offset = 0;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index ae1611a62808..6f354ec6be71 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -26,7 +26,6 @@
 #include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
 
-static struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
 
 /**
@@ -344,7 +343,7 @@ static int pci_epf_device_remove(struct device *dev)
 	return ret;
 }
 
-static struct bus_type pci_epf_bus_type = {
+struct bus_type pci_epf_bus_type = {
 	.name		= "pci-epf",
 	.match		= pci_epf_device_match,
 	.probe		= pci_epf_device_probe,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 60d551a9a1ba..83a3fb7e6ac1 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -16,6 +16,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
 
+extern struct bus_type pci_epf_bus_type;
 struct pci_epf;
 
 enum pci_barno {
-- 
2.11.0
