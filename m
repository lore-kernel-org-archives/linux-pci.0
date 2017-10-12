Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdJLP4U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Oct 2017 11:56:20 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: gregkh@linuxfoundation.org, hch@lst.de, robh+dt@kernel.org
Cc: m.szyprowski@samsung.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, thierry.reding@gmail.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: Flag buses which demand DMA configuration
Date: Thu, 12 Oct 2017 16:56:14 +0100
Message-Id: <bd1c6061a6a16f720e992a0f12933bdee6591aea.1507823375.git.robin.murphy@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We do not want the common dma_configure() pathway to apply
indiscriminately to all devices, since there are plenty of buses which
do not have DMA capability, and if their child devices were used for
DMA API calls it would only be indicative of a driver bug. However,
there are a number of buses for which DMA is implicitly expected even
when not described by firmware - those we whitelist with an automatic
opt-in to dma_configure(), assuming that the DMA address space and the
physical address space are equivalent if not otherwise specified.

Commit 723288836628 ("of: restrict DMA configuration") introduced a
short-term fix by comparing explicit bus types, but this approach is far
from pretty, doesn't scale well, and fails to cope at all with bus
drivers which may be built as modules, like host1x. Let's refine things
by making that opt-in a property of the bus type, which neatly addresses
those problems and lets the decision of whether firmware description of
DMA capability should be optional or mandatory stay internal to the bus
drivers themselves.

Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I've not included the pci_epf change here as it's dubious whether that's
doing the right thing to begin with.

Robin.

 drivers/amba/bus.c       | 1 +
 drivers/base/platform.c  | 1 +
 drivers/gpu/host1x/bus.c | 1 +
 drivers/of/device.c      | 8 +-------
 drivers/pci/pci-driver.c | 1 +
 include/linux/device.h   | 4 ++++
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e0f74ddc22b7..594c228d2f02 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -195,6 +195,7 @@ struct bus_type amba_bustype = {
 	.match		= amba_match,
 	.uevent		= amba_uevent,
 	.pm		= &amba_pm,
+	.force_dma	= true,
 };
 
 static int __init amba_init(void)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d1bd99271066..9c95c8db00f8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1142,6 +1142,7 @@ struct bus_type platform_bus_type = {
 	.match		= platform_match,
 	.uevent		= platform_uevent,
 	.pm		= &platform_dev_pm_ops,
+	.force_dma	= true,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f9cde03030fd..ed03b3243195 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -320,6 +320,7 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.pm = &host1x_device_pm_ops,
+	.force_dma = true,
 };
 
 static void __host1x_device_del(struct host1x_device *device)
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 64b710265d39..25bddf9c9fe1 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -9,9 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/amba/bus.h>
 
 #include <asm/errno.h>
 #include "of_private.h"
@@ -101,11 +99,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		 * DMA configuration regardless of whether "dma-ranges" is
 		 * correctly specified or not.
 		 */
-		if (!dev_is_pci(dev) &&
-#ifdef CONFIG_ARM_AMBA
-		    dev->bus != &amba_bustype &&
-#endif
-		    dev->bus != &platform_bus_type)
+		if (!dev->bus->force_dma)
 			return ret == -ENODEV ? 0 : ret;
 
 		dma_addr = offset = 0;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 11bd267fc137..38bdb97b6dc6 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1466,6 +1466,7 @@ struct bus_type pci_bus_type = {
 	.drv_groups	= pci_drv_groups,
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
+	.force_dma	= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 1d2607923a24..357982fb85eb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -97,6 +97,8 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  * @p:		The private data of the driver core, only the driver core can
  *		touch this.
  * @lock_key:	Lock class key for use by the lock validator
+ * @force_dma:	Assume devices on this bus should be set up by dma_configure()
+ * 		even if DMA capability is not explicitly described by firmware.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -135,6 +137,8 @@ struct bus_type {
 
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
+
+	bool force_dma;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
-- 
2.13.4.dirty
