Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:10946 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbEYBfQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 24 May 2015 21:35:16 -0400
Message-ID: <55627BFD.1090602@hisilicon.com>
Date: Mon, 25 May 2015 09:33:49 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Zhou Wang <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liguozhu@hisilicon.com>
Subject: Re: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
References: <1432102901-186201-1-git-send-email-wangzhou1@hisilicon.com> <1432102901-186201-2-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1432102901-186201-2-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo and Hi Pratyush,

Do you have any comments about this patch? It will be very appreciated if I
could get some help for you.

Best Regards,
Zhou

On 2015/5/20 14:21, Zhou Wang wrote:
> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
> move related operations to dw_pcie_host_init.
> 
> I am not very clear about I/O resource management:
>> 	if (global_io_offset < SZ_1M && pp->io_size > 0) {
>> 		pci_ioremap_io(global_io_offset, pp->io_base);
>> 		global_io_offset += SZ_64K;
>> 		pci_add_resource_offset(&res, &pp->io,
>> 					global_io_offset - pp->io_bus_addr);
>> 	}
> so just move steps in dw_pcie_setup to dw_pcie_host_init.
> 
> I have compiled the driver with multi_v7_defconfig. However, I don't have
> ARM32 PCIe related board to do test. It will be appreciated if someone could
> help to test it.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/pci/host/pcie-designware.c | 128 +++++++++++++++----------------------
>  1 file changed, 50 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2e9f84f..7bad9e5 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <asm/hardirq.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -67,17 +68,10 @@
>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
> -static struct hw_pci dw_pci;
> +static struct pci_ops dw_pcie_ops;
>  
>  static unsigned long global_io_offset;
>  
> -static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
> -{
> -	BUG_ON(!sys->private_data);
> -
> -	return sys->private_data;
> -}
> -
>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
>  	*val = readl(addr);
> @@ -238,7 +232,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>  {
>  	int irq, pos0, i;
> -	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
> +	struct pcie_port *pp = desc->dev->bus->sysdata;
>  
>  	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>  				       order_base_2(no_irqs));
> @@ -281,7 +275,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>  {
>  	int irq, pos;
>  	struct msi_msg msg;
> -	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> +	struct pcie_port *pp = pdev->bus->sysdata;
>  
>  	if (desc->msi_attrib.is_msix)
>  		return -EINVAL;
> @@ -310,7 +304,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>  {
>  	struct irq_data *data = irq_get_irq_data(irq);
>  	struct msi_desc *msi = irq_data_get_msi(data);
> -	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
> +	struct pcie_port *pp = msi->dev->bus->sysdata;
>  
>  	clear_irq_range(pp, irq, 1, data->hwirq);
>  }
> @@ -342,13 +336,15 @@ static const struct irq_domain_ops msi_domain_ops = {
>  	.map = dw_pcie_msi_map,
>  };
>  
> -int dw_pcie_host_init(struct pcie_port *pp)
> +int __init dw_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct device_node *np = pp->dev->of_node;
>  	struct platform_device *pdev = to_platform_device(pp->dev);
>  	struct of_pci_range range;
>  	struct of_pci_range_parser parser;
> +	struct pci_bus *bus;
>  	struct resource *cfg_res;
> +	LIST_HEAD(res);
>  	u32 val, na, ns;
>  	const __be32 *addrp;
>  	int i, index, ret;
> @@ -502,15 +498,49 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  
> -#ifdef CONFIG_PCI_MSI
> -	dw_pcie_msi_chip.dev = pp->dev;
> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> +#ifdef CONFIG_ARM
> +	/*
> +	 * FIXME: we should really be able to use
> +	 * of_pci_get_host_bridge_resources on arm32 as well,
> +	 * but the conversion needs some more testing
> +	 */
> +	if (global_io_offset < SZ_1M && pp->io_size > 0) {
> +		pci_ioremap_io(global_io_offset, pp->io_base);
> +		global_io_offset += SZ_64K;
> +		pci_add_resource_offset(&res, &pp->io,
> +					global_io_offset - pp->io_bus_addr);
> +	}
> +	pci_add_resource_offset(&res, &pp->mem,
> +				pp->mem.start - pp->mem_bus_addr);
> +	pci_add_resource(&res, &pp->busn);
> +#else
> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> +	if (ret)
> +		return ret;
> +#endif
> +
> +	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> +			      pp, &res);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +	bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
> +#else
> +	bus->msi = &dw_pcie_msi_chip;
>  #endif
>  
> -	dw_pci.nr_controllers = 1;
> -	dw_pci.private_data = (void **)&pp;
> +	pci_scan_child_bus(bus);
> +	if (pp->ops->scan_bus)
> +		pp->ops->scan_bus(pp);
>  
> -	pci_common_init_dev(pp->dev, &dw_pci);
> +#ifdef CONFIG_ARM
> +	/* support old dtbs that incorrectly describe IRQs */
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
> +
> +	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_add_devices(bus);
>  
>  	return 0;
>  }
> @@ -653,7 +683,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  			int size, u32 *val)
>  {
> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> +	struct pcie_port *pp = bus->sysdata;
>  	int ret;
>  
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> @@ -677,7 +707,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  			int where, int size, u32 val)
>  {
> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> +	struct pcie_port *pp = bus->sysdata;
>  	int ret;
>  
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> @@ -701,64 +731,6 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = dw_pcie_wr_conf,
>  };
>  
> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> -{
> -	struct pcie_port *pp;
> -
> -	pp = sys_to_pcie(sys);
> -
> -	if (global_io_offset < SZ_1M && pp->io_size > 0) {
> -		sys->io_offset = global_io_offset - pp->io_bus_addr;
> -		pci_ioremap_io(global_io_offset, pp->io_base);
> -		global_io_offset += SZ_64K;
> -		pci_add_resource_offset(&sys->resources, &pp->io,
> -					sys->io_offset);
> -	}
> -
> -	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> -	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> -	pci_add_resource(&sys->resources, &pp->busn);
> -
> -	return 1;
> -}
> -
> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> -{
> -	struct pci_bus *bus;
> -	struct pcie_port *pp = sys_to_pcie(sys);
> -
> -	pp->root_bus_nr = sys->busnr;
> -	bus = pci_create_root_bus(pp->dev, sys->busnr,
> -				  &dw_pcie_ops, sys, &sys->resources);
> -	if (!bus)
> -		return NULL;
> -
> -	pci_scan_child_bus(bus);
> -
> -	if (bus && pp->ops->scan_bus)
> -		pp->ops->scan_bus(pp);
> -
> -	return bus;
> -}
> -
> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> -	int irq;
> -
> -	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> -	if (!irq)
> -		irq = pp->irq;
> -
> -	return irq;
> -}
> -
> -static struct hw_pci dw_pci = {
> -	.setup		= dw_pcie_setup,
> -	.scan		= dw_pcie_scan_bus,
> -	.map_irq	= dw_pcie_map_irq,
> -};
> -
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
> 


