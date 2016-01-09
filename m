Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:49677 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbcAILVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 9 Jan 2016 06:21:17 -0500
Subject: Re: [PATCH 2/2] PCI: mediatek: add support for PCIE found on
 MT7623/MT2701
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1452200773-50794-1-git-send-email-blogic@openwrt.org>
 <1452200773-50794-2-git-send-email-blogic@openwrt.org>
 <20160109001825.GN5354@localhost>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
From: John Crispin <blogic@openwrt.org>
Message-ID: <5690ED1F.8080502@openwrt.org>
Date: Sat, 9 Jan 2016 12:21:03 +0100
MIME-Version: 1.0
In-Reply-To: <20160109001825.GN5354@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 09/01/2016 01:18, Bjorn Helgaas wrote:
> Hi John,
> 
> On Thu, Jan 07, 2016 at 10:06:13PM +0100, John Crispin wrote:
>> Add PCIE controller support on MediaTek MT2701/MT7623. The driver supports
> 
> Please capitalize as "PCIe" consistently.  You have some of each
> ("PCIE" and "PCIe").
> 
>> a single Root complex (RC) with 3 Root Ports. The SoCs supports a Gen2
>> 1-lan Link on each port.
> 
> What does "1-lan" mean?  I expected "x1" or something similar.
> 

Hi Bjorn,

thanks for the quick review, I'll look into those things over the next
couple of days. need to find out about the 8/16 bit i/o. the code is
based on the SDK driver which never had those functions.

the driver works and has been properly tested however when it loads we
see a few weird error messages.

mediatek-pcie 1a140000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
pci_bus 0000:00: root bus resource [io  0x1a160000-0x1a16ffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
PCI: bus1: Fast back to back transfers disabled
pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000]
pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x80000000]
pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
pci 0000:00:00.0: BAR 1: assigned [mem 0x60200000-0x6020ffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x60000000-0x600fffff 64bit]
pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]

i guess the "no space" boils down to "#define MEMORY_BASE 0x80000000"
not sure about the others, ideas are welcome.

	John




>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> ---
>>  arch/arm/mach-mediatek/Kconfig   |    1 +
>>  drivers/pci/host/Kconfig         |   11 +
>>  drivers/pci/host/Makefile        |    1 +
>>  drivers/pci/host/pcie-mediatek.c |  604 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 617 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-mediatek.c
>>
>> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
>> index 7fb605e..a7fef77 100644
>> --- a/arch/arm/mach-mediatek/Kconfig
>> +++ b/arch/arm/mach-mediatek/Kconfig
>> @@ -24,6 +24,7 @@ config MACH_MT6592
>>  config MACH_MT7623
>>  	bool "MediaTek MT7623 SoCs support"
>>  	default ARCH_MEDIATEK
>> +	select MIGHT_HAVE_PCI
>>  
>>  config MACH_MT8127
>>  	bool "MediaTek MT8127 SoCs support"
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index f131ba9..912f0e1 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -172,4 +172,15 @@ config PCI_HISI
>>  	help
>>  	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
>>  
>> +config PCIE_MTK
>> +	bool "Mediatek PCIe Controller"
>> +	depends on MACH_MT2701 || MACH_MT7623
>> +	depends on OF
>> +	depends on PCI
>> +	help
>> +	  Say Y here if you want to enable PCI controller support on Mediatek MT7623.
>> +	  MT7623 PCIe supports single Root complex (RC) with 3 Root Ports.
>> +	  Each port supports a Gen2 1-lan Link.
>> +	  PCIe include one Host/PCI bridge and 3 PCIe MAC.
> 
> What does "3 PCIe MAC" mean?
> 
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 9d4d3c6..3b53374 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>>  obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
>> +obj-$(CONFIG_PCIE_MTK) += pcie-mediatek.o
>> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
>> new file mode 100644
>> index 0000000..6bd283a
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-mediatek.c
>> @@ -0,0 +1,604 @@
>> +/*
>> + *  Mediatek MT2701/MT7623 SoC PCIE support
>> + *
>> + *  Copyright (C) 2015 Mediatek
>> + *  Copyright (C) 2015 Ziv Huang <ziv.huang@mediatek.com>
>> + *  Copyright (C) 2015 John Crispin <blogic@openwrt.org>
>> + *
>> + *  This program is free software; you can redistribute it and/or modify it
>> + *  under the terms of the GNU General Public License version 2 as published
>> + *  by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/ioport.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/delay.h>
>> +#include <asm/irq.h>
>> +#include <asm/mach/pci.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/reset.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/clk.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +
>> +#define MEMORY_BASE			0x80000000
> 
> What's this?  It looks like it might be a hard-coded memory address,
> which should be avoided or maybe learned via DT.
> 
>> +/* PCIE Registers */
>> +#define PCICFG				0x00
>> +#define PCIINT				0x08
>> +#define PCIENA				0x0c
>> +#define CFGADDR				0x20
>> +#define CFGDATA				0x24
>> +#define MEMBASE				0x28
>> +#define IOBASE				0x2c
>> +
>> +/* per Port Registers */
>> +#define BAR0SETUP			0x10
>> +#define IMBASEBAR0			0x18
>> +#define PCIE_CLASS			0x34
>> +#define PCIE_SISTAT			0x50
>> +
>> +#define MTK_PCIE_HIGH_PERF		BIT(14)
>> +#define PCIEP0_BASE			0x2000
>> +#define PCIEP1_BASE			0x3000
>> +#define PCIEP2_BASE			0x4000
>> +
>> +#define PHY_P0_CTL			0x9000
>> +#define PHY_P1_CTL			0xa000
>> +#define PHY_P2_CTL			0x4000
>> +
>> +#define RSTCTL_PCIE0_RST		BIT(24)
>> +#define RSTCTL_PCIE1_RST		BIT(25)
>> +#define RSTCTL_PCIE2_RST		BIT(26)
>> +
>> +#define HIFSYS_SYSCFG1			0x14
>> +#define HIFSYS_SYSCFG1_PHY2_MASK	(0x3 << 20)
>> +
>> +static struct mtk_pcie_port {
>> +	int id;
>> +	int enable;
>> +	u32 base;
>> +	u32 perst_n;
>> +	u32 interrupt_en;
>> +	int irq;
>> +	u32 link;
>> +	void __iomem *phy_base;
>> +	struct reset_control *rstc;
>> +} mtk_pcie_port[] = {
>> +	{ 0, 0, PCIEP0_BASE, BIT(1), BIT(20) },
>> +	{ 1, 0, PCIEP1_BASE, BIT(2), BIT(21) },
>> +	{ 2, 0, PCIEP2_BASE, BIT(3), BIT(22) },
>> +};
>> +#define MAX_PORT_NUM		ARRAY_SIZE(mtk_pcie_port)
>> +#define mtk_foreach_port(p)			\
>> +		for ((p) = mtk_pcie_port;	\
>> +		     (p) != &mtk_pcie_port[MAX_PORT_NUM]; (p)++)
> 
> If I understand this correctly, you dynamically allocate a struct
> mtk_pcie for each Root Complex, which is as it should be, but you
> statically allocate mtk_pcie_ports for three Root Ports.  That's wrong
> because if you had two Root Complexes, you would have *six* Root
> Ports.
> 
> Maybe you want an array of three mtk_pcie_ports inside each mtk_pcie?
> 
>> +
>> +struct mtk_pcie {
>> +	struct device *dev;
>> +	void __iomem *pcie_base;
>> +	struct regmap *hifsys;
>> +
>> +	struct resource io;
>> +	struct resource pio;
>> +	struct resource mem;
>> +	struct resource prefetch;
>> +	struct resource busn;
>> +
>> +	u32 io_bus_addr;
>> +	u32 mem_bus_addr;
>> +
>> +	struct clk *clk;
>> +	int pcie_card_link;
>> +};
>> +
>> +static const struct mtk_phy_init {
>> +	uint32_t reg;
>> +	uint32_t mask;
>> +	uint32_t val;
>> +} mtk_phy_init[] = {
>> +	{ 0xc00, 0x33000, 0x22000 },
>> +	{ 0xb04, 0xe0000000, 0x40000000 },
>> +	{ 0xb00, 0xe, 0x4 },
>> +	{ 0xc3C, 0xffff0000, 0x3c0000 },
>> +	{ 0xc48, 0xffff, 0x36 },
>> +	{ 0xc0c, 0x30000000, 0x10000000 },
>> +	{ 0xc08, 0x3800c0, 0xc0 },
>> +	{ 0xc10, 0xf0000, 0x20000 },
>> +	{ 0xc0c, 0xf000, 0x1000 },
>> +	{ 0xc14, 0xf0000, 0xa0000 },
>> +};
> 
> These magic tables of initialization values are sort of frowned upon.
> It's basically a tiny embedded binary blob.  Can you replace this with
> descriptive #defines for the registers so we have some clue about
> what's going on?
> 
>> +
>> +static struct mtk_pcie *sys_to_pcie(struct pci_sys_data *sys)
>> +{
>> +	return sys->private_data;
>> +}
>> +
>> +static void pcie_w32(struct mtk_pcie *pcie, u32 val, unsigned reg)
>> +{
>> +	iowrite32(val, pcie->pcie_base + reg);
>> +}
>> +
>> +static u32 pcie_r32(struct mtk_pcie *pcie, unsigned reg)
>> +{
>> +	return ioread32(pcie->pcie_base + reg);
>> +}
>> +
>> +static void pcie_m32(struct mtk_pcie *pcie, u32 mask, u32 val, unsigned reg)
>> +{
>> +	u32 v = pcie_r32(pcie, reg);
>> +
>> +	v &= mask;
>> +	v |= val;
>> +	pcie_w32(pcie, v, reg);
>> +}
>> +
>> +static int pcie_config_read(struct pci_bus *bus, unsigned int devfn, int where,
>> +			    int size, u32 *val)
>> +{
>> +	struct mtk_pcie *pcie = sys_to_pcie(bus->sysdata);
>> +	unsigned int slot = PCI_SLOT(devfn);
>> +	u8 func = PCI_FUNC(devfn);
>> +	u32 address;
>> +	u32 data;
>> +	u32 num = 0;
>> +
>> +	if (bus)
>> +		num = bus->number;
>> +
>> +	address = (((where & 0xf00) >> 8) << 24) |
>> +		  (num << 16) |
>> +		  (slot << 11) |
>> +		  (func << 8) |
>> +		  (where & 0xfc);
>> +
>> +	pcie_m32(pcie, 0xf0000000, address, CFGADDR);
> 
> 0xf0000000 should be a #define.  Apparently it defines a field in the
> CFGADDR register.
> 
>> +	data = pcie_r32(pcie, CFGDATA);
>> +
>> +	switch (size) {
>> +	case 1:
>> +		*val = (data >> ((where & 3) << 3)) & 0xff;
>> +		break;
>> +	case 2:
>> +		*val = (data >> ((where & 3) << 3)) & 0xffff;
>> +		break;
>> +	case 4:
>> +		*val = data;
>> +		break;
>> +	}
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int pcie_config_write(struct pci_bus *bus, unsigned int devfn, int where,
>> +			     int size, u32 val)
>> +{
>> +	struct mtk_pcie *pcie = sys_to_pcie(bus->sysdata);
>> +	unsigned int slot = PCI_SLOT(devfn);
>> +	u8 func = PCI_FUNC(devfn);
>> +	u32 address;
>> +	u32 data;
>> +	u32 num = 0;
>> +
>> +	if (bus)
>> +		num = bus->number;
>> +
>> +	address = (((where & 0xf00) >> 8) << 24) |
>> +		  (num << 16) | (slot << 11) | (func << 8) | (where & 0xfc);
>> +	pcie_m32(pcie, 0xf0000000, address, CFGADDR);
>> +	data = pcie_r32(pcie, CFGDATA);
>> +
>> +	switch (size) {
>> +	case 1:
>> +		data = (data & ~(0xff << ((where & 3) << 3))) |
>> +		       (val << ((where & 3) << 3));
>> +		break;
>> +	case 2:
>> +		data = (data & ~(0xffff << ((where & 3) << 3))) |
>> +		       (val << ((where & 3) << 3));
>> +		break;
>> +	case 4:
>> +		data = val;
>> +		break;
>> +	}
>> +	pcie_w32(pcie, data, CFGDATA);
> 
> Oops, is this another device that can't do sub-32 bit config writes?
> If so, that's a hardware defect because the read/modify/write will
> corrupt RW1C bits in registers.
> 
> If the hardware is capable of 8- and 16-bit writes, please change the
> code to use them.  If not, please print a warning at probe-time so we
> have a debugging clue for when the corruption bites us.  There other
> drivers with the same problem, so please follow their format.
> 
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static struct pci_ops mtk_pcie_ops = {
>> +	.read   = pcie_config_read,
>> +	.write  = pcie_config_write,
>> +};
>> +
>> +static int __init mtk_pcie_setup(int nr, struct pci_sys_data *sys)
>> +{
>> +	struct mtk_pcie *pcie = sys_to_pcie(sys);
>> +
>> +	if (!pcie->pcie_card_link)
>> +		return -1;
> 
> Please restructure the code so these guards aren't necessary.
> 
>> +
>> +	request_resource(&ioport_resource, &pcie->pio);
>> +	request_resource(&iomem_resource, &pcie->mem);
>> +
>> +	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
>> +	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
>> +	pci_add_resource(&sys->resources, &pcie->busn);
>> +
>> +	return 1;
>> +}
>> +
>> +static struct pci_bus * __init mtk_pcie_scan_bus(int nr,
>> +						struct pci_sys_data *sys)
>> +{
>> +	struct mtk_pcie *pcie = sys_to_pcie(sys);
>> +	struct pci_bus *bus;
>> +
>> +	if (!pcie->pcie_card_link)
>> +		return NULL;
>> +
>> +	bus = pci_create_root_bus(pcie->dev, sys->busnr, &mtk_pcie_ops, sys,
>> +				  &sys->resources);
>> +	if (!bus)
>> +		return NULL;
>> +
>> +	pci_scan_child_bus(bus);
>> +
>> +	return bus;
>> +}
>> +
>> +static int __init mtk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>> +{
>> +	struct mtk_pcie *pcie = sys_to_pcie(dev->bus->sysdata);
>> +	struct mtk_pcie_port *port;
>> +	int irq = -1;
>> +
>> +	if (!pcie->pcie_card_link)
>> +		return irq;
>> +
>> +	mtk_foreach_port(port)
>> +		if (port->id == slot)
>> +			irq = port->irq;
>> +
>> +	return irq;
>> +}
>> +
>> +static void mtk_pcie_configure_phy(struct mtk_pcie *pcie,
>> +				   struct mtk_pcie_port *port)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(mtk_phy_init); i++) {
>> +		void __iomem *phy_addr = port->phy_base + mtk_phy_init[i].reg;
>> +		u32 val = ioread32(phy_addr);
>> +
>> +		val &= ~mtk_phy_init[i].mask;
>> +		val |= mtk_phy_init[i].val;
>> +		iowrite32(val, phy_addr);
>> +	}
>> +	usleep_range(5000, 6000);
>> +}
>> +
>> +static void mtk_pcie_configure_rc(struct mtk_pcie *pcie,
>> +				  struct mtk_pcie_port *port,
>> +				  struct pci_bus *bus)
>> +{
>> +	u32 val = 0;
>> +
>> +	pcie_config_write(bus,
>> +			  port->id << 3,
>> +			  PCI_BASE_ADDRESS_0, 4, MEMORY_BASE);
>> +
>> +	pcie_config_read(bus,
>> +			 port->id << 3, PCI_BASE_ADDRESS_0, 4, &val);
>> +
>> +	/* Configure RC Credit */
>> +	pcie_config_read(bus, port->id << 3, 0x73c, 4, &val);
>> +	val &= ~(0x9fff) << 16;
>> +	val |= 0x806c << 16;
>> +	pcie_config_write(bus, port->id << 3, 0x73c, 4, val);
>> +
>> +	/* Configure RC FTS number */
>> +	pcie_config_read(bus, port->id << 3, 0x70c, 4, &val);
>> +	val &= ~(0xff3) << 8;
>> +	val |= 0x50 << 8;
>> +	pcie_config_write(bus, port->id << 3, 0x70c, 4, val);
>> +}
>> +
>> +static void mtk_pcie_preinit(struct mtk_pcie *pcie)
>> +{
>> +	struct mtk_pcie_port *port;
>> +	u32 val = 0;
>> +	struct pci_bus bus;
>> +	struct pci_sys_data sys;
>> +
>> +	memset(&bus, 0, sizeof(bus));
>> +	memset(&sys, 0, sizeof(sys));
>> +	bus.sysdata = (void *)&sys;
>> +	sys.private_data = (void *)pcie;
>> +
>> +	pcibios_min_io = 0;
>> +	pcibios_min_mem = 0;
> 
> These are ARM-specific variables that shouldn't be used by a host
> bridge driver.
> 
>> +
>> +	/* The PHY on Port 2 is shared with USB */
>> +	if (mtk_pcie_port[2].enable)
>> +		regmap_update_bits(pcie->hifsys, HIFSYS_SYSCFG1,
>> +				   HIFSYS_SYSCFG1_PHY2_MASK, 0x0);
>> +
>> +	/* PCIe RC Reset */
>> +	mtk_foreach_port(port)
>> +		if (port->enable)
>> +			reset_control_assert(port->rstc);
>> +	usleep_range(1000, 2000);
>> +	mtk_foreach_port(port)
>> +		if (port->enable)
>> +			reset_control_deassert(port->rstc);
>> +	usleep_range(1000, 2000);
>> +
>> +	/* Configure PCIe PHY */
>> +	mtk_foreach_port(port)
>> +		if (port->enable)
>> +			mtk_pcie_configure_phy(pcie, port);
>> +
>> +	/* PCIe EP reset */
>> +	val = 0;
>> +	mtk_foreach_port(port)
>> +		if (port->enable)
>> +			val |= port->perst_n;
>> +	pcie_w32(pcie, pcie_r32(pcie, PCICFG) | val, PCICFG);
>> +	usleep_range(1000, 2000);
>> +	pcie_w32(pcie, pcie_r32(pcie, PCICFG) & ~val, PCICFG);
>> +	usleep_range(1000, 2000);
>> +	msleep(100);
>> +
>> +	/* check the link status */
>> +	val = 0;
>> +	mtk_foreach_port(port) {
>> +		if (port->enable) {
>> +			if ((pcie_r32(pcie, port->base + PCIE_SISTAT) & 0x1))
>> +				port->link = 1;
>> +			else
>> +				reset_control_assert(port->rstc);
>> +		}
>> +	}
>> +
>> +	mtk_foreach_port(port)
>> +		if (port->link)
>> +			pcie->pcie_card_link++;
>> +
>> +	if (!pcie->pcie_card_link)
>> +		return;
>> +
>> +	pcie_w32(pcie, pcie->mem_bus_addr, MEMBASE);
>> +	pcie_w32(pcie, pcie->io_bus_addr, IOBASE);
>> +
>> +	mtk_foreach_port(port) {
>> +		if (port->link) {
>> +			pcie_m32(pcie, 0, port->interrupt_en, PCIENA);
>> +			pcie_w32(pcie, 0x7fff0001, port->base + BAR0SETUP);
>> +			pcie_w32(pcie, MEMORY_BASE, port->base + IMBASEBAR0);
>> +			pcie_w32(pcie, 0x06040001, port->base + PCIE_CLASS);
>> +		}
>> +	}
>> +
>> +	mtk_foreach_port(port)
>> +		if (port->link)
>> +			mtk_pcie_configure_rc(pcie, port, &bus);
>> +}
>> +
>> +static int mtk_pcie_parse_dt(struct mtk_pcie *pcie)
>> +{
>> +	struct device_node *np = pcie->dev->of_node, *port;
>> +	struct of_pci_range_parser parser;
>> +	struct of_pci_range range;
>> +	struct resource res;
>> +	int err;
>> +
>> +	pcie->hifsys = syscon_regmap_lookup_by_phandle(np, "mediatek,hifsys");
>> +	if (IS_ERR(pcie->hifsys)) {
>> +		dev_err(pcie->dev, "missing \"mediatek,hifsys\" phandle\n");
>> +		return PTR_ERR(pcie->hifsys);
>> +	}
>> +
>> +	if (of_pci_range_parser_init(&parser, np)) {
>> +		dev_err(pcie->dev, "missing \"ranges\" property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_of_pci_range(&parser, &range) {
>> +		err = of_pci_range_to_resource(&range, np, &res);
>> +		if (err < 0) {
>> +			dev_err(pcie->dev, "failed to read resource range\n");
>> +			return err;
>> +		}
>> +
>> +		switch (res.flags & IORESOURCE_TYPE_BITS) {
>> +		case IORESOURCE_IO:
>> +			memcpy(&pcie->pio, &res, sizeof(res));
>> +			pcie->pio.start = (resource_size_t)range.pci_addr;
>> +			pcie->pio.end = (resource_size_t)
>> +					(range.pci_addr + range.size - 1);
>> +			pcie->io_bus_addr = (resource_size_t)range.cpu_addr;
>> +			break;
>> +
>> +		case IORESOURCE_MEM:
>> +			if (res.flags & IORESOURCE_PREFETCH) {
>> +				memcpy(&pcie->prefetch, &res, sizeof(res));
>> +				pcie->prefetch.name = "prefetchable";
>> +				pcie->prefetch.start =
>> +					(resource_size_t)range.pci_addr;
>> +				pcie->prefetch.end = (resource_size_t)
>> +					(range.pci_addr + range.size - 1);
>> +			} else {
>> +				memcpy(&pcie->mem, &res, sizeof(res));
>> +				pcie->mem.name = "non-prefetchable";
>> +				pcie->mem.start = (resource_size_t)
>> +					range.pci_addr;
>> +				pcie->prefetch.end = (resource_size_t)
>> +					(range.pci_addr + range.size - 1);
>> +				pcie->mem_bus_addr = (resource_size_t)
>> +					range.cpu_addr;
>> +			}
>> +			break;
>> +		}
>> +	}
>> +
>> +	err = of_pci_parse_bus_range(np, &pcie->busn);
>> +	if (err < 0) {
>> +		dev_err(pcie->dev, "failed to parse ranges property: %d\n",
>> +			err);
>> +		pcie->busn.name = np->name;
>> +		pcie->busn.start = 0;
>> +		pcie->busn.end = 0xff;
>> +		pcie->busn.flags = IORESOURCE_BUS;
>> +	}
>> +
>> +	/* parse root ports */
>> +	for_each_child_of_node(np, port) {
>> +		unsigned int index;
>> +		char rst[] = "pcie0";
>> +
>> +		err = of_pci_get_devfn(port);
>> +		if (err < 0) {
>> +			dev_err(pcie->dev, "failed to parse address: %d\n",
>> +				err);
>> +			return err;
>> +		}
>> +
>> +		index = PCI_SLOT(err);
>> +
>> +		if (index > MAX_PORT_NUM) {
>> +			dev_err(pcie->dev, "invalid port number: %d\n", index);
>> +			continue;
>> +		}
>> +		index--;
>> +
>> +		if (!of_device_is_available(port))
>> +			continue;
>> +
>> +		rst[4] += index;
>> +		mtk_pcie_port[index].rstc = devm_reset_control_get(pcie->dev,
>> +								   rst);
>> +		if (!IS_ERR(mtk_pcie_port[index].rstc))
>> +			mtk_pcie_port[index].enable = 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int mtk_pcie_get_resources(struct mtk_pcie *pcie)
>> +{
>> +	struct platform_device *pdev = to_platform_device(pcie->dev);
>> +	struct mtk_pcie_port *port;
>> +	struct resource *res;
>> +
>> +	pcie->clk = devm_clk_get(&pdev->dev, "pcie");
>> +	if (IS_ERR(pcie->clk)) {
>> +		dev_err(&pdev->dev, "Failed to get pcie clk\n");
>> +		return PTR_ERR(pcie->clk);
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	pcie->pcie_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(pcie->pcie_base)) {
>> +		dev_err(&pdev->dev, "Failed to get pcie range\n");
>> +		return PTR_ERR(pcie->pcie_base);
>> +	}
>> +
>> +	mtk_foreach_port(port) {
>> +		if (!port->enable)
>> +			continue;
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, port->id + 1);
>> +		port->phy_base = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(port->phy_base)) {
>> +			dev_err(&pdev->dev, "Failed to get pcie phy%d range\n",
>> +				port->id);
>> +			return PTR_ERR(port->phy_base);
>> +		}
>> +		port->irq = platform_get_irq(pdev, port->id);
>> +	}
>> +
>> +	return clk_prepare_enable(pcie->clk);
>> +}
>> +
>> +static int mtk_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct mtk_pcie *pcie;
>> +	struct hw_pci hw;
>> +	int ret;
>> +
>> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>> +	if (!pcie)
>> +		return -ENOMEM;
>> +
>> +	pcie->dev = &pdev->dev;
>> +	ret = mtk_pcie_parse_dt(pcie);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	pm_runtime_enable(&pdev->dev);
>> +	pm_runtime_get_sync(&pdev->dev);
>> +
>> +	ret = mtk_pcie_get_resources(pcie);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to request resources: %d\n", ret);
>> +		goto err_out;
>> +	}
>> +
>> +	mtk_pcie_preinit(pcie);
>> +
>> +	memset(&hw, 0, sizeof(hw));
>> +	hw.nr_controllers = 1;
>> +	hw.private_data = (void **)&pcie;
>> +	hw.setup = mtk_pcie_setup;
>> +	hw.map_irq = mtk_pcie_map_irq;
>> +	hw.scan = mtk_pcie_scan_bus;
>> +
>> +	pci_common_init_dev(pcie->dev, &hw);
> 
> Calling pci_common_init_dev() makes this driver unnecessarily
> ARM-specific.  Please rework this so it doesn't use these ARM-specific
> entry points.
> 
>> +	platform_set_drvdata(pdev, pcie);
>> +
>> +	return 0;
>> +
>> +err_out:
>> +	clk_disable_unprepare(pcie->clk);
>> +	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id mtk_pcie_ids[] = {
>> +	{ .compatible = "mediatek,mt2701-pcie" },
>> +	{ .compatible = "mediatek,mt7623-pcie" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, mtk_pcie_ids);
>> +
>> +static struct platform_driver mtk_pcie_driver = {
>> +	.probe = mtk_pcie_probe,
>> +	.driver = {
>> +		.name = "mediatek-pcie",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = of_match_ptr(mtk_pcie_ids),
>> +	},
>> +};
>> +
>> +static int __init mtk_pcie_init(void)
>> +{
>> +	return platform_driver_register(&mtk_pcie_driver);
>> +}
>> +
>> +module_init(mtk_pcie_init);
>> -- 
>> 1.7.10.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
