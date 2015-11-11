Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4819 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbKKBAI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 20:00:08 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
CC: <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
	<bhelgaas@google.com>, <robh@kernel.org>, <linux@arm.linux.org.uk>,
	<wangzhou1@hisilicon.com>, <liguozhu@hisilicon.com>,
	<xuwei5@hisilicon.com>, gabpao01 <gabriele.paoloni@huawei.com>
Subject: [PATCH] ARM/PCI: move align_resource function pointer into pci_host_bridge structure
Date: Wed, 11 Nov 2015 09:12:25 +0800
Message-ID: <1447204345-143793-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabpao01 <gabriele.paoloni@huawei.com>

commit b3a72384fe29 ("ARM/PCI: Replace
pci_sys_data->align_resource with global function pointer") has
introduced a global function pointer that makes the ARM specific
code not portable and broken in case any platform have a two
different HW IPs for the PCIe host bridge controller.
This patch moves align_resource function pointer into
pci_host_bridge structure so that the code is now suitable to be
reworked as we want to get rid of hw_pci structure (the host bridge
drivers can just set the align function pointer in the
pci_host_bridge structure) and there is no more broken code for a
SoC with two HW IPs.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 arch/arm/kernel/bios32.c | 19 +++++++++++--------
 drivers/pci/pci.h        |  2 --
 include/linux/pci.h      |  9 +++++++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 6551d28..066f7f9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -17,11 +17,6 @@
 #include <asm/mach/pci.h>
 
 static int debug_pci;
-static resource_size_t (*align_resource)(struct pci_dev *dev,
-		  const struct resource *res,
-		  resource_size_t start,
-		  resource_size_t size,
-		  resource_size_t align) = NULL;
 
 /*
  * We can't use pci_get_device() here since we are
@@ -461,7 +456,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
-		align_resource = hw->align_resource;
 		INIT_LIST_HEAD(&sys->resources);
 
 		if (hw->private_data)
@@ -470,6 +464,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
+			struct pci_host_bridge *host_bridge;
+
 			ret = pcibios_init_resources(nr, sys);
 			if (ret)  {
 				kfree(sys);
@@ -491,6 +487,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			busnr = sys->bus->busn_res.end + 1;
 
 			list_add(&sys->node, head);
+
+			host_bridge = pci_find_host_bridge(sys->bus);
+			host_bridge->align_resource = hw->align_resource;
 		} else {
 			kfree(sys);
 			if (ret < 0)
@@ -578,14 +577,18 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 {
 	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
+	struct pci_host_bridge *host_bridge;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (align_resource)
-		return align_resource(dev, res, start, size, align);
+	host_bridge = pci_find_host_bridge(dev->bus);
+
+	if (host_bridge->align_resource)
+		return host_bridge->align_resource(dev, res,
+				start, size, align);
 
 	return start;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd2f03f..d390fc1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,6 +337,4 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
-struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
-
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e828e7b..980b7bc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -412,9 +412,18 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	/* Resource alignement requirements     */
+	resource_size_t (*align_resource)(struct pci_dev *dev,
+			const struct resource *res,
+			resource_size_t start,
+			resource_size_t size,
+			resource_size_t align);
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
+
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
-- 
2.1.4

