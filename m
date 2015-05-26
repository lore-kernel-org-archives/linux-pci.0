Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:37921 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEZCFW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2015 22:05:22 -0400
Message-ID: <5563D4C4.2030706@hisilicon.com>
Date: Tue, 26 May 2015 10:04:52 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Jingoo Han <jingoohan1@gmail.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	"'Liviu Dudau'" <liviu.dudau@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	"'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>,
	"'Zhichang Yuan'" <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, "'Zhang Jukuo'" <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, "'Liguozhu'" <liguozhu@hisilicon.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Richard Zhu'" <Richard.Zhu@freescale.com>,
	"'Lucas Stach'" <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
References: <000001d096a9$27bf43f0$773dcbd0$@com> <5562F0C9.4090007@hisilicon.com> <000001d096f1$93dca4e0$bb95eea0$@com>
In-Reply-To: <000001d096f1$93dca4e0$bb95eea0$@com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/25 21:48, Jingoo Han wrote:
> On Monday, May 25, 2015 6:52 PM, Zhou Wang wrote:
>> On 2015/5/25 13:10, Jingoo Han wrote:
>>> On Wed, 20 May 2015 14:21:39 +0800, Zhou Wang wrote:
>>>>
>>>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
>>>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
>>>> move related operations to dw_pcie_host_init.
>>>>
>>>> I am not very clear about I/O resource management:
>>>>> 	if (global_io_offset < SZ_1M && pp->io_size > 0) {
>>>>> 		pci_ioremap_io(global_io_offset, pp->io_base);
>>>>> 		global_io_offset += SZ_64K;
>>>>> 		pci_add_resource_offset(&res, &pp->io,
>>>>> 					global_io_offset - pp->io_bus_addr);
>>>>> 	}
>>>> so just move steps in dw_pcie_setup to dw_pcie_host_init.
>>>>
>>>> I have compiled the driver with multi_v7_defconfig. However, I don't have
>>>> ARM32 PCIe related board to do test. It will be appreciated if someone could
>>>> help to test it.
>>>>
>>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>>> ---
>>>>  drivers/pci/host/pcie-designware.c | 128 +++++++++++++++----------------------
>>>>  1 file changed, 50 insertions(+), 78 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>>>> index 2e9f84f..7bad9e5 100644
>>>> --- a/drivers/pci/host/pcie-designware.c
>>>> +++ b/drivers/pci/host/pcie-designware.c
>>>> @@ -22,6 +22,7 @@
>>>>  #include <linux/pci_regs.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/types.h>
>>>> +#include <asm/hardirq.h>
>>>
>>> +cc Kishon Vijay Abraham I, Richard Zhu, Lucas Stach
>>>
>>
>> Thanks to involve more related guys to this discussion :)
>>
>>> Please use <linux/hardirq.h> and insert it alphabetically.
>>>
>>> +#include <linux/hardirq.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/irqdomain.h>
>>>  #include <linux/kernel.h>
>>>
>>
>> OK, will do in next version patch.
>>
>>>>
>>>>  #include "pcie-designware.h"
>>>>
>>>> @@ -67,17 +68,10 @@
>>>>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>>>>  #define PCIE_ATU_UPPER_TARGET		0x91C
>>>>
>>>> -static struct hw_pci dw_pci;
>>>> +static struct pci_ops dw_pcie_ops;
>>>>
>>>>  static unsigned long global_io_offset;
>>>>
>>>> -static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>>>> -{
>>>> -	BUG_ON(!sys->private_data);
>>>> -
>>>> -	return sys->private_data;
>>>> -}
>>>> -
>>>>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>>>>  {
>>>>  	*val = readl(addr);
>>>> @@ -238,7 +232,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
>>>>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>>>>  {
>>>>  	int irq, pos0, i;
>>>> -	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
>>>> +	struct pcie_port *pp = desc->dev->bus->sysdata;
>>>>
>>>>  	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>>>>  				       order_base_2(no_irqs));
>>>> @@ -281,7 +275,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>>>>  {
>>>>  	int irq, pos;
>>>>  	struct msi_msg msg;
>>>> -	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
>>>> +	struct pcie_port *pp = pdev->bus->sysdata;
>>>>
>>>>  	if (desc->msi_attrib.is_msix)
>>>>  		return -EINVAL;
>>>> @@ -310,7 +304,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>>>>  {
>>>>  	struct irq_data *data = irq_get_irq_data(irq);
>>>>  	struct msi_desc *msi = irq_data_get_msi(data);
>>>> -	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
>>>> +	struct pcie_port *pp = msi->dev->bus->sysdata;
>>>>
>>>>  	clear_irq_range(pp, irq, 1, data->hwirq);
>>>>  }
>>>> @@ -342,13 +336,15 @@ static const struct irq_domain_ops msi_domain_ops = {
>>>>  	.map = dw_pcie_msi_map,
>>>>  };
>>>>
>>>> -int dw_pcie_host_init(struct pcie_port *pp)
>>>> +int __init dw_pcie_host_init(struct pcie_port *pp)
>>>>  {
>>>>  	struct device_node *np = pp->dev->of_node;
>>>>  	struct platform_device *pdev = to_platform_device(pp->dev);
>>>>  	struct of_pci_range range;
>>>>  	struct of_pci_range_parser parser;
>>>> +	struct pci_bus *bus;
>>>>  	struct resource *cfg_res;
>>>> +	LIST_HEAD(res);
>>>>  	u32 val, na, ns;
>>>>  	const __be32 *addrp;
>>>>  	int i, index, ret;
>>>> @@ -502,15 +498,49 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>>>  	val |= PORT_LOGIC_SPEED_CHANGE;
>>>>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>>>>
>>>> -#ifdef CONFIG_PCI_MSI
>>>> -	dw_pcie_msi_chip.dev = pp->dev;
>>>> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
>>>> +#ifdef CONFIG_ARM
>>>> +	/*
>>>> +	 * FIXME: we should really be able to use
>>>> +	 * of_pci_get_host_bridge_resources on arm32 as well,
>>>> +	 * but the conversion needs some more testing
>>>> +	 */
>>>> +	if (global_io_offset < SZ_1M && pp->io_size > 0) {
>>>> +		pci_ioremap_io(global_io_offset, pp->io_base);
>>>> +		global_io_offset += SZ_64K;
>>>> +		pci_add_resource_offset(&res, &pp->io,
>>>> +					global_io_offset - pp->io_bus_addr);
>>>> +	}
>>>> +	pci_add_resource_offset(&res, &pp->mem,
>>>> +				pp->mem.start - pp->mem_bus_addr);
>>>> +	pci_add_resource(&res, &pp->busn);
>>>> +#else
>>>> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +#endif
>>>> +
>>>> +	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
>>>> +			      pp, &res);
>>>> +	if (!bus)
>>>> +		return -ENOMEM;
>>>> +
>>>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>>>> +	bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
>>>> +#else
>>>> +	bus->msi = &dw_pcie_msi_chip;
>>>>  #endif
>>>>
>>>> -	dw_pci.nr_controllers = 1;
>>>> -	dw_pci.private_data = (void **)&pp;
>>>> +	pci_scan_child_bus(bus);
>>>> +	if (pp->ops->scan_bus)
>>>> +		pp->ops->scan_bus(pp);
>>>>
>>>> -	pci_common_init_dev(pp->dev, &dw_pci);
>>>> +#ifdef CONFIG_ARM
>>>> +	/* support old dtbs that incorrectly describe IRQs */
>>>> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>>>> +#endif
>>>> +
>>>> +	pci_assign_unassigned_bus_resources(bus);
>>>> +	pci_bus_add_devices(bus);
>>>>
>>>>  	return 0;
>>>>  }
>>>> @@ -653,7 +683,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>>>>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>>>>  			int size, u32 *val)
>>>>  {
>>>> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
>>>> +	struct pcie_port *pp = bus->sysdata;
>>>>  	int ret;
>>>>
>>>>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
>>>> @@ -677,7 +707,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>>>>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>>>>  			int where, int size, u32 val)
>>>>  {
>>>> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
>>>> +	struct pcie_port *pp = bus->sysdata;
>>>>  	int ret;
>>>>
>>>>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
>>>> @@ -701,64 +731,6 @@ static struct pci_ops dw_pcie_ops = {
>>>>  	.write = dw_pcie_wr_conf,
>>>>  };
>>>>
>>>> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>>>> -{
>>>> -	struct pcie_port *pp;
>>>> -
>>>> -	pp = sys_to_pcie(sys);
>>>> -
>>>> -	if (global_io_offset < SZ_1M && pp->io_size > 0) {
>>>> -		sys->io_offset = global_io_offset - pp->io_bus_addr;
>>>> -		pci_ioremap_io(global_io_offset, pp->io_base);
>>>> -		global_io_offset += SZ_64K;
>>>> -		pci_add_resource_offset(&sys->resources, &pp->io,
>>>> -					sys->io_offset);
>>>> -	}
>>>> -
>>>> -	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
>>>> -	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
>>>> -	pci_add_resource(&sys->resources, &pp->busn);
>>>> -
>>>> -	return 1;
>>>> -}
>>>> -
>>>> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>>>> -{
>>>> -	struct pci_bus *bus;
>>>> -	struct pcie_port *pp = sys_to_pcie(sys);
>>>> -
>>>> -	pp->root_bus_nr = sys->busnr;
>>>
>>> 'pp->root_bus_nr' is initialized as '-1' at some soc-specific drivers
>>> However, 'sys->busnr' is set as '0, 1, 2 ...' by pcibios_init_hw()
>>> in arch/arm/kernel/bios32.c. '0, 1, 2 ...' means the number of
>>> each host controller.
>>>
>>> So, without setting 'pp->root_bus_nr' as '0, 1, 2, ...',
>>> it makes the problem.
>>>
>>
>> 'sys->busnr' is set as "0, busn_res.end + 1 ..." in pcibios_init_hw() I think:
>>
>> pcibios_init_hw()
>> 	for (nr = busnr = 0; nr < hw->nr_controllers; nr++)
>> 		sys->busnr = busnr;
>> 		...
>> 		busnr = sys->bus->busn_res.end + 1;
>>
>> and it indicates root bus number of one pcie controller.
>> so in dw_pcie_scan_bus:
>> 	pp->root_bus_nr = sys->busnr;
>> 	bus = pci_create_root_bus(..., sys->busnr, ...);
> 
> Oh, you're right. Sorry for my mistake.
> 
>> we set root bus number as "0, busn_res.end + 1". But in pcie-designware,
>> nr_controllers is set as 1, so it only comes into the loop in
>> pcibios_init_hw() one time.
> 
> Right, 'nr_controllers' is set as just '1', even though more than
> 2 controllers are used.
> 
>>
>> so how about we set 0 as default value of pp->root_bus_nr, then use
>> pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops, pp, &res);
>> to create root bus?
> 
> I agree with your opinion. However, I still want to wait for other
> people's opinions. They will give good comments.
> Thank you.
> 
> Best regards,
> Jingoo Han
>

Right, the more comments, the better the driver will be.
Thanks for your reviewing.

Best regards,
Zhou

>>
>>> Thus, we need to come up with the way to resolve this.
>>>
>>> 1. Setting 'pp->root_bus_nr' as '0, 1, 2 ..' by each soc-specific driver.
>>>
>>> e.g)
>>>
>>> ./drivers/pci/host/pci-exynos.c
>>> @@ -534,7 +534,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
>>>                 }
>>>         }
>>>
>>> -       pp->root_bus_nr = -1;
>>> +       pp->root_bus_nr++;
>>>         pp->ops = &exynos_pcie_host_ops;
>>>
>>> ./drivers/pci/host/pci-imx6.c
>>> @@ -541,7 +541,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>>>                 }
>>>         }
>>>
>>> -       pp->root_bus_nr = -1;
>>> +       pp->root_bus_nr++;
>>>         pp->ops = &imx6_pcie_host_ops;
>>>
>>> ./drivers/pci/host/pci-keystone.c
>>> @@ -312,7 +312,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>>>                         return ret;
>>>         }
>>>
>>> -       pp->root_bus_nr = -1;
>>> +       pp->root_bus_nr++;
>>>         pp->ops = &keystone_pcie_host_ops;
>>>
>>> ./drivers/pci/host/pci-layerscape.c
>>> @@ -101,7 +101,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
>>>         pp = &pcie->pp;
>>>         pp->dev = pcie->dev;
>>>         pp->dbi_base = pcie->dbi;
>>> -       pp->root_bus_nr = -1;
>>> +       pp->root_bus_nr++;
>>>         pp->ops = &ls_pcie_host_ops;
>>>
>>> ./drivers/pci/host/pcie-spear13xx.c
>>> @@ -287,7 +287,7 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
>>>                 return ret;
>>>         }
>>>
>>> -       pp->root_bus_nr = -1;
>>> +       pp->root_bus_nr++;
>>>         pp->ops = &spear13xx_pcie_host_ops;
>>>
>>>
>>> 2. Setting 'pp->root_bus_nr' as '0, 1, 2 ..' by pcie-designware.c
>>>
>>> I believe that someone will give better idea. :-)
>>>
>>>> -	bus = pci_create_root_bus(pp->dev, sys->busnr,
>>>> -				  &dw_pcie_ops, sys, &sys->resources);
>>>> -	if (!bus)
>>>> -		return NULL;
>>>> -
>>>> -	pci_scan_child_bus(bus);
>>>> -
>>>> -	if (bus && pp->ops->scan_bus)
>>>> -		pp->ops->scan_bus(pp);
>>>> -
>>>> -	return bus;
>>>> -}
>>>> -
>>>> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>>>> -{
>>>> -	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
>>>> -	int irq;
>>>> -
>>>> -	irq = of_irq_parse_and_map_pci(dev, slot, pin);
>>>> -	if (!irq)
>>>> -		irq = pp->irq;
>>>> -
>>>> -	return irq;
>>>> -}
>>>> -
>>>> -static struct hw_pci dw_pci = {
>>>> -	.setup		= dw_pcie_setup,
>>>> -	.scan		= dw_pcie_scan_bus,
>>>> -	.map_irq	= dw_pcie_map_irq,
>>>> -};
>>>
>>> Right, 'struct hw_pci' should not be used in order to unify ARM32 and
>>> ARM64. I have no objection to remove 'struct hw_pci' from 'pcie-designware.c'.
>>> Thank you for your patch.
>>>
>>> Best regards,
>>> Jingoo Han
>>>
>>
>> Many thanks for your reviewing!
>> Zhou Wang
>>
>>>> -
>>>>  void dw_pcie_setup_rc(struct pcie_port *pp)
>>>>  {
>>>>  	u32 val;
>>>> --
>>>> 1.9.1
> 
> 
> .
> 


