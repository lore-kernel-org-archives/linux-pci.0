Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56468 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbDOKE7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 06:04:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	gabriele.paoloni@huawei.com, yuanzhichang@hisilicon.com,
	zhudacai@hisilicon.com, zhangjukuo@huawei.com,
	xiehaitao@huawei.com, liguozhu@hisilicon.com,
	wangzhou.bry@gmail.com
Subject: Re: [RFC PATCH 1/3] PCI: host: designware: support ARM64
Date: Wed, 15 Apr 2015 12:04:31 +0200
Message-ID: <5374927.lpgzSJ47Sk@wuerfel>
In-Reply-To: <1429077843-184462-2-git-send-email-wangzhou1@hisilicon.com>
References: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com> <1429077843-184462-2-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 15 April 2015 14:04:01 Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Please provide a changelog with every patch you do

> ---
>  drivers/pci/host/pcie-designware.c | 44 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 17ca986..e88a7d9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -31,6 +32,7 @@
>  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
>  #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
>  #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> +#define PORT_LINK_MODE_8_LANES		(0xf << 16)
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
>
> @@ -38,6 +40,7 @@
>  #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
>  #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
> +#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
>  
>  #define PCIE_MSI_ADDR_LO		0x820
>  #define PCIE_MSI_ADDR_HI		0x824

This seems unrelated to arm64 support, so put that in a separate patch


> @@ -68,14 +71,19 @@
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
>  static struct hw_pci dw_pci;
> +static struct pci_ops dw_pcie_ops;
>  
>  static unsigned long global_io_offset;
>  
> -static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
> +static inline struct pcie_port *sys_to_pcie(void *sys)
>  {
> -	BUG_ON(!sys->private_data);
> +#ifdef CONFIG_ARM
> +	pci_sys_data *sys_data = (struct pci_sys_data *)sys;
>  
> -	return sys->private_data;
> +	BUG_ON(!sys->private_data);
> +	return sys_data->private_data;
> +#endif
> +	return (struct pcie_port *)sys;
>  }
>  
>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)

Yes, I guess this is the best workaround for now, and we should be able to
drop that arm32 specific section soon.

> @@ -502,6 +510,27 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  
> +#ifdef CONFIG_ARM64
> +	struct pci_bus *bus;
> +	LIST_HEAD(res);
> +
> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> +	if (ret)
> +		return ret;
> +
> +	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> +				  pp, &res);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
> +
> +	pci_scan_child_bus(bus);
> +	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_add_devices(bus);
> +#endif
> +
> +#ifdef CONFIG_ARM
>  #ifdef CONFIG_PCI_MSI
>  	dw_pcie_msi_chip.dev = pp->dev;
>  	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> @@ -514,6 +543,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  #ifdef CONFIG_PCI_DOMAINS
>  	dw_pci.domain++;
>  #endif
> +#endif
>  

I think here we should move everything to the new model and do it the
same way on ARM, except for setting the sysdata pointer.

> @@ -704,6 +734,7 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = dw_pcie_wr_conf,
>  };
>  
> +#ifdef CONFIG_ARM
>  static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>  {
>  	struct pcie_port *pp;
> @@ -761,6 +792,7 @@ static struct hw_pci dw_pci = {
>  	.scan		= dw_pcie_scan_bus,
>  	.map_irq	= dw_pcie_map_irq,
>  };
> +#endif
>  
>  void dw_pcie_setup_rc(struct pcie_port *pp)

Same here, just remove the dw_pcie_setup function and dw_pci structure
and use the arm64 implementation.

> @@ -781,6 +813,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	case 4:
>  		val |= PORT_LINK_MODE_4_LANES;
>  		break;
> +	case 8:
> +		val |= PORT_LINK_MODE_8_LANES;
> +		break;
>  	}
>  	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
>  
> @@ -797,6 +832,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	case 4:
>  		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>  		break;
> +	case 8:
> +		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> +		break;
>  	}
>  	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);

Again, separate patch.

I've just tried to come up with a nicer way of doing all this, can
you try the experimental patch below?

	Arnd

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2e9f84fdd9ce..4ef2ca8e3404 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -67,7 +67,7 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
-static struct hw_pci dw_pci;
+static struct pci_ops dw_pcie_ops;
 
 static unsigned long global_io_offset;
 
@@ -238,7 +238,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
 	int irq, pos0, i;
-	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
+	struct pcie_port *pp = desc->dev->bus->sysdata;
 
 	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
 				       order_base_2(no_irqs));
