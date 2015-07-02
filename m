Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:22406 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbbGBBRH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jul 2015 21:17:07 -0400
Message-ID: <559490EC.8040909@hisilicon.com>
Date: Thu, 2 Jul 2015 09:16:28 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"kishon@ti.com" <kishon@ti.com>,
	"xobs@kosagi.com" <xobs@kosagi.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v3 2/5] PCI: designware: Add ARM64 support
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com> <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
Content-Type: text/plain; charset="GB2312"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/1 21:29, Gabriele Paoloni wrote:
> Adding to the recipients list the authors of the drivers that depend on Synopsys Designware and that are not included
> 
> Respectively:
> pci-dra7xx Kishon Vijay Abraham I <kishon@ti.com>
> pci-imx6 Sean Cross <xobs@kosagi.com>
> pci-keystone Murali Karicheri <m-karicheri2@ti.com>
> pci-layerscape Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> Driver Authors already included:
> pci-exynos Jingoo Han <jg1.han@samsung.com>
> pcie-spear13xx Pratyush Anand <pratyush.anand@st.com>
> 
> Cheers
> 
> Gab
> 

Hi Gab,

Many thanks for adding the related guys.

Regards,
Zhou

>> -----Original Message-----
>> From: Wangzhou (B)
>> Sent: Wednesday, July 01, 2015 10:44 AM
>> To: Bjorn Helgaas; Jingoo Han; Pratyush Anand; Arnd Bergmann; Gabriele
>> Paoloni; James Morse; Liviu Dudau
>> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
>> qiuzhenfa; Liguozhu (Kenneth); Wangzhou (B)
>> Subject: [PATCH v3 2/5] PCI: designware: Add ARM64 support
>>
>> This patch tries to unify ARM32 and ARM64 PCIe in designware driver.
>> Delete
>> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct
>> hw_pci,
>> move related operations to dw_pcie_host_init. Also set pp->root_bus_nr
>> = 0 in
>> each PCIe host driver which is based on pcie-designware. This patch
>> also try
>> to use of_pci_get_host_bridge_resources for ARM32 and ARM64 according
>> to the
>> suggestion for Gabriele[1]
>>
>> I tested this patch on D02 board of Hisilicon. It works well.
>> I have compiled the driver with multi_v7_defconfig. However, I don't
>> have
>> ARM32 PCIe related board to do test. It will be appreciated if someone
>> could
>> help to test it.
>>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Tested-by: James Morse <james.morse@arm.com>
>>
>> [1] http://www.spinics.net/lists/linux-pci/msg42194.html
>> ---
>>  drivers/pci/host/pci-dra7xx.c      |   1 +
>>  drivers/pci/host/pci-exynos.c      |   2 +-
>>  drivers/pci/host/pci-imx6.c        |   2 +-
>>  drivers/pci/host/pci-keystone-dw.c |   2 +-
>>  drivers/pci/host/pci-keystone.c    |   2 +-
>>  drivers/pci/host/pci-layerscape.c  |   2 +-
>>  drivers/pci/host/pcie-designware.c | 242 +++++++++++++++--------------
>> --------
>>  drivers/pci/host/pcie-designware.h |  10 +-
>>  drivers/pci/host/pcie-spear13xx.c  |   2 +-
>>  9 files changed, 110 insertions(+), 155 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-
>> dra7xx.c
>> index 2d57e19..5c8b6ab 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -280,6 +280,7 @@ static int __init dra7xx_add_pcie_port(struct
>> dra7xx_pcie *dra7xx,
>>
>>  	pp = &dra7xx->pp;
>>  	pp->dev = dev;
>> +	pp->root_bus_nr = 0;
>>  	pp->ops = &dra7xx_pcie_host_ops;
>>
>>  	pp->irq = platform_get_irq(pdev, 1);
>> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-
>> exynos.c
>> index c139237..4b6db6c 100644
>> --- a/drivers/pci/host/pci-exynos.c
>> +++ b/drivers/pci/host/pci-exynos.c
>> @@ -534,7 +534,7 @@ static int __init exynos_add_pcie_port(struct
>> pcie_port *pp,
>>  		}
>>  	}
>>
>> -	pp->root_bus_nr = -1;
>> +	pp->root_bus_nr = 0;
>>  	pp->ops = &exynos_pcie_host_ops;
>>
>>  	ret = dw_pcie_host_init(pp);
>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> index fdb9536..c4a80c5 100644
>> --- a/drivers/pci/host/pci-imx6.c
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -541,7 +541,7 @@ static int __init imx6_add_pcie_port(struct
>> pcie_port *pp,
>>  		}
>>  	}
>>
>> -	pp->root_bus_nr = -1;
>> +	pp->root_bus_nr = 0;
>>  	pp->ops = &imx6_pcie_host_ops;
>>
>>  	ret = dw_pcie_host_init(pp);
>> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-
>> keystone-dw.c
>> index f34892e..b1e4135 100644
>> --- a/drivers/pci/host/pci-keystone-dw.c
>> +++ b/drivers/pci/host/pci-keystone-dw.c
>> @@ -327,7 +327,7 @@ static void ks_dw_pcie_clear_dbi_mode(void __iomem
>> *reg_virt)
>>  void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>>  {
>>  	struct pcie_port *pp = &ks_pcie->pp;
>> -	u32 start = pp->mem.start, end = pp->mem.end;
>> +	u32 start = pp->mem->start, end = pp->mem->end;
>>  	int i, tr_size;
>>
>>  	/* Disable BARs for inbound access */
>> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-
>> keystone.c
>> index 75333b0..df91f5e 100644
>> --- a/drivers/pci/host/pci-keystone.c
>> +++ b/drivers/pci/host/pci-keystone.c
>> @@ -312,7 +312,7 @@ static int __init ks_add_pcie_port(struct
>> keystone_pcie *ks_pcie,
>>  			return ret;
>>  	}
>>
>> -	pp->root_bus_nr = -1;
>> +	pp->root_bus_nr = 0;
>>  	pp->ops = &keystone_pcie_host_ops;
>>  	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
>>  	if (ret) {
>> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-
>> layerscape.c
>> index 4a6e62f..5c7a9c4 100644
>> --- a/drivers/pci/host/pci-layerscape.c
>> +++ b/drivers/pci/host/pci-layerscape.c
>> @@ -101,7 +101,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
>>  	pp = &pcie->pp;
>>  	pp->dev = pcie->dev;
>>  	pp->dbi_base = pcie->dbi;
>> -	pp->root_bus_nr = -1;
>> +	pp->root_bus_nr = 0;
>>  	pp->ops = &ls_pcie_host_ops;
>>
>>  	ret = dw_pcie_host_init(pp);
>> diff --git a/drivers/pci/host/pcie-designware.c
>> b/drivers/pci/host/pcie-designware.c
>> index 2e9f84f..844febee 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -11,6 +11,7 @@
>>   * published by the Free Software Foundation.
>>   */
>>
>> +#include <linux/hardirq.h>
>>  #include <linux/irq.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/kernel.h>
>> @@ -67,16 +68,7 @@
>>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>>  #define PCIE_ATU_UPPER_TARGET		0x91C
>>
>> -static struct hw_pci dw_pci;
>> -
>> -static unsigned long global_io_offset;
>> -
>> -static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>> -{
>> -	BUG_ON(!sys->private_data);
>> -
>> -	return sys->private_data;
>> -}
>> +static struct pci_ops dw_pcie_ops;
>>
>>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>>  {
>> @@ -238,7 +230,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port
>> *pp, int irq)
>>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>>  {
>>  	int irq, pos0, i;
>> -	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
>> +	struct pcie_port *pp = desc->dev->bus->sysdata;
>>
>>  	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>>  				       order_base_2(no_irqs));
>> @@ -281,7 +273,7 @@ static int dw_msi_setup_irq(struct msi_controller
>> *chip, struct pci_dev *pdev,
>>  {
>>  	int irq, pos;
>>  	struct msi_msg msg;
>> -	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
>> +	struct pcie_port *pp = pdev->bus->sysdata;
>>
>>  	if (desc->msi_attrib.is_msix)
>>  		return -EINVAL;
>> @@ -310,7 +302,7 @@ static void dw_msi_teardown_irq(struct
>> msi_controller *chip, unsigned int irq)
>>  {
>>  	struct irq_data *data = irq_get_irq_data(irq);
>>  	struct msi_desc *msi = irq_data_get_msi(data);
>> -	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
>> +	struct pcie_port *pp = msi->dev->bus->sysdata;
>>
>>  	clear_irq_range(pp, irq, 1, data->hwirq);
>>  }
>> @@ -342,16 +334,24 @@ static const struct irq_domain_ops msi_domain_ops
>> = {
>>  	.map = dw_pcie_msi_map,
>>  };
>>
>> -int dw_pcie_host_init(struct pcie_port *pp)
>> +int __init dw_pcie_host_init(struct pcie_port *pp)
>>  {
>>  	struct device_node *np = pp->dev->of_node;
>>  	struct platform_device *pdev = to_platform_device(pp->dev);
>> -	struct of_pci_range range;
>> -	struct of_pci_range_parser parser;
>> +	struct pci_bus *bus;
>>  	struct resource *cfg_res;
>> +	LIST_HEAD(res);
>>  	u32 val, na, ns;
>>  	const __be32 *addrp;
>>  	int i, index, ret;
>> +	int rlen;
>> +	struct resource_entry *win;
>> +	const __be32 *parser_range_end = of_get_property(np, "ranges",
>> &rlen);
>> +
>> +	if (parser_range_end == NULL)
>> +			return -ENOENT;
>> +	parser_range_end += rlen/sizeof(__be32);
>> +
>>
>>  	/* Find the address cell size and the number of cells in order to
>> get
>>  	 * the untranslated address.
>> @@ -375,78 +375,67 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  		dev_err(pp->dev, "missing *config* reg space\n");
>>  	}
>>
>> -	if (of_pci_range_parser_init(&parser, np)) {
>> -		dev_err(pp->dev, "missing ranges property\n");
>> -		return -EINVAL;
>> -	}
>> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp-
>>> io_base);
>> +	if (ret)
>> +		return ret;
>>
>>  	/* Get the I/O and memory ranges from DT */
>> -	for_each_of_pci_range(&parser, &range) {
>> -		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
>> -
>> -		if (restype == IORESOURCE_IO) {
>> -			of_pci_range_to_resource(&range, np, &pp->io);
>> -			pp->io.name = "I/O";
>> -			pp->io.start = max_t(resource_size_t,
>> -					     PCIBIOS_MIN_IO,
>> -					     range.pci_addr + global_io_offset);
>> -			pp->io.end = min_t(resource_size_t,
>> -					   IO_SPACE_LIMIT,
>> -					   range.pci_addr + range.size
>> -					   + global_io_offset - 1);
>> -			pp->io_size = resource_size(&pp->io);
>> -			pp->io_bus_addr = range.pci_addr;
>> -			pp->io_base = range.cpu_addr;
>> -
>> -			/* Find the untranslated IO space address */
>> -			pp->io_mod_base = of_read_number(parser.range -
>> -							 parser.np + na, ns);
>> -		}
>> -		if (restype == IORESOURCE_MEM) {
>> -			of_pci_range_to_resource(&range, np, &pp->mem);
>> -			pp->mem.name = "MEM";
>> -			pp->mem_size = resource_size(&pp->mem);
>> -			pp->mem_bus_addr = range.pci_addr;
>> -
>> -			/* Find the untranslated MEM space address */
>> -			pp->mem_mod_base = of_read_number(parser.range -
>> -							  parser.np + na, ns);
>> -		}
>> -		if (restype == 0) {
>> -			of_pci_range_to_resource(&range, np, &pp->cfg);
>> -			pp->cfg0_size = resource_size(&pp->cfg)/2;
>> -			pp->cfg1_size = resource_size(&pp->cfg)/2;
>> -			pp->cfg0_base = pp->cfg.start;
>> -			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
>> +	resource_list_for_each_entry(win, &res) {
>> +		switch (resource_type(win->res)) {
>> +		case IORESOURCE_IO:
>> +			pp->io = win->res;
>> +			pp->io->name = "I/O";
>> +			pp->io_size = resource_size(pp->io);
>> +			pp->io_bus_addr = pp->io->start - win->offset;
>> +			/* magic 5 below comes from magic na and ns in
>> +			 * of_pci_range_parser_init()                 */
>> +			pp->io_mod_base = of_read_number(parser_range_end -
>> +					of_n_addr_cells(np) - 5 + na, ns);
>> +			ret = pci_remap_iospace(pp->io, pp->io_base);
>> +			if (ret) {
>> +				dev_warn(pp->dev, "error %d: failed to map
>> resource %pR\n",
>> +				ret, pp->io);
>> +			continue;
>> +			}
>> +			break;
>> +		case IORESOURCE_MEM:
>> +			pp->mem = win->res;
>> +			pp->mem->name = "MEM";
>> +			pp->mem_size = resource_size(pp->mem);
>> +			pp->mem_bus_addr = pp->mem->start - win->offset;
>> +			pp->mem_mod_base = of_read_number(parser_range_end -
>> +					of_n_addr_cells(np) - 5 + na, ns);
>> +			break;
>> +		case 0:
>> +			pp->cfg = win->res;
>> +			pp->cfg0_size = resource_size(pp->cfg)/2;
>> +			pp->cfg1_size = resource_size(pp->cfg)/2;
>> +			pp->cfg0_base = pp->cfg->start;
>> +			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
>>
>>  			/* Find the untranslated configuration space address
>> */
>> -			pp->cfg0_mod_base = of_read_number(parser.range -
>> -							   parser.np + na, ns);
>> -			pp->cfg1_mod_base = pp->cfg0_mod_base +
>> -					    pp->cfg0_size;
>> +			pp->cfg0_mod_base = of_read_number(parser_range_end -
>> +					of_n_addr_cells(np) - 5 + na, ns);
>> +			pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
>> +			break;
>> +		case IORESOURCE_BUS:
>> +			pp->busn = win->res;
>> +			break;
>> +		default:
>> +			continue;
>>  		}
>>  	}
>>
>> -	ret = of_pci_parse_bus_range(np, &pp->busn);
>> -	if (ret < 0) {
>> -		pp->busn.name = np->name;
>> -		pp->busn.start = 0;
>> -		pp->busn.end = 0xff;
>> -		pp->busn.flags = IORESOURCE_BUS;
>> -		dev_dbg(pp->dev, "failed to parse bus-range property: %d,
>> using default %pR\n",
>> -			ret, &pp->busn);
>> -	}
>> -
>>  	if (!pp->dbi_base) {
>> -		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
>> -					resource_size(&pp->cfg));
>> +		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
>> +					resource_size(pp->cfg));
>>  		if (!pp->dbi_base) {
>>  			dev_err(pp->dev, "error with ioremap\n");
>>  			return -ENOMEM;
>>  		}
>>  	}
>>
>> -	pp->mem_base = pp->mem.start;
>> +	pp->mem_base = pp->mem->start;
>>
>>  	if (!pp->va_cfg0_base) {
>>  		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
>> @@ -493,24 +482,47 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  	if (pp->ops->host_init)
>>  		pp->ops->host_init(pp);
>>
>> -	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>> +	if (dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0)
>> +			!= PCIBIOS_SUCCESSFUL)
>> +		return -EINVAL;
>>
>>  	/* program correct class for RC */
>> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2,
>> PCI_CLASS_BRIDGE_PCI);
>> +	if (dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2,
>> PCI_CLASS_BRIDGE_PCI)
>> +			!= PCIBIOS_SUCCESSFUL)
>> +		return -EINVAL;
>> +
>> +	if (dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4,
>> &val)
>> +			!= PCIBIOS_SUCCESSFUL)
>> +		return -EINVAL;
>>
>> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
>>  	val |= PORT_LOGIC_SPEED_CHANGE;
>> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>>
>> -#ifdef CONFIG_PCI_MSI
>> -	dw_pcie_msi_chip.dev = pp->dev;
>> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
>> +	if (dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val)
>> +			!= PCIBIOS_SUCCESSFUL)
>> +		return -EINVAL;
>> +
>> +	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
>> +			      pp, &res);
>> +	if (!bus)
>> +		return -ENOMEM;
>> +
>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> +	bus->msi = container_of(&pp->irq_domain, struct msi_controller,
>> domain);
>> +#else
>> +	bus->msi = &dw_pcie_msi_chip;
>>  #endif
>>
>> -	dw_pci.nr_controllers = 1;
>> -	dw_pci.private_data = (void **)&pp;
>> +	pci_scan_child_bus(bus);
>> +	if (pp->ops->scan_bus)
>> +		pp->ops->scan_bus(pp);
>>
>> -	pci_common_init_dev(pp->dev, &dw_pci);
>> +#ifdef CONFIG_ARM
>> +	/* support old dtbs that incorrectly describe IRQs */
>> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>> +#endif
>> +
>> +	pci_assign_unassigned_bus_resources(bus);
>> +	pci_bus_add_devices(bus);
>>
>>  	return 0;
>>  }
>> @@ -653,7 +665,7 @@ static int dw_pcie_valid_config(struct pcie_port
>> *pp,
>>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>>  			int size, u32 *val)
>>  {
>> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
>> +	struct pcie_port *pp = bus->sysdata;
>>  	int ret;
>>
>>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
>> @@ -677,7 +689,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32
>> devfn, int where,
>>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>>  			int where, int size, u32 val)
>>  {
>> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
>> +	struct pcie_port *pp = bus->sysdata;
>>  	int ret;
>>
>>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
>> @@ -701,64 +713,6 @@ static struct pci_ops dw_pcie_ops = {
>>  	.write = dw_pcie_wr_conf,
>>  };
>>
>> -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
>> -{
>> -	struct pcie_port *pp;
>> -
>> -	pp = sys_to_pcie(sys);
>> -
>> -	if (global_io_offset < SZ_1M && pp->io_size > 0) {
>> -		sys->io_offset = global_io_offset - pp->io_bus_addr;
>> -		pci_ioremap_io(global_io_offset, pp->io_base);
>> -		global_io_offset += SZ_64K;
>> -		pci_add_resource_offset(&sys->resources, &pp->io,
>> -					sys->io_offset);
>> -	}
>> -
>> -	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
>> -	pci_add_resource_offset(&sys->resources, &pp->mem, sys-
>>> mem_offset);
>> -	pci_add_resource(&sys->resources, &pp->busn);
>> -
>> -	return 1;
>> -}
>> -
>> -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data
>> *sys)
>> -{
>> -	struct pci_bus *bus;
>> -	struct pcie_port *pp = sys_to_pcie(sys);
>> -
>> -	pp->root_bus_nr = sys->busnr;
>> -	bus = pci_create_root_bus(pp->dev, sys->busnr,
>> -				  &dw_pcie_ops, sys, &sys->resources);
>> -	if (!bus)
>> -		return NULL;
>> -
>> -	pci_scan_child_bus(bus);
>> -
>> -	if (bus && pp->ops->scan_bus)
>> -		pp->ops->scan_bus(pp);
>> -
>> -	return bus;
>> -}
>> -
>> -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>> -{
>> -	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
>> -	int irq;
>> -
>> -	irq = of_irq_parse_and_map_pci(dev, slot, pin);
>> -	if (!irq)
>> -		irq = pp->irq;
>> -
>> -	return irq;
>> -}
>> -
>> -static struct hw_pci dw_pci = {
>> -	.setup		= dw_pcie_setup,
>> -	.scan		= dw_pcie_scan_bus,
>> -	.map_irq	= dw_pcie_map_irq,
>> -};
>> -
>>  void dw_pcie_setup_rc(struct pcie_port *pp)
>>  {
>>  	u32 val;
>> diff --git a/drivers/pci/host/pcie-designware.h
>> b/drivers/pci/host/pcie-designware.h
>> index d0bbd27..ab78710 100644
>> --- a/drivers/pci/host/pcie-designware.h
>> +++ b/drivers/pci/host/pcie-designware.h
>> @@ -34,7 +34,7 @@ struct pcie_port {
>>  	u64			cfg1_mod_base;
>>  	void __iomem		*va_cfg1_base;
>>  	u32			cfg1_size;
>> -	u64			io_base;
>> +	resource_size_t			io_base;
>>  	u64			io_mod_base;
>>  	phys_addr_t		io_bus_addr;
>>  	u32			io_size;
>> @@ -42,10 +42,10 @@ struct pcie_port {
>>  	u64			mem_mod_base;
>>  	phys_addr_t		mem_bus_addr;
>>  	u32			mem_size;
>> -	struct resource		cfg;
>> -	struct resource		io;
>> -	struct resource		mem;
>> -	struct resource		busn;
>> +	struct resource		*cfg;
>> +	struct resource		*io;
>> +	struct resource		*mem;
>> +	struct resource		*busn;
>>  	int			irq;
>>  	u32			lanes;
>>  	struct pcie_host_ops	*ops;
>> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-
>> spear13xx.c
>> index 020d788..e78ddf8 100644
>> --- a/drivers/pci/host/pcie-spear13xx.c
>> +++ b/drivers/pci/host/pcie-spear13xx.c
>> @@ -287,7 +287,7 @@ static int spear13xx_add_pcie_port(struct pcie_port
>> *pp,
>>  		return ret;
>>  	}
>>
>> -	pp->root_bus_nr = -1;
>> +	pp->root_bus_nr = 0;
>>  	pp->ops = &spear13xx_pcie_host_ops;
>>
>>  	ret = dw_pcie_host_init(pp);
>> --
>> 1.9.1
> 


