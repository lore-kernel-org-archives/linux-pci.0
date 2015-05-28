Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58156 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbbE1M06 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 08:26:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org, zhudacai@hisilicon.com,
	devicetree@vger.kernel.org, 'Zhang Jukuo' <zhangjukuo@huawei.com>,
	'Gabriele Paoloni' <gabriele.paoloni@huawei.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	'Pratyush Anand' <pratyush.anand@gmail.com>,
	'Richard Zhu' <Richard.Zhu@freescale.com>,
	'Zhichang Yuan' <yuanzhichang@hisilicon.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	qiuzhenfa@hisilicon.com, linux-pci@vger.kernel.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Liviu Dudau' <liviu.dudau@arm.com>,
	'Liguozhu' <liguozhu@hisilicon.com>,
	'Lucas Stach' <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
Date: Thu, 28 May 2015 14:25:28 +0200
Message-ID: <2146536.Pxut7UQbDl@wuerfel>
In-Reply-To: <55670095.7020203@hisilicon.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com> <16371687.jmfn381VuV@wuerfel> <55670095.7020203@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 28 May 2015 19:48:37 Zhou Wang wrote:
> 
> I think this code is fine, and we also should add a funtion point in struct pci_host_bridge to
> store mvebu_pcie_align_resource. How about I make a new version patchset with above codes for
> further reviewing ?
> 

Yes, that would be nice. I've run into a few build errors with the first version,
see below for a version that actually builds. You can base on top of that.

We also need to do something about pci_find_host_bridge() here, possibly just
storing a pointer to the host bridge in pci_bus to avoid the function call.

A few of the other members in pci_bus (ops, msi, sysdata, domain_nr, and
maybe more) could eventually be moved into pci_host_bridge as well, but
that requires changing all code accessing those fields of course.

	Arnd

commit 8140432e10b7cd59ec6246c2b7268abfccdeaaae
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu May 28 12:21:27 2015 +0200

    [HACK] try to get rid of pci_sys_data dependency in bios32
    
    This is an experimental patch to remove the last two dependencies
    we have.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1b9e95..20839d26a490 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -18,15 +18,6 @@
 
 static int debug_pci;
 
-#ifdef CONFIG_PCI_MSI
-struct msi_controller *pcibios_msi_controller(struct pci_dev *dev)
-{
-	struct pci_sys_data *sysdata = dev->bus->sysdata;
-
-	return sysdata->msi_ctrl;
-}
-#endif
-
 /*
  * We can't use pci_get_device() here since we are
  * called from interrupt context.
@@ -462,9 +453,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (!sys)
 			panic("PCI: unable to allocate sys data!");
 
-#ifdef CONFIG_PCI_MSI
-		sys->msi_ctrl = hw->msi_ctrl;
-#endif
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
@@ -493,6 +481,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 				panic("PCI: unable to scan bus!");
 
 			busnr = sys->bus->busn_res.end + 1;
+#ifdef CONFIG_PCI_MSI
+			sys->bus->msi = hw->msi_ctrl;
+#endif
 
 			list_add(&sys->node, head);
 		} else {
@@ -597,9 +588,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
-		return sys->align_resource(dev, res, start, size, align);
-
 	return start;
 }
 
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 1ab863551920..155d05fc11b9 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -22,6 +22,8 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 
+#include "../pci.h" /* HACK to see pci_find_host_bridge */
+
 /*
  * PCIe unit register offsets.
  */
@@ -751,27 +753,20 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+static resource_size_t mvebu_pcie_align_resource(void *data,
+						 const struct resource *res,
+						 resource_size_t size,
+						 resource_size_t align)
 {
-	struct mvebu_pcie *pcie = sys_to_pcie(sys);
-	struct pci_bus *bus;
+	struct pci_dev *dev = data;
 
-	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
-				  &mvebu_pcie_ops, sys, &sys->resources);
-	if (!bus)
-		return NULL;
+	resource_size_t start = res->start;
 
-	pci_scan_child_bus(bus);
+	if (res->flags & IORESOURCE_IO && start & 0x300)
+		start = (start + 0x3ff) & ~0x3ff;
 
-	return bus;
-}
+	start = (start + align - 1) & ~(align - 1);
 
-static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
-						 const struct resource *res,
-						 resource_size_t start,
-						 resource_size_t size,
-						 resource_size_t align)
-{
 	if (dev->bus->number != 0)
 		return start;
 
@@ -796,6 +791,25 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 		return start;
 }
 
+static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	struct mvebu_pcie *pcie = sys_to_pcie(sys);
+	struct pci_host_bridge *phb;
+	struct pci_bus *bus;
+
+	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
+				  &mvebu_pcie_ops, sys, &sys->resources);
+	if (!bus)
+		return NULL;
+
+	phb = pci_find_host_bridge(bus);
+	phb->align_resource = mvebu_pcie_align_resource;
+
+	pci_scan_child_bus(bus);
+
+	return bus;
+}
+
 static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 {
 	struct hw_pci hw;
@@ -812,7 +826,6 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 	hw.scan           = mvebu_pcie_scan_bus;
 	hw.map_irq        = of_irq_parse_and_map_pci;
 	hw.ops            = &mvebu_pcie_ops;
-	hw.align_resource = mvebu_pcie_align_resource;
 
 	pci_common_init(&hw);
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f9254c11a..73abca7ccc7a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -200,7 +200,11 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
-		int resno, resource_size_t size, resource_size_t align)
+		int resno, resource_size_t size, resource_size_t align,
+		resource_size_t (*alignf)(void *,
+					  const struct resource *,
+					  resource_size_t,
+					  resource_size_t))
 {
 	struct resource *res = dev->resource + resno;
 	resource_size_t min;
@@ -217,7 +221,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
-				     pcibios_align_resource, dev);
+				     alignf, dev);
 	if (ret == 0)
 		return 0;
 
@@ -229,7 +233,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
-					     pcibios_align_resource, dev);
+					     alignf, dev);
 		if (ret == 0)
 			return 0;
 	}
@@ -242,7 +246,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
-					     pcibios_align_resource, dev);
+					     alignf, dev);
 
 	return ret;
 }
@@ -251,10 +255,23 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 				resource_size_t size, resource_size_t min_align)
 {
 	struct pci_bus *bus;
+	struct pci_host_bridge *phb;
+	resource_size_t (*alignf)(void *,
+				  const struct resource *,
+				  resource_size_t,
+				  resource_size_t);
 	int ret;
 
 	bus = dev->bus;
-	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
+	phb = pci_find_host_bridge(bus);
+
+	if (phb->align_resource)
+		alignf = phb->align_resource;
+	else
+		alignf = pcibios_align_resource;
+
+	while ((ret = __pci_assign_resource(bus, dev, resno, size,
+					    min_align, alignf))) {
 		if (!bus->parent || !bus->self->transparent)
 			break;
 		bus = bus->parent;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bc50bb05f0ab..3aad084f12ad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -404,6 +404,9 @@ struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* resource_entry */
+	resource_size_t (*align_resource)(void *data,
+			 const struct resource *res,
+			 resource_size_t size, resource_size_t align);
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */

