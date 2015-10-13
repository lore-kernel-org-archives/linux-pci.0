Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:11960 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbbJMGdq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 02:33:46 -0400
Message-ID: <561CA5AF.2080300@hisilicon.com>
Date: Tue, 13 Oct 2015 14:33:19 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux@arm.linux.org.uk>, <thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	<jason@lakedaemon.net>, <robh@kernel.org>,
	<gabriel.fernandez@linaro.org>, <Minghuan.Lian@freescale.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liudongdong3@huawei.com>, <qiujiang@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com> <1444445957-239522-5-git-send-email-wangzhou1@hisilicon.com> <20151012213545.GA17479@localhost>
In-Reply-To: <20151012213545.GA17479@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/13 5:35, Bjorn Helgaas wrote:
> [+cc Arnd, Rob]
> 
> Hi Zhou,
> 
> I have a few minor comments and two questions: one about the fact
> all the config accesses are 32 bits, and another about the use of the
> "msi-parent" node.
> 
> On Sat, Oct 10, 2015 at 10:59:15AM +0800, Zhou Wang wrote:
>> This patch adds PCIe host support for HiSilicon SoC Hip05.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: liudongdong <liudongdong3@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: qiuzhenfa <qiuzhenfa@hisilicon.com>
> 
> This is a pretty long Signed-off-by chain.  If each of these people
> created part of this patch, that's fine.  I'm just checking whether
> that's the case, or whether some of these should be Reviewed-by,
> Suggested-by, etc., per Documentation/SubmittingPatches.
>

Hi Bjorn,

Thanks for reminding this. I had merged patches from those colleagues,
so just add Signed-off-by from them.

>> ---
>>  drivers/pci/host/Kconfig     |   8 ++
>>  drivers/pci/host/Makefile    |   1 +
>>  drivers/pci/host/pcie-hisi.c | 320 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 329 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-hisi.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index d5e58ba..ae873be 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -145,4 +145,12 @@ config PCIE_IPROC_BCMA
>>  	  Say Y here if you want to use the Broadcom iProc PCIe controller
>>  	  through the BCMA bus interface
>>  
>> +config PCI_HISI
>> +	depends on OF && ARM64
>> +	bool "HiSilicon SoC HIP05 PCIe controller"
>> +	select PCIEPORTBUS
>> +	select PCIE_DW
>> +	help
>> +	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 140d66f..ea1dbf2 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>> +obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
>> new file mode 100644
>> index 0000000..26aa0d9
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-hisi.c
>> @@ -0,0 +1,320 @@
>> +/*
>> + * PCIe host controller driver for HiSilicon Hip05 SoC
>> + *
>> + * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
>> + *
>> + * Author: Zhou Wang <wangzhou1@hisilicon.com>
>> + *         Dacai Zhu <zhudacai@hisilicon.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#include <linux/interrupt.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define PCIE_SUBCTRL_MODE_REG                           0x2800
>> +#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
>> +#define PCIE_SLV_DBI_MODE                               0x0
>> +#define PCIE_SLV_SYSCTRL_MODE                           0x1
>> +#define PCIE_SLV_CONTENT_MODE                           0x2
>> +#define PCIE_SLV_MSI_ASID                               0x10
>> +#define PCIE_LTSSM_LINKUP_STATE                         0x11
>> +#define PCIE_LTSSM_STATE_MASK                           0x3F
>> +#define PCIE_MSI_ASID_ENABLE                            (0x1 << 12)
>> +#define PCIE_MSI_ASID_VALUE                             (0x1 << 16)
>> +#define PCIE_MSI_TRANS_ENABLE                           (0x1 << 12)
>> +#define PCIE_MSI_TRANS_REG                              0x1c8
>> +#define PCIE_MSI_LOW_ADDRESS                            0x1b4
>> +#define PCIE_MSI_HIGH_ADDRESS                           0x1c4
>> +#define PCIE_GITS_TRANSLATER                            0x10040
> 
> "TRANSLATOR" is the more common spelling.  But if you're matching
> hardware documentation, you should follow that.
>

This is a copy from linux/include/linux/irqchip/arm-gic-v3.h:
#define GITS_TRANSLATER 0X10040
It indicates the offset of ITS's GITS_TRANSLATER register.

>> +#define PCIE_SYS_CTRL20_REG                             0x20
>> +#define PCIE_RD_TAB_SEL                                 BIT(31)
>> +#define PCIE_RD_TAB_EN                                  BIT(30)
>> +
>> +#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
>> +
>> +struct hisi_pcie {
>> +	struct regmap *subctrl;
>> +	void __iomem *reg_base;
>> +	u32 port_id;
>> +	struct pcie_port pp;
>> +};
>> +
>> +static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
>> +					u32 val, u32 reg)
>> +{
>> +	writel(val, pcie->reg_base + reg);
>> +}
>> +
>> +static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
>> +{
>> +	return readl(pcie->reg_base + reg);
>> +}
>> +
>> +/*
>> + * Change mode to indicate the same reg_base to base of PCIe host configure
>> + * registers, base of RC configure space or base of vmid/asid context table
> 
> It's fine to use lower-case in the C code, but in English text, it
> reads a little better to capitalize acronyms like VMID, ASID, APB, AR,
> AW, etc.  
>

Thanks for reminding this, will modify this next version.

>> + */
>> +static void hisi_pcie_change_apb_mode(struct hisi_pcie *pcie, u32 mode)
>> +{
>> +	u32 val;
>> +	u32 bit_mask;
>> +	u32 bit_shift;
>> +	u32 port_id = pcie->port_id;
>> +	u32 reg = PCIE_SUBCTRL_MODE_REG + 0x100 * port_id;
>> +
>> +	if ((port_id == 1) || (port_id == 2)) {
>> +		bit_mask = 0xc;
>> +		bit_shift = 0x2;
>> +	} else {
>> +		bit_mask = 0x6;
>> +		bit_shift = 0x1;
>> +	}
>> +
>> +	regmap_update_bits(pcie->subctrl, reg, bit_mask, mode << bit_shift);
>> +}
>> +
>> +/* Configure vmid/asid table in PCIe host */
>> +static void hisi_pcie_config_context(struct hisi_pcie *pcie)
>> +{
>> +	int i;
>> +	u32 val;
>> +
>> +	/* enable to clean vmid and asid tables though apb bus */
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
>> +
>> +	val = hisi_pcie_apb_readl(pcie, PCIE_SYS_CTRL20_REG);
>> +	/* enable ar channel */
>> +	val |= PCIE_RD_TAB_SEL | PCIE_RD_TAB_EN;
>> +	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
>> +
>> +	/*
>> +	 * init vmid and asid tables for all PCIe devices as 0
> 
> s/as 0/to 0./
>

Thanks.

>> +	 * vmid table: 0 ~ 0x3ff, asid table: 0x400 ~ 0x7ff
>> +	 */
>> +	for (i = 0; i < 0x800; i++)
>> +		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
>> +
>> +	/* enable aw channel */
>> +	val &= (~PCIE_RD_TAB_SEL);
>> +	val |= PCIE_RD_TAB_EN;
>> +	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
>> +
>> +	for (i = 0; i < 0x800; i++)
>> +		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
>> +
>> +	val = hisi_pcie_apb_readl(pcie, PCIE_SYS_CTRL20_REG);
>> +	/* disable ar channel */
>> +	val |= PCIE_RD_TAB_SEL;
>> +	val &= (~PCIE_RD_TAB_EN);
>> +	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
>> +	/* disable aw channel */
>> +	val &= ((~PCIE_RD_TAB_SEL) & (~PCIE_RD_TAB_EN));
>> +	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
>> +}
>> +
>> +static int hisi_pcie_link_up(struct pcie_port *pp)
>> +{
>> +	u32 val;
>> +	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
>> +
>> +	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
>> +		    0x100 * hisi_pcie->port_id, &val);
>> +
>> +	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
>> +}
>> +
>> +static
>> +int hisi_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
> 
> "static int hisi_..." as in other cases (wrap before "struct
> msi_controller" instead of before "int hisi_pcie_msi_host_init").
>

Thanks, will do like this.

>> +{
>> +	u64 addr;
>> +	struct device_node *msi_node;
>> +	struct resource res;
>> +	struct device_node *np = pp->dev->of_node;
>> +	struct hisi_pcie *pcie = to_hisi_pcie(pp);
>> +
>> +	msi_node = of_parse_phandle(np, "msi-parent", 0);
>> +	if (!msi_node) {
>> +		dev_err(pp->dev, "failed to find msi-parent\n");
>> +		return -EINVAL;
>> +	}
>> +	of_address_to_resource(msi_node, 0, &res);
> 
> Does this use the "msi-parent" node in the same way as other drivers
> do?  I'm sure there must be other places where we extract struct
> resource information from an "msi-parent" node, but I don't see them.
> 
> I'm trying to verify that this isn't some kind of incompatible
> extension of the "msi-parent" property.  I cc'd Arnd and Rob (DT
> experts).
>

Here I just want to get the address of related ITS' GITS_TRANSLATER register,
HiSilicon Hip05 PCIe controller need know this address to send MSI interrupt.
I think other drivers need not to do this.

struct resource above is for ITS base address which is extracted in GIC ITS
driver also: drivers/irqchip/irq-gic-v3-its.c

>> +	addr = res.start + PCIE_GITS_TRANSLATER;
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
>> +
>> +	hisi_pcie_apb_writel(pcie, addr & 0xffffffff, PCIE_MSI_LOW_ADDRESS);
>> +	hisi_pcie_apb_writel(pcie, addr >> 32, PCIE_MSI_HIGH_ADDRESS);
>> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_ASID_ENABLE | PCIE_MSI_ASID_VALUE,
>> +			     PCIE_SLV_MSI_ASID);
>> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_TRANS_ENABLE, PCIE_MSI_TRANS_REG);
>> +
>> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
>> +				u32 val)
>> +{
>> +	u32 reg_val;
>> +	u32 reg;
>> +	struct hisi_pcie *pcie = to_hisi_pcie(pp);
>> +	void *walker = &reg_val;
>> +
>> +	walker += (where & 0x3);
>> +	reg = where & ~0x3;
>> +	if (size == 4)
>> +		hisi_pcie_apb_writel(pcie, val, reg);
>> +	else if (size == 2) {
>> +		reg_val = hisi_pcie_apb_readl(pcie, reg);
>> +		*(u16 __force *) walker = val;
>> +		hisi_pcie_apb_writel(pcie, reg_val, reg);
>> +	} else if (size == 1) {
>> +		reg_val = hisi_pcie_apb_readl(pcie, reg);
>> +		*(u8 __force *) walker = val;
>> +		hisi_pcie_apb_writel(pcie, reg_val, reg);
> 
> This has the read/modify/write problem pointed out by Russell King:
> http://lkml.kernel.org/r/E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk
> 
> Is the HiSilicon hardware limited to 32-bit config accesses?  If so,
> that seems like a hardware implementation defect, and this needs at
> least a comment in the code.  When we figure out a good mechanism,
> we'll want to taint or warn about this hardware limitation somehow.
>

For config accesses of PCIe host, Hip05 PCIe only support 32-bit access
that is why we need a private callback here.

I will add a comment here in next version.

>> +	} else
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
>> +			      u32 *val)
>> +{
>> +	u32 reg;
>> +	u32 reg_val;
>> +	struct hisi_pcie *pcie = to_hisi_pcie(pp);
>> +	void *walker = &reg_val;
>> +
>> +	walker += (where & 0x3);
>> +	reg = where & ~0x3;
>> +	reg_val = hisi_pcie_apb_readl(pcie, reg);
>> +
>> +	if (size == 1)
>> +		*val = *(u8 __force *) walker;
>> +	else if (size == 2)
>> +		*val = *(u16 __force *) walker;
>> +	else if (size != 4)
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>> +static struct pcie_host_ops hisi_pcie_host_ops = {
>> +	.link_up = hisi_pcie_link_up,
>> +	.msi_host_init = hisi_pcie_msi_host_init,
>> +	.wr_own_conf = hisi_pcie_cfg_write,
>> +	.rd_own_conf = hisi_pcie_cfg_read,
> 
> Under the rule of "do it the same way unless there's a reason to be
> different," please put the hisi_pcie_cfg_read() definition before the
> hisi_pcie_cfg_write() definition, and change the order of these
> function pointers similarly.  That matches the order in the struct
> pcie_host_ops definition and in other drivers.
> 

Thanks for pointing this, will do like this.

>> +};
>> +
>> +static int __init hisi_add_pcie_port(struct pcie_port *pp,
>> +				     struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	u32 port_id;
>> +	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
>> +
>> +	if (of_property_read_u32(pdev->dev.of_node, "port-id", &port_id)) {
>> +		dev_err(&pdev->dev, "failed to read port-id\n");
>> +		return -EINVAL;
>> +	}
>> +	if (port_id > 3) {
>> +		dev_err(&pdev->dev, "Invalid port-id: %d\n", port_id);
>> +		return -EINVAL;
>> +	}
>> +	hisi_pcie->port_id = port_id;
>> +
>> +	pp->ops = &hisi_pcie_host_ops;
>> +
>> +	hisi_pcie_config_context(hisi_pcie);
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to initialize host\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init hisi_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct hisi_pcie *hisi_pcie;
>> +	struct pcie_port *pp;
>> +	struct resource *reg;
>> +	int ret;
>> +
>> +	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
>> +	if (!hisi_pcie)
>> +		return -ENOMEM;
>> +
>> +	pp = &hisi_pcie->pp;
>> +	pp->dev = &pdev->dev;
>> +
>> +	hisi_pcie->subctrl =
>> +	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
> 
> Indent a tab here.

OK, will do like this.

> 
>> +	if (IS_ERR(hisi_pcie->subctrl)) {
>> +		dev_err(pp->dev, "cannot get subctrl base\n");
>> +		return PTR_ERR(hisi_pcie->subctrl);
>> +	}
>> +
>> +	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
>> +	hisi_pcie->reg_base = devm_ioremap_resource(&pdev->dev, reg);
>> +	if (IS_ERR(hisi_pcie->reg_base)) {
>> +		dev_err(pp->dev, "cannot get rc_dbi base\n");
>> +		return PTR_ERR(hisi_pcie->reg_base);
>> +	}
>> +
>> +	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
>> +
>> +	ret = hisi_add_pcie_port(pp, pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, hisi_pcie);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id hisi_pcie_of_match[] = {
>> +	{.compatible = "hisilicon,hip05-pcie",},
>> +	{},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
>> +
>> +static struct platform_driver hisi_pcie_driver = {
>> +	.driver = {
>> +		   .name = "hisi-pcie",
>> +		   .of_match_table = hisi_pcie_of_match,
>> +	},
>> +};
>> +
>> +static int __init hisi_pcie_init(void)
>> +{
>> +	return platform_driver_probe(&hisi_pcie_driver, hisi_pcie_probe);
>> +}
>> +subsys_initcall(hisi_pcie_init);
> 
> Can you use module_platform_driver() or module_platform_driver_probe()
> here instead of the subsys_initcall()?  No, I don't really know what
> the difference between module_platform_driver() and
> module_platform_driver_probe() is, sorry :)

In fact, I used module_platform_driver_probe in previous version, but
A PCIe VGA card of HiSilicon will use Hip05 PCIe host, so we modified
module_platform_driver_probe to subsys_initcall which will be called
before module_platform_driver_probe.

We will upstream the driver of above PCIe VGA card soon.

Many thanks for your reviewing,
Zhou

> 
> Bjorn
> 
> .
> 


