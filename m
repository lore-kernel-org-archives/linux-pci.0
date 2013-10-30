Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:41498 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3J3KDd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 06:03:33 -0400
Received: by mail-la0-f49.google.com with SMTP id eh20so863679lab.22
        for <linux-pci@vger.kernel.org>; Wed, 30 Oct 2013 03:03:32 -0700 (PDT)
Message-ID: <5270D971.2010406@cogentembedded.com>
Date: Wed, 30 Oct 2013 14:03:29 +0400
From: Valentine <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] pci: Add R-Car Gen2 internal PCI support
References: <1383063171-3144-1-git-send-email-valentine.barshak@cogentembedded.com> <20131029224450.GC15159@google.com>
In-Reply-To: <20131029224450.GC15159@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/30/2013 02:44 AM, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2013 at 08:12:51PM +0400, Valentine Barshak wrote:
>> This adds internal PCI controller driver for R-Car Gen2 SoC.
>> There are three PCI controllers available with only a single
>> EHCI/OHCI device built-in on each PCI bus.
>> This gives us three USB channels. Channel 0 is shared with
>> the USBHS device, while channel 2 is shared with the USBSS.
>>
>> The PCI controllers do not support I/O port space mapping,
>> and it is not needed here.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   drivers/pci/host/Kconfig         |   8 +
>>   drivers/pci/host/Makefile        |   1 +
>>   drivers/pci/host/pci-rcar-gen2.c | 333 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 342 insertions(+)
>>   create mode 100644 drivers/pci/host/pci-rcar-gen2.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 3d95048..2e33c2b 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -19,4 +19,12 @@ config PCI_TEGRA
>>   	bool "NVIDIA Tegra PCIe controller"
>>   	depends on ARCH_TEGRA
>>
>> +config PCI_RCAR_GEN2
>> +	bool "Renesas R-Car Gen2 Internal PCI controller"
>> +	depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)
>> +	help
>> +	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
>> +	  There are 3 internal PCI controllers available with a single
>> +	  built-in EHCI/OHCI host controller present on each one.
>> +
>>   endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index c9a997b..63d9727 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -2,3 +2,4 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>   obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>   obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>>   obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
>> +obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
>> new file mode 100644
>> index 0000000..cbaa5c4
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>> @@ -0,0 +1,333 @@
>> +/*
>> + *  pci-rcar-gen2: internal PCI bus support
>> + *
>> + * Copyright (C) 2013 Renesas Solutions Corp.
>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +/* AHB-PCI Bridge PCI communication registers */
>> +#define RCAR_AHBPCI_PCICOM_OFFSET	0x800
>> +
>> +#define RCAR_PCIAHB_WIN1_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x00)
>> +#define RCAR_PCIAHB_WIN2_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x04)
>> +#define RCAR_PCIAHB_PREFETCH0		0x0
>> +#define RCAR_PCIAHB_PREFETCH4		0x1
>> +#define RCAR_PCIAHB_PREFETCH8		0x2
>> +#define RCAR_PCIAHB_PREFETCH16		0x3
>> +
>> +#define RCAR_AHBPCI_WIN1_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x10)
>> +#define RCAR_AHBPCI_WIN2_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x14)
>> +#define RCAR_AHBPCI_WIN_CTR_MEM		(3 << 1)
>> +#define RCAR_AHBPCI_WIN_CTR_CFG		(5 << 1)
>> +#define RCAR_AHBPCI_WIN1_HOST		(1 << 30)
>> +#define RCAR_AHBPCI_WIN1_DEVICE		(1 << 31)
>> +
>> +#define RCAR_PCI_INT_ENABLE_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x20)
>> +#define RCAR_PCI_INT_STATUS_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x24)
>> +#define RCAR_PCI_INT_A			(1 << 16)
>> +#define RCAR_PCI_INT_B			(1 << 17)
>> +#define RCAR_PCI_INT_PME		(1 << 19)
>> +
>> +#define RCAR_AHB_BUS_CTR_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x30)
>> +#define RCAR_AHB_BUS_MMODE_HTRANS	(1 << 0)
>> +#define RCAR_AHB_BUS_MMODE_BYTE_BURST	(1 << 1)
>> +#define RCAR_AHB_BUS_MMODE_WR_INCR	(1 << 2)
>> +#define RCAR_AHB_BUS_MMODE_HBUS_REQ	(1 << 7)
>> +#define RCAR_AHB_BUS_SMODE_READYCTR	(1 << 17)
>> +#define RCAR_AHB_BUS_MODE		(RCAR_AHB_BUS_MMODE_HTRANS |	\
>> +					RCAR_AHB_BUS_MMODE_BYTE_BURST |	\
>> +					RCAR_AHB_BUS_MMODE_WR_INCR |	\
>> +					RCAR_AHB_BUS_MMODE_HBUS_REQ |	\
>> +					RCAR_AHB_BUS_SMODE_READYCTR)
>> +
>> +#define RCAR_USBCTR_REG			(RCAR_AHBPCI_PCICOM_OFFSET + 0x34)
>> +#define RCAR_USBCTR_USBH_RST		(1 << 0)
>> +#define RCAR_USBCTR_PCICLK_MASK		(1 << 1)
>> +#define RCAR_USBCTR_PLL_RST		(1 << 2)
>> +#define RCAR_USBCTR_DIRPD		(1 << 8)
>> +#define RCAR_USBCTR_PCIAHB_WIN2_EN	(1 << 9)
>> +#define RCAR_USBCTR_PCIAHB_WIN1_256M	(0 << 10)
>> +#define RCAR_USBCTR_PCIAHB_WIN1_512M	(1 << 10)
>> +#define RCAR_USBCTR_PCIAHB_WIN1_1G	(2 << 10)
>> +#define RCAR_USBCTR_PCIAHB_WIN1_2G	(3 << 10)
>> +#define RCAR_USBCTR_PCIAHB_WIN1_MASK	(3 << 10)
>> +
>> +#define RCAR_PCI_ARBITER_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x40)
>> +#define RCAR_PCI_ARBITER_PCIREQ0	(1 << 0)
>> +#define RCAR_PCI_ARBITER_PCIREQ1	(1 << 1)
>> +#define RCAR_PCI_ARBITER_PCIBP_MODE	(1 << 12)
>> +
>> +#define RCAR_PCI_UNIT_REV_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x48)
>> +
>> +/* Number of internal PCI controllers */
>> +#define RCAR_PCI_NR_CONTROLLERS		3
>> +
>> +struct rcar_pci_priv {
>> +	void __iomem *reg;
>> +	struct resource io_res;
>> +	struct resource mem_res;
>> +	struct resource *cfg_res;
>> +	int irq;
>> +};
>> +
>> +/* PCI configuration space operations */
>> +static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
>> +				       int where)
>> +{
>> +	struct pci_sys_data *sys = bus->sysdata;
>> +	struct rcar_pci_priv *priv = sys->private_data;
>> +	int slot, val;
>> +
>> +	if (sys->busnr != bus->number || PCI_FUNC(devfn))
>> +		return NULL;
>> +
>> +	/* Only one EHCI/OHCI device built-in */
>> +	slot = PCI_SLOT(devfn);
>> +	if (slot > 2)
>> +		return NULL;
>> +
>> +	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
>> +		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
>> +
>> +	iowrite32(val, priv->reg + RCAR_AHBPCI_WIN1_CTR_REG);
>> +	return priv->reg + (slot >> 1) * 0x100 + where;
>> +}
>> +
>> +static int rcar_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>> +				int where, int size, u32 *val)
>> +{
>> +	void __iomem *reg = rcar_pci_cfg_base(bus, devfn, where);
>> +
>> +	if (!reg)
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +	switch (size) {
>> +	case 1:
>> +		*val = ioread8(reg);
>> +		break;
>> +	case 2:
>> +		*val = ioread16(reg);
>> +		break;
>> +	default:
>> +		*val = ioread32(reg);
>> +		break;
>> +	}
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int rcar_pci_write_config(struct pci_bus *bus, unsigned int devfn,
>> +				 int where, int size, u32 val)
>> +{
>> +	void __iomem *reg = rcar_pci_cfg_base(bus, devfn, where);
>> +
>> +	if (!reg)
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +	switch (size) {
>> +	case 1:
>> +		iowrite8(val, reg);
>> +		break;
>> +	case 2:
>> +		iowrite16(val, reg);
>> +		break;
>> +	default:
>> +		iowrite32(val, reg);
>> +		break;
>> +	}
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +/* PCI interrupt mapping */
>> +static int __init rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>> +{
>> +	struct pci_sys_data *sys = dev->bus->sysdata;
>> +	struct rcar_pci_priv *priv = sys->private_data;
>> +
>> +	return priv->irq;
>> +}
>> +
>> +/* PCI host controller setup */
>> +static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
>> +{
>> +	struct rcar_pci_priv *priv = sys->private_data;
>> +	void __iomem *reg = priv->reg;
>> +	u32 val;
>> +
>> +	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
>> +	pr_info("PCI: bus%u revision %x\n", sys->busnr, val);
>> +
>> +	/* Disable Direct Power Down State and assert reset */
>> +	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
>> +	val |= RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST;
>> +	iowrite32(val, reg + RCAR_USBCTR_REG);
>> +	udelay(4);
>> +
>> +	/* De-assert reset and set PCIAHB window1 size to 1GB */
>> +	val &= ~(RCAR_USBCTR_PCIAHB_WIN1_MASK | RCAR_USBCTR_PCICLK_MASK |
>> +		 RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST);
>> +	iowrite32(val | RCAR_USBCTR_PCIAHB_WIN1_1G, reg + RCAR_USBCTR_REG);
>> +
>> +	/* Configure AHB master and slave modes */
>> +	iowrite32(RCAR_AHB_BUS_MODE, reg + RCAR_AHB_BUS_CTR_REG);
>> +
>> +	/* Configure PCI arbiter */
>> +	val = ioread32(reg + RCAR_PCI_ARBITER_CTR_REG);
>> +	val |= RCAR_PCI_ARBITER_PCIREQ0 | RCAR_PCI_ARBITER_PCIREQ1 |
>> +	       RCAR_PCI_ARBITER_PCIBP_MODE;
>> +	iowrite32(val, reg + RCAR_PCI_ARBITER_CTR_REG);
>> +
>> +	/* PCI-AHB mapping: 0x40000000-0x80000000 */
>> +	iowrite32(0x40000000 | RCAR_PCIAHB_PREFETCH16,
>> +		  reg + RCAR_PCIAHB_WIN1_CTR_REG);
>> +
>> +	/* AHB-PCI mapping: OHCI/EHCI registers */
>> +	val = priv->mem_res.start | RCAR_AHBPCI_WIN_CTR_MEM;
>> +	iowrite32(val, reg + RCAR_AHBPCI_WIN2_CTR_REG);
>> +
>> +	/* Enable AHB-PCI bridge PCI configuration access */
>> +	iowrite32(RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG,
>> +		  reg + RCAR_AHBPCI_WIN1_CTR_REG);
>> +	/* Set PCI-AHB Window1 address */
>> +	iowrite32(0x40000000 | PCI_BASE_ADDRESS_MEM_PREFETCH,
>> +		  reg + PCI_BASE_ADDRESS_1);
>> +	/* Set AHB-PCI bridge PCI communication area address */
>> +	val = priv->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
>> +	iowrite32(val, reg + PCI_BASE_ADDRESS_0);
>> +
>> +	val = ioread32(reg + PCI_COMMAND);
>> +	val |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
>> +	       PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
>> +	iowrite32(val, reg + PCI_COMMAND);
>> +
>> +	/* Enable PCI interrupts */
>> +	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
>> +		  reg + RCAR_PCI_INT_ENABLE_REG);
>> +
>> +	/* Add PCI resources */
>> +	pci_add_resource(&sys->resources, &priv->io_res);
>> +	pci_add_resource(&sys->resources, &priv->mem_res);
>> +
>> +	return 1;
>> +}
>> +
>> +static struct pci_ops rcar_pci_ops = {
>> +	.read	= rcar_pci_read_config,
>> +	.write	= rcar_pci_write_config,
>> +};
>> +
>> +static struct hw_pci rcar_hw_pci __initdata = {
>> +	.map_irq	= rcar_pci_map_irq,
>> +	.ops		= &rcar_pci_ops,
>> +	.setup		= rcar_pci_setup,
>> +};
>> +
>> +static int rcar_pci_count __initdata;
>> +
>> +static int __init rcar_pci_add_controller(struct rcar_pci_priv *priv)
>> +{
>> +	void **private_data;
>> +	int count;
>> +
>> +	if (rcar_hw_pci.nr_controllers < rcar_pci_count)
>> +		goto add_priv;
>> +
>> +	/* (Re)allocate private data pointer array if needed */
>> +	count = rcar_pci_count + RCAR_PCI_NR_CONTROLLERS;
>> +	private_data = kzalloc(count * sizeof(void *), GFP_KERNEL);
>> +	if (!private_data)
>> +		return -ENOMEM;
>> +
>> +	rcar_pci_count = count;
>> +	if (rcar_hw_pci.private_data) {
>> +		memcpy(private_data, rcar_hw_pci.private_data,
>> +		       rcar_hw_pci.nr_controllers * sizeof(void *));
>> +		kfree(rcar_hw_pci.private_data);
>> +	}
>> +
>> +	rcar_hw_pci.private_data = private_data;
>> +
>> +add_priv:
>> +	/* Add private data pointer to the array */
>> +	rcar_hw_pci.private_data[rcar_hw_pci.nr_controllers++] = priv;
>> +	return 0;
>> +}
>> +
>> +static int __init rcar_pci_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *cfg_res, *mem_res;
>> +	struct rcar_pci_priv *priv;
>> +	void __iomem *reg;
>> +
>> +	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
>> +	if (!reg)
>> +		return -ENODEV;
>> +
>> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!mem_res || !mem_res->start)
>> +		return -ENODEV;
>> +
>> +	priv = devm_kzalloc(&pdev->dev,
>> +			    sizeof(struct rcar_pci_priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->mem_res = *mem_res;
>> +	/*
>> +	 * The controller does not support/use port I/O,
>> +	 * so setup a dummy port I/O region here.
>> +	 */
>> +	priv->io_res.start = priv->mem_res.start;
>> +	priv->io_res.end = priv->mem_res.end;
>> +	priv->io_res.flags = IORESOURCE_IO;
>
> I don't understand this.  There's no requirement (at least as far as the
> PCI core is concerned) to supply an I/O aperture at all, and I think it
> would be better if you didn't.
>
> Oh, I see ... maybe pcibios_init_resources() forces you to have an
> I/O resource to avoid having it give you a default one?  And I
> suppose that since you have several host bridges, these dummy I/O
> regions have to be distinct.  Ugh.  Well, I guess this is something
> you'd have to fix here or in the ARM code, it's up to you what to do.

Exactly. This is to avoid assigning default I/O resources.

>
>> +	priv->cfg_res = cfg_res;
>> +
>> +	priv->irq = platform_get_irq(pdev, 0);
>> +	priv->reg = reg;
>> +
>> +	return rcar_pci_add_controller(priv);
>> +}
>> +
>> +static struct platform_driver rcar_pci_driver = {
>> +	.driver = {
>> +		.name = "pci-rcar-gen2",
>> +	},
>> +};
>> +
>> +static int __init rcar_pci_init(void)
>> +{
>> +	int retval;
>> +
>> +	retval = platform_driver_probe(&rcar_pci_driver, rcar_pci_probe);
>> +	if (!retval)
>> +		pci_common_init(&rcar_hw_pci);
>> +
>> +	/* Private data pointer array is not needed any more */
>> +	kfree(rcar_hw_pci.private_data);
>> +	rcar_hw_pci.private_data = NULL;
>> +
>> +	return retval;
>> +}
>> +
>> +subsys_initcall(rcar_pci_init);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Renesas R-Car Gen2 internal PCI");
>> +MODULE_AUTHOR("Valentine Barshak <valentine.barshak@cogentembedded.com>");
>> --
>> 1.8.3.1
>>

Thanks,
Val.
