Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58994 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbE0TwY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 15:52:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Zhou Wang <wangzhou1@hisilicon.com>, zhudacai@hisilicon.com,
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
Date: Wed, 27 May 2015 21:51:52 +0200
Message-ID: <16371687.jmfn381VuV@wuerfel>
In-Reply-To: <5565EEAD.9070003@st.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com> <2095085.CuXXeGT0Wg@wuerfel> <5565EEAD.9070003@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 27 May 2015 18:19:57 Fabrice Gasnier wrote:
> On 05/27/2015 05:43 PM, Arnd Bergmann wrote:
> > On Wednesday 27 May 2015 17:31:46 Arnd Bergmann wrote:
> >> Yes, that works. However there are two problems with the approach:
> >>
> >> - we have to change all PCI host drivers on ARM to do this in order to remove
> >>    the ARM-specific pcibios_msi_controller() function
> >> - it's possible that there are dw_pcie implementations that do not include
> >>    an MSI controller, so that pointer would be NULL, which leads to the
> >>    core code to still call the ARM-specific pcibios_msi_controller() function
> >>    unless we remove it.
> > I wonder if this simple patch would be sufficient to kill off
> > pcibios_msi_controller().
> >
> > Can one of you try it?
> >
> >       Arnd
> 
> Hi Arnd,
> I tested it quickly on my platform, with and without CONFIG_PCI_MSI.
> In both case it seems to run fine with dw pcie.
> 

Awesome. Now we just need to find a way to move the align_resource callback.
I wonder if the approach below would be acceptable.

	Arnd

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1b9e95..20839d26a490 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -597,9 +588,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	start = (start + align - 1) & ~(align - 1);
 
-	if (sys->align_resource)
-		return sys->align_resource(dev, res, start, size, align);
-
 	return start;
 }
 
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 1ab863551920..74216c9c2822 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -751,27 +751,20 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
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
+	struct device *dev = data;
 
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
 
@@ -796,6 +789,25 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
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
@@ -812,7 +824,6 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 	hw.scan           = mvebu_pcie_scan_bus;
 	hw.map_irq        = of_irq_parse_and_map_pci;
 	hw.ops            = &mvebu_pcie_ops;
-	hw.align_resource = mvebu_pcie_align_resource;
 
 	pci_common_init(&hw);
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f9254c11a..e1f5e13c4636 100644
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
@@ -251,10 +255,19 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 				resource_size_t size, resource_size_t min_align)
 {
 	struct pci_bus *bus;
+	struct pci_host_bridge *phb;
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