@@ -281,7 +281,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 {
 	int irq, pos;
 	struct msi_msg msg;
-	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+	struct pcie_port *pp = pdev->bus->sysdata;
 
 	if (desc->msi_attrib.is_msix)
 		return -EINVAL;
@@ -310,7 +310,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct msi_desc *msi = irq_data_get_msi(data);
-	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
+	struct pcie_port *pp = msi->dev->bus->sysdata;
 
 	clear_irq_range(pp, irq, 1, data->hwirq);
 }
@@ -348,7 +348,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(pp->dev);
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
+	struct pci_bus *bus;
 	struct resource *cfg_res;
+	LIST_HEAD(res);
 	u32 val, na, ns;
 	const __be32 *addrp;
 	int i, index, ret;
@@ -502,15 +504,42 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 
-#ifdef CONFIG_PCI_MSI
-	dw_pcie_msi_chip.dev = pp->dev;
-	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
-#endif
+#ifdef CONFIG_ARM
+	/* FIXME: we should really be able to use
+	 * of_pci_get_host_bridge_resources on arm32 as well,
+	 * but the conversion needs some more testing */
+	if (global_io_offset < SZ_1M && pp->io_size > 0) {
+		sys->io_offset = global_io_offset - pp->io_bus_addr;
+		pci_ioremap_io(global_io_offset, pp->io_base);
+		global_io_offset += SZ_64K;
+		pci_add_resource_offset(&sys->resources, &pp->io,
+					sys->io_offset);
+	}
+
+	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
+	pci_add_resource_offset(&res, &pp->mem, sys->mem_offset);
+	pci_add_resource(&res, &pp->busn);
+#else
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
+	if (ret)
+		return ret;
+#endif	
+	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
+				  pp, &res);
+	if (!bus)
+		return -ENOMEM;
+
+	/* support old dtbs that incorrectly describe IRQs */
+	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
+
+	bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
 
-	dw_pci.nr_controllers = 1;
-	dw_pci.private_data = (void **)&pp;
+	pci_scan_child_bus(bus);
+	if (pp->ops->scan_bus)
+		pp->ops->scan_bus(pp);
 
-	pci_common_init_dev(pp->dev, &dw_pci);
+	pci_assign_unassigned_bus_resources(bus);
+	pci_bus_add_devices(bus);
 
 	return 0;
 }
@@ -653,7 +682,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
 static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
-	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
 	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
@@ -677,7 +706,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 			int where, int size, u32 val)
 {
-	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
 	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
@@ -701,64 +730,6 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
-{
-	struct pcie_port *pp;
-
-	pp = sys_to_pcie(sys);
-
-	if (global_io_offset < SZ_1M && pp->io_size > 0) {
-		sys->io_offset = global_io_offset - pp->io_bus_addr;
-		pci_ioremap_io(global_io_offset, pp->io_base);
-		global_io_offset += SZ_64K;
-		pci_add_resource_offset(&sys->resources, &pp->io,
-					sys->io_offset);
-	}
-
-	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
-	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
-	pci_add_resource(&sys->resources, &pp->busn);
-
-	return 1;
-}
-
-static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct pci_bus *bus;
-	struct pcie_port *pp = sys_to_pcie(sys);
-
-	pp->root_bus_nr = sys->busnr;
-	bus = pci_create_root_bus(pp->dev, sys->busnr,
-				  &dw_pcie_ops, sys, &sys->resources);
-	if (!bus)
-		return NULL;
-
-	pci_scan_child_bus(bus);
-
-	if (bus && pp->ops->scan_bus)
-		pp->ops->scan_bus(pp);
-
-	return bus;
-}
-
-static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
-	int irq;
-
-	irq = of_irq_parse_and_map_pci(dev, slot, pin);
-	if (!irq)
-		irq = pp->irq;
-
-	return irq;
-}
-
-static struct hw_pci dw_pci = {
-	.setup		= dw_pcie_setup,
-	.scan		= dw_pcie_scan_bus,
-	.map_irq	= dw_pcie_map_irq,
-};
-
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd276840d..be7e4b72fbfc 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -23,6 +23,15 @@
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
 struct pcie_port {
+#ifdef CONFIG_ARM
+	/*
+	 * this is a temporary hack to let the driver work on
+	 * both arm32 and arm64. it can be removed after the
+	 * arm32 cleanup is complete and bios32.c has stopped
+	 * referencing host->pci_sys_data.
+	 */
+	struct pci_sys_data	dummy;
+#endif
 	struct device		*dev;
 	u8			root_bus_nr;
 	void __iomem		*dbi_base;

