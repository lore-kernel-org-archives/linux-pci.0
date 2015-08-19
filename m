Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53032 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbHSPh1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 11:37:27 -0400
Message-ID: <1439998622.31432.44.camel@pengutronix.de>
Subject: Re: [PATCH v7 3/6] PCI: designware: Add ARM64 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Date: Wed, 19 Aug 2015 17:37:02 +0200
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D81315@lhreml503-mbs>
References: <1439812554-180426-1-git-send-email-wangzhou1@hisilicon.com>
	 <1439812554-180426-4-git-send-email-wangzhou1@hisilicon.com>
	 <1439988852.31432.15.camel@pengutronix.de>
	 <EE11001F9E5DDD47B7634E2F8A612F2E01D81315@lhreml503-mbs>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gab,

Am Mittwoch, den 19.08.2015, 15:16 +0000 schrieb Gabriele Paoloni:
> Hi Lucas
> 
> I have rewritten the patch to take into account multiple controllers.
> 
> As you can see now there is a static var in dw_pcie_host_init() that tracks
> the bus numbers used.

This is wrong. The DT specifies the valid bus number range. You can not
just assign the next free bus number to the root bus.

It is perfectly valid to have a bus range of 0x00-0x10 assigned to one
instance and 0x50-0xff to the next instance. Additional with PCIe
hotplug you may not use the full range of the bus numbers on one
instance at the first scan, but only later populate more buses when more
bridges are added to the tree.

> Drivers that do not specify the bus range in the DTB set pp->root_bus_nr = DW_ROOT_NR_UNDEFINED.
> Designware will check if the flag is set and will use the automatic bus range
> assignment.

No, please lets get rid of this assignment altogether. The glue drivers
have no business in assigning the bus range. Please remove the
pp->root_bus_nr assignment from all the glue drivers.

"bus range" is a generic DW PCIe property, so just parse the root bus
number from the DT, it is handled the same way for all the DW based PCIe
drivers. The bindings specifies that if the bus range property is
missing the range is 0x00-0xff, so you can default to 0 as the root bus
number in that case.

Also I would think this conversion warrants a patch on its own and
should not be mixed in the ARM64 support patch.

Regards,
Lucas

> Instead if the driver assigns pp->root_bus_nr according to the dtb, designwware
> will use the value passed in by the driver.
> Below the relevant section:
> 
> 
> +	static int root_bus_nr = 0;
> ...
> +	mutex_lock(&root_bus_nr_mux);
> +
> +	if (pp->root_bus_nr != DW_ROOT_NR_UNDEFINED)
> +		root_bus_nr = pp->root_bus_nr;
> +
> +	bus = pci_create_root_bus(pp->dev, root_bus_nr, &dw_pcie_ops,
> +			      pp, &res);
> +	if (!bus) {
> +		mutex_unlock(&root_bus_nr_mux);
> +		return -ENOMEM;
> +	}
> +
> +	root_bus_nr += bus->busn_res.end + 1;
> +	mutex_unlock(&root_bus_nr_mux);
> 
> Please let me know what you think...
> 
> Many Thanks
> 
> Gab
> ----------
> 
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
> move related operations to dw_pcie_host_init.
> Also set pp->root_bus_nr = DW_ROOT_NR_UNDEFINED in all the drivers that
> are based on designware to flag that the drivers do not read the bus
> ranges from DT.
> This patch also adds handling of multiple PCI domains in designware.
> if the PCI host bridge driver does not specify a root bus number, in case
> of multiple domains, designware will automatillay set the next domain root
> bus number to the last bus number used in the last domain + 1.
> 
> This patch also try to use of_pci_get_host_bridge_resources for ARM32 and
> ARM64 according to the suggestion for Gabriele[1]
> 
> This patch is based on Gabriele's patch about of_pci_range fix[2]
> 
> Finally this patch reverts commit f4c55c5a3f7f "PCI: designware:
> Program ATU with untranslated address". This was discussed in [3]
> 
> I have compiled the driver with multi_v7_defconfig. However, I don't have
> ARM32 PCIe related board to do test. It will be appreciated if someone could
> help to test it.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> 
> [1] http://www.spinics.net/lists/linux-pci/msg42194.html
> [2] https://patchwork.ozlabs.org/patch/495018/
> [3] http://www.spinics.net/lists/arm-kernel/msg436779.html
> ---
>  drivers/pci/host/pci-dra7xx.c      |  15 +--
>  drivers/pci/host/pci-exynos.c      |   2 +-
>  drivers/pci/host/pci-imx6.c        |   2 +-
>  drivers/pci/host/pci-keystone-dw.c |   2 +-
>  drivers/pci/host/pci-keystone.c    |   2 +-
>  drivers/pci/host/pci-layerscape.c  |   2 +-
>  drivers/pci/host/pcie-designware.c | 247 ++++++++++++++-----------------------
>  drivers/pci/host/pcie-designware.h |  15 +--
>  drivers/pci/host/pcie-spear13xx.c  |   2 +-
>  9 files changed, 110 insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 5678b57..8d598fb 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -141,15 +141,15 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
>  {
>  	dw_pcie_setup_rc(pp);
>  
> -	if (pp->io_mod_base)
> -		pp->io_mod_base &= CPU_TO_BUS_ADDR;
> +	if (pp->io_base)
> +		pp->io_base &= CPU_TO_BUS_ADDR;
>  
> -	if (pp->mem_mod_base)
> -		pp->mem_mod_base &= CPU_TO_BUS_ADDR;
> +	if (pp->mem_base)
> +		pp->mem_base &= CPU_TO_BUS_ADDR;
>  
> -	if (pp->cfg0_mod_base) {
> -		pp->cfg0_mod_base &= CPU_TO_BUS_ADDR;
> -		pp->cfg1_mod_base &= CPU_TO_BUS_ADDR;
> +	if (pp->cfg0_base) {
> +		pp->cfg0_base &= CPU_TO_BUS_ADDR;
> +		pp->cfg1_base &= CPU_TO_BUS_ADDR;
>  	}
>  
>  	dra7xx_pcie_establish_link(pp);
> @@ -288,6 +288,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  
>  	pp = &dra7xx->pp;
>  	pp->dev = dev;
> +	pp->root_bus_nr = DW_ROOT_NR_UNDEFINED;
>  	pp->ops = &dra7xx_pcie_host_ops;
>  
>  	pp->irq = platform_get_irq(pdev, 1);
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index f9f468d..ed03a8f 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -530,7 +530,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
>  		}
>  	}
>  
> -	pp->root_bus_nr = -1;
> +	pp->root_bus_nr = DW_ROOT_NR_UNDEFINED;
>  	pp->ops = &exynos_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233a196..0efac85 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -551,7 +551,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  		}
>  	}
>  
> -	pp->root_bus_nr = -1;
> +	pp->root_bus_nr = DW_ROOT_NR_UNDEFINED;
>  	pp->ops = &imx6_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index f34892e..b1e4135 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -327,7 +327,7 @@ static void ks_dw_pcie_clear_dbi_mode(void __iomem *reg_virt)
>  void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
>  {
>  	struct pcie_port *pp = &ks_pcie->pp;
> -	u32 start = pp->mem.start, end = pp->mem.end;
> +	u32 start = pp->mem->start, end = pp->mem->end;
>  	int i, tr_size;
>  
>  	/* Disable BARs for inbound access */
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 734da58..b522956 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -309,7 +309,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>  			return ret;
>  	}
>  
> -	pp->root_bus_nr = -1;
> +	pp->root_bus_nr = DW_ROOT_NR_UNDEFINED;
>  	pp->ops = &keystone_pcie_host_ops;
>  	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
>  	if (ret) {
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index b2328ea1..dd92ffa 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -106,7 +106,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
>  	pp = &pcie->pp;
>  	pp->dev = pcie->dev;
>  	pp->dbi_base = pcie->dbi;
> -	pp->root_bus_nr = -1;
> +	pp->root_bus_nr = DW_ROOT_NR_UNDEFINED;
>  	pp->ops = &ls_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 5307b35..bd2606b 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -11,6 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/hardirq.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> @@ -69,16 +70,9 @@
>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
> -static struct hw_pci dw_pci;
> +static struct pci_ops dw_pcie_ops;
>  
> -static unsigned long global_io_offset;
> -
> -static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
> -{
> -	BUG_ON(!sys->private_data);
> -
> -	return sys->private_data;
> -}
> +DEFINE_MUTEX(root_bus_nr_mux);
>  
>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
> @@ -255,7 +249,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>  {
>  	int irq, pos0, i;
> -	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
> +	struct pcie_port *pp = desc->dev->bus->sysdata;
>  
>  	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>  				       order_base_2(no_irqs));
> @@ -298,7 +292,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>  {
>  	int irq, pos;
>  	struct msi_msg msg;
> -	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> +	struct pcie_port *pp = pdev->bus->sysdata;
>  
>  	if (desc->msi_attrib.is_msix)
>  		return -EINVAL;
> @@ -327,7 +321,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
>  {
>  	struct irq_data *data = irq_get_irq_data(irq);
>  	struct msi_desc *msi = irq_data_get_msi(data);
> -	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
> +	struct pcie_port *pp = msi->dev->bus->sysdata;
>  
>  	clear_irq_range(pp, irq, 1, data->hwirq);
>  }
> @@ -359,22 +353,17 @@ static const struct irq_domain_ops msi_domain_ops = {
>  	.map = dw_pcie_msi_map,
>  };
>  
> -int dw_pcie_host_init(struct pcie_port *pp)
> +int __init dw_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct device_node *np = pp->dev->of_node;
>  	struct platform_device *pdev = to_platform_device(pp->dev);
> -	struct of_pci_range range;
> -	struct of_pci_range_parser parser;
> +	struct pci_bus *bus;
>  	struct resource *cfg_res;
> -	u32 val, na, ns;
> -	const __be32 *addrp;
> -	int i, index, ret;
> -
> -	/* Find the address cell size and the number of cells in order to get
> -	 * the untranslated address.
> -	 */
> -	of_property_read_u32(np, "#address-cells", &na);
> -	ns = of_n_size_cells(np);
> +	LIST_HEAD(res);
> +	u32 val;
> +	int i, ret;
> +	struct resource_entry *win;
> +	static int root_bus_nr = 0;
>  
>  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (cfg_res) {
> @@ -382,85 +371,60 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		pp->cfg1_size = resource_size(cfg_res)/2;
>  		pp->cfg0_base = cfg_res->start;
>  		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
> -
> -		/* Find the untranslated configuration space address */
> -		index = of_property_match_string(np, "reg-names", "config");
> -		addrp = of_get_address(np, index, NULL, NULL);
> -		pp->cfg0_mod_base = of_read_number(addrp, ns);
> -		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
>  	} else {
>  		dev_err(pp->dev, "missing *config* reg space\n");
>  	}
>  
> -	if (of_pci_range_parser_init(&parser, np)) {
> -		dev_err(pp->dev, "missing ranges property\n");
> -		return -EINVAL;
> -	}
> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> +	if (ret)
> +		return ret;
>  
>  	/* Get the I/O and memory ranges from DT */
> -	for_each_of_pci_range(&parser, &range) {
> -		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> -
> -		if (restype == IORESOURCE_IO) {
> -			of_pci_range_to_resource(&range, np, &pp->io);
> -			pp->io.name = "I/O";
> -			pp->io.start = max_t(resource_size_t,
> -					     PCIBIOS_MIN_IO,
> -					     range.pci_addr + global_io_offset);
> -			pp->io.end = min_t(resource_size_t,
> -					   IO_SPACE_LIMIT,
> -					   range.pci_addr + range.size
> -					   + global_io_offset - 1);
> -			pp->io_size = resource_size(&pp->io);
> -			pp->io_bus_addr = range.pci_addr;
> -			pp->io_base = range.cpu_addr;
> -
> -			/* Find the untranslated IO space address */
> -			pp->io_mod_base = range.cpu_addr;
> -		}
> -		if (restype == IORESOURCE_MEM) {
> -			of_pci_range_to_resource(&range, np, &pp->mem);
> -			pp->mem.name = "MEM";
> -			pp->mem_size = resource_size(&pp->mem);
> -			pp->mem_bus_addr = range.pci_addr;
> -
> -			/* Find the untranslated MEM space address */
> -			pp->mem_mod_base = range.cpu_addr;
> -		}
> -		if (restype == 0) {
> -			of_pci_range_to_resource(&range, np, &pp->cfg);
> -			pp->cfg0_size = resource_size(&pp->cfg)/2;
> -			pp->cfg1_size = resource_size(&pp->cfg)/2;
> -			pp->cfg0_base = pp->cfg.start;
> -			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> -
> -			/* Find the untranslated configuration space address */
> -			pp->cfg0_mod_base = range.cpu_addr;
> -			pp->cfg1_mod_base = pp->cfg0_mod_base +
> -					    pp->cfg0_size;
> +	resource_list_for_each_entry(win, &res) {
> +		switch (resource_type(win->res)) {
> +		case IORESOURCE_IO:
> +			pp->io = win->res;
> +			pp->io->name = "I/O";
> +			pp->io_size = resource_size(pp->io);
> +			pp->io_bus_addr = pp->io->start - win->offset;
> +			ret = pci_remap_iospace(pp->io, pp->io_base);
> +			if (ret) {
> +				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
> +					 ret, pp->io);
> +				continue;
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			pp->mem = win->res;
> +			pp->mem->name = "MEM";
> +			pp->mem_size = resource_size(pp->mem);
> +			pp->mem_bus_addr = pp->mem->start - win->offset;
> +			break;
> +		case 0:
> +			pp->cfg = win->res;
> +			pp->cfg0_size = resource_size(pp->cfg)/2;
> +			pp->cfg1_size = resource_size(pp->cfg)/2;
> +			pp->cfg0_base = pp->cfg->start;
> +			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> +			break;
> +		case IORESOURCE_BUS:
> +			pp->busn = win->res;
> +			break;
> +		default:
> +			continue;
>  		}
>  	}
>  
> -	ret = of_pci_parse_bus_range(np, &pp->busn);
> -	if (ret < 0) {
> -		pp->busn.name = np->name;
> -		pp->busn.start = 0;
> -		pp->busn.end = 0xff;
> -		pp->busn.flags = IORESOURCE_BUS;
> -		dev_dbg(pp->dev, "failed to parse bus-range property: %d, using default %pR\n",
> -			ret, &pp->busn);
> -	}
> -
>  	if (!pp->dbi_base) {
> -		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
> -					resource_size(&pp->cfg));
> +		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
> +					resource_size(pp->cfg));
>  		if (!pp->dbi_base) {
>  			dev_err(pp->dev, "error with ioremap\n");
>  			return -ENOMEM;
>  		}
>  	}
>  
> -	pp->mem_base = pp->mem.start;
> +	pp->mem_base = pp->mem->start;
>  
>  	if (!pp->va_cfg0_base) {
>  		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> @@ -509,7 +473,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  
>  	if (!pp->ops->rd_other_conf)
>  		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
> +					  PCIE_ATU_TYPE_MEM, pp->mem_base,
>  					  pp->mem_bus_addr, pp->mem_size);
>  
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> @@ -521,15 +485,40 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  
> -#ifdef CONFIG_PCI_MSI
>  	dw_pcie_msi_chip.dev = pp->dev;
> -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> +
> +	mutex_lock(&root_bus_nr_mux);
> +
> +	if (pp->root_bus_nr != DW_ROOT_NR_UNDEFINED)
> +		root_bus_nr = pp->root_bus_nr;
> +
> +	bus = pci_create_root_bus(pp->dev, root_bus_nr, &dw_pcie_ops,
> +			      pp, &res);
> +	if (!bus) {
> +		mutex_unlock(&root_bus_nr_mux);
> +		return -ENOMEM;
> +	}
> +
> +	root_bus_nr += bus->busn_res.end + 1;
> +	mutex_unlock(&root_bus_nr_mux);
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
> +
> +#ifdef CONFIG_ARM
> +	/* support old dtbs that incorrectly describe IRQs */
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
>  
> -	pci_common_init_dev(pp->dev, &dw_pci);
> +	pci_assign_unassigned_bus_resources(bus);
> +	pci_bus_add_devices(bus);
>  
>  	return 0;
>  }
> @@ -548,12 +537,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		type = PCIE_ATU_TYPE_CFG0;
> -		cpu_addr = pp->cfg0_mod_base;
> +		cpu_addr = pp->cfg0_base;
>  		cfg_size = pp->cfg0_size;
>  		va_cfg_base = pp->va_cfg0_base;
>  	} else {
>  		type = PCIE_ATU_TYPE_CFG1;
> -		cpu_addr = pp->cfg1_mod_base;
> +		cpu_addr = pp->cfg1_base;
>  		cfg_size = pp->cfg1_size;
>  		va_cfg_base = pp->va_cfg1_base;
>  	}
> @@ -563,7 +552,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  				  busdev, cfg_size);
>  	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
>  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> -				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
> +				  PCIE_ATU_TYPE_IO, pp->io_base,
>  				  pp->io_bus_addr, pp->io_size);
>  
>  	return ret;
> @@ -583,12 +572,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  
>  	if (bus->parent->number == pp->root_bus_nr) {
>  		type = PCIE_ATU_TYPE_CFG0;
> -		cpu_addr = pp->cfg0_mod_base;
> +		cpu_addr = pp->cfg0_base;
>  		cfg_size = pp->cfg0_size;
>  		va_cfg_base = pp->va_cfg0_base;
>  	} else {
>  		type = PCIE_ATU_TYPE_CFG1;
> -		cpu_addr = pp->cfg1_mod_base;
> +		cpu_addr = pp->cfg1_base;
>  		cfg_size = pp->cfg1_size;
>  		va_cfg_base = pp->va_cfg1_base;
>  	}
> @@ -598,7 +587,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  				  busdev, cfg_size);
>  	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
>  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> -				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
> +				  PCIE_ATU_TYPE_IO, pp->io_base,
>  				  pp->io_bus_addr, pp->io_size);
>  
>  	return ret;
> @@ -630,7 +619,7 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  			int size, u32 *val)
>  {
> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> +	struct pcie_port *pp = bus->sysdata;
>  	int ret;
>  
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> @@ -654,7 +643,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  			int where, int size, u32 val)
>  {
> -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> +	struct pcie_port *pp = bus->sysdata;
>  	int ret;
>  
>  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> @@ -678,62 +667,6 @@ static struct pci_ops dw_pcie_ops = {
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
> -	bus = pci_scan_root_bus(pp->dev, sys->busnr,
> -				  &dw_pcie_ops, sys, &sys->resources);
> -	if (!bus)
> -		return NULL;
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
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index d0bbd27..0c2a7eb 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -21,31 +21,28 @@
>   */
>  #define MAX_MSI_IRQS			32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
> +#define DW_ROOT_NR_UNDEFINED	-1
>  
>  struct pcie_port {
>  	struct device		*dev;
>  	u8			root_bus_nr;
>  	void __iomem		*dbi_base;
>  	u64			cfg0_base;
> -	u64			cfg0_mod_base;
>  	void __iomem		*va_cfg0_base;
>  	u32			cfg0_size;
>  	u64			cfg1_base;
> -	u64			cfg1_mod_base;
>  	void __iomem		*va_cfg1_base;
>  	u32			cfg1_size;
> -	u64			io_base;
> -	u64			io_mod_base;
> +	resource_size_t		io_base;
>  	phys_addr_t		io_bus_addr;
>  	u32			io_size;
>  	u64			mem_base;
> -	u64			mem_mod_base;
>  	phys_addr_t		mem_bus_addr;
>  	u32			mem_size;
> -	struct resource		cfg;
> -	struct resource		io;
> -	struct resource		mem;
> -	struct resource		busn;
> +	struct resource		*cfg;
> +	struct resource		*io;
> +	struct resource		*mem;
> +	struct resource		*busn;
>  	int			irq;
>  	u32			lanes;
>  	struct pcie_host_ops	*ops;
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index c49fbdc..b2c59b9 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -286,7 +286,7 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
>  		return ret;
>  	}
>  
> -	pp->root_bus_nr = -1;
> +	pp->root_bus_nr = DW_ROOT_NR_UNDEFINED;
>  	pp->ops = &spear13xx_pcie_host_ops;
>  
>  	ret = dw_pcie_host_init(pp);
> -- 
> 1.9.1
> 
> 
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: Wednesday, August 19, 2015 1:54 PM
> > To: Wangzhou (B)
> > Cc: Bjorn Helgaas; jingoohan1@gmail.com; Pratyush Anand; Arnd Bergmann;
> > linux@arm.linux.org.uk; thomas.petazzoni@free-electrons.com; Gabriele
> > Paoloni; lorenzo.pieralisi@arm.com; james.morse@arm.com;
> > Liviu.Dudau@arm.com; jason@lakedaemon.net; robh@kernel.org; linux-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> > qiuzhenfa; liudongdong (C); qiujiang; xuwei (O); Liguozhu (Kenneth)
> > Subject: Re: [PATCH v7 3/6] PCI: designware: Add ARM64 support
> > 
> > Am Montag, den 17.08.2015, 19:55 +0800 schrieb Zhou Wang:
> > > This patch tries to unify ARM32 and ARM64 PCIe in designware driver.
> > Delete
> > > function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct
> > hw_pci,
> > > move related operations to dw_pcie_host_init.
> > >
> > > In past, we use:
> > > pci_common_init_dev
> > > 	-> pcibios_init_hw
> > > 		-> hw->scan (dw_pcie_scan_bus)
> > > to pass 0 to root_bus_nr in struct pcie_port. This patch set pp-
> > >root_bus_nr = 0
> > > in each PCIe host driver which is based on pcie-designware.
> > >
> > This is incorrect at least if there are 2 instances of DW PCIe host in
> > the same SoC without using PCI domains. In that the case the bus range
> > determines the range of valid bus numbers per instance and the first
> > number is the root bus. Please look at the "bus-range" DT property in
> > the DW PCIe bindings.
> > 
> > Also we should finally remove this root-bus setup from the glue drivers
> > altogether. It's something that entirely belongs into the DW core code.
> > 
> > Regards,
> > Lucas
> > 
> > > This patch also try to use of_pci_get_host_bridge_resources for ARM32
> > and ARM64
> > > according to the suggestion for Gabriele[1]
> > >
> > > Finally this patch reverts commit f4c55c5a3f7f "PCI: designware:
> > Program ATU
> > > with untranslated address" based on 1/6 in this series. we delete
> > *_mod_base in
> > > pcie-designware. This was discussed in [2]
> > >
> > > I have compiled the driver with multi_v7_defconfig. However, I don't
> > have
> > > ARM32 PCIe related board to do test. It will be appreciated if
> > someone could
> > > help to test it.
> > >
> > > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Tested-By: James Morse <james.morse@arm.com>
> > >
> > > [1] http://www.spinics.net/lists/linux-pci/msg42194.html
> > > [2] http://www.spinics.net/lists/arm-kernel/msg436779.html
> > > ---
> > >  drivers/pci/host/pci-dra7xx.c      |  15 +--
> > >  drivers/pci/host/pci-exynos.c      |   2 +-
> > >  drivers/pci/host/pci-imx6.c        |   2 +-
> > >  drivers/pci/host/pci-keystone-dw.c |   2 +-
> > >  drivers/pci/host/pci-keystone.c    |   2 +-
> > >  drivers/pci/host/pci-layerscape.c  |   2 +-
> > >  drivers/pci/host/pcie-designware.c | 229 ++++++++++++---------------
> > ----------
> > >  drivers/pci/host/pcie-designware.h |  14 +--
> > >  drivers/pci/host/pcie-spear13xx.c  |   2 +-
> > >  9 files changed, 95 insertions(+), 175 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-
> > dra7xx.c
> > > index 18ae7ff..1268c69 100644
> > > --- a/drivers/pci/host/pci-dra7xx.c
> > > +++ b/drivers/pci/host/pci-dra7xx.c
> > > @@ -141,15 +141,15 @@ static void dra7xx_pcie_host_init(struct
> > pcie_port *pp)
> > >  {
> > >  	dw_pcie_setup_rc(pp);
> > >
> > > -	if (pp->io_mod_base)
> > > -		pp->io_mod_base &= CPU_TO_BUS_ADDR;
> > > +	if (pp->io_base)
> > > +		pp->io_base &= CPU_TO_BUS_ADDR;
> > >
> > > -	if (pp->mem_mod_base)
> > > -		pp->mem_mod_base &= CPU_TO_BUS_ADDR;
> > > +	if (pp->mem_base)
> > > +		pp->mem_base &= CPU_TO_BUS_ADDR;
> > >
> > > -	if (pp->cfg0_mod_base) {
> > > -		pp->cfg0_mod_base &= CPU_TO_BUS_ADDR;
> > > -		pp->cfg1_mod_base &= CPU_TO_BUS_ADDR;
> > > +	if (pp->cfg0_base) {
> > > +		pp->cfg0_base &= CPU_TO_BUS_ADDR;
> > > +		pp->cfg1_base &= CPU_TO_BUS_ADDR;
> > >  	}
> > >
> > >  	dra7xx_pcie_establish_link(pp);
> > > @@ -288,6 +288,7 @@ static int __init dra7xx_add_pcie_port(struct
> > dra7xx_pcie *dra7xx,
> > >
> > >  	pp = &dra7xx->pp;
> > >  	pp->dev = dev;
> > > +	pp->root_bus_nr = 0;
> > >  	pp->ops = &dra7xx_pcie_host_ops;
> > >
> > >  	pp->irq = platform_get_irq(pdev, 1);
> > > diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-
> > exynos.c
> > > index f9f468d..9771bb0 100644
> > > --- a/drivers/pci/host/pci-exynos.c
> > > +++ b/drivers/pci/host/pci-exynos.c
> > > @@ -530,7 +530,7 @@ static int __init exynos_add_pcie_port(struct
> > pcie_port *pp,
> > >  		}
> > >  	}
> > >
> > > -	pp->root_bus_nr = -1;
> > > +	pp->root_bus_nr = 0;
> > >  	pp->ops = &exynos_pcie_host_ops;
> > >
> > >  	ret = dw_pcie_host_init(pp);
> > > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-
> > imx6.c
> > > index 233a196..bec256c 100644
> > > --- a/drivers/pci/host/pci-imx6.c
> > > +++ b/drivers/pci/host/pci-imx6.c
> > > @@ -551,7 +551,7 @@ static int __init imx6_add_pcie_port(struct
> > pcie_port *pp,
> > >  		}
> > >  	}
> > >
> > > -	pp->root_bus_nr = -1;
> > > +	pp->root_bus_nr = 0;
> > >  	pp->ops = &imx6_pcie_host_ops;
> > >
> > >  	ret = dw_pcie_host_init(pp);
> > > diff --git a/drivers/pci/host/pci-keystone-dw.c
> > b/drivers/pci/host/pci-keystone-dw.c
> > > index f34892e..b1e4135 100644
> > > --- a/drivers/pci/host/pci-keystone-dw.c
> > > +++ b/drivers/pci/host/pci-keystone-dw.c
> > > @@ -327,7 +327,7 @@ static void ks_dw_pcie_clear_dbi_mode(void
> > __iomem *reg_virt)
> > >  void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> > >  {
> > >  	struct pcie_port *pp = &ks_pcie->pp;
> > > -	u32 start = pp->mem.start, end = pp->mem.end;
> > > +	u32 start = pp->mem->start, end = pp->mem->end;
> > >  	int i, tr_size;
> > >
> > >  	/* Disable BARs for inbound access */
> > > diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-
> > keystone.c
> > > index 734da58..8113832 100644
> > > --- a/drivers/pci/host/pci-keystone.c
> > > +++ b/drivers/pci/host/pci-keystone.c
> > > @@ -309,7 +309,7 @@ static int __init ks_add_pcie_port(struct
> > keystone_pcie *ks_pcie,
> > >  			return ret;
> > >  	}
> > >
> > > -	pp->root_bus_nr = -1;
> > > +	pp->root_bus_nr = 0;
> > >  	pp->ops = &keystone_pcie_host_ops;
> > >  	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
> > >  	if (ret) {
> > > diff --git a/drivers/pci/host/pci-layerscape.c
> > b/drivers/pci/host/pci-layerscape.c
> > > index b2328ea1..79ff08c 100644
> > > --- a/drivers/pci/host/pci-layerscape.c
> > > +++ b/drivers/pci/host/pci-layerscape.c
> > > @@ -106,7 +106,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
> > >  	pp = &pcie->pp;
> > >  	pp->dev = pcie->dev;
> > >  	pp->dbi_base = pcie->dbi;
> > > -	pp->root_bus_nr = -1;
> > > +	pp->root_bus_nr = 0;
> > >  	pp->ops = &ls_pcie_host_ops;
> > >
> > >  	ret = dw_pcie_host_init(pp);
> > > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > > index c5d407c..e71a88e 100644
> > > --- a/drivers/pci/host/pcie-designware.c
> > > +++ b/drivers/pci/host/pcie-designware.c
> > > @@ -11,6 +11,7 @@
> > >   * published by the Free Software Foundation.
> > >   */
> > >
> > > +#include <linux/hardirq.h>
> > >  #include <linux/irq.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/kernel.h>
> > > @@ -69,16 +70,7 @@
> > >  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> > >  #define PCIE_ATU_UPPER_TARGET		0x91C
> > >
> > > -static struct hw_pci dw_pci;
> > > -
> > > -static unsigned long global_io_offset;
> > > -
> > > -static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
> > > -{
> > > -	BUG_ON(!sys->private_data);
> > > -
> > > -	return sys->private_data;
> > > -}
> > > +static struct pci_ops dw_pcie_ops;
> > >
> > >  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32
> > *val)
> > >  {
> > > @@ -255,7 +247,7 @@ static void dw_pcie_msi_set_irq(struct pcie_port
> > *pp, int irq)
> > >  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> > >  {
> > >  	int irq, pos0, i;
> > > -	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
> > > +	struct pcie_port *pp = desc->dev->bus->sysdata;
> > >
> > >  	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
> > >  				       order_base_2(no_irqs));
> > > @@ -298,7 +290,7 @@ static int dw_msi_setup_irq(struct msi_controller
> > *chip, struct pci_dev *pdev,
> > >  {
> > >  	int irq, pos;
> > >  	struct msi_msg msg;
> > > -	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> > > +	struct pcie_port *pp = pdev->bus->sysdata;
> > >
> > >  	if (desc->msi_attrib.is_msix)
> > >  		return -EINVAL;
> > > @@ -327,7 +319,7 @@ static void dw_msi_teardown_irq(struct
> > msi_controller *chip, unsigned int irq)
> > >  {
> > >  	struct irq_data *data = irq_get_irq_data(irq);
> > >  	struct msi_desc *msi = irq_data_get_msi(data);
> > > -	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
> > > +	struct pcie_port *pp = msi->dev->bus->sysdata;
> > >
> > >  	clear_irq_range(pp, irq, 1, data->hwirq);
> > >  }
> > > @@ -363,14 +355,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  {
> > >  	struct device_node *np = pp->dev->of_node;
> > >  	struct platform_device *pdev = to_platform_device(pp->dev);
> > > -	struct of_pci_range range;
> > > -	struct of_pci_range_parser parser;
> > > +	struct pci_bus *bus;
> > >  	struct resource *cfg_res;
> > > -	u32 val, ns;
> > > -	const __be32 *addrp;
> > > -	int i, index, ret;
> > > -
> > > -	ns = of_n_size_cells(np);
> > > +	LIST_HEAD(res);
> > > +	u32 val;
> > > +	int i, ret;
> > > +	struct resource_entry *win;
> > >
> > >  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "config");
> > >  	if (cfg_res) {
> > > @@ -378,85 +368,60 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  		pp->cfg1_size = resource_size(cfg_res)/2;
> > >  		pp->cfg0_base = cfg_res->start;
> > >  		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
> > > -
> > > -		/* Find the untranslated configuration space address */
> > > -		index = of_property_match_string(np, "reg-names", "config");
> > > -		addrp = of_get_address(np, index, NULL, NULL);
> > > -		pp->cfg0_mod_base = of_read_number(addrp, ns);
> > > -		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
> > >  	} else {
> > >  		dev_err(pp->dev, "missing *config* reg space\n");
> > >  	}
> > >
> > > -	if (of_pci_range_parser_init(&parser, np)) {
> > > -		dev_err(pp->dev, "missing ranges property\n");
> > > -		return -EINVAL;
> > > -	}
> > > +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp-
> > >io_base);
> > > +	if (ret)
> > > +		return ret;
> > >
> > >  	/* Get the I/O and memory ranges from DT */
> > > -	for_each_of_pci_range(&parser, &range) {
> > > -		unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> > > -
> > > -		if (restype == IORESOURCE_IO) {
> > > -			of_pci_range_to_resource(&range, np, &pp->io);
> > > -			pp->io.name = "I/O";
> > > -			pp->io.start = max_t(resource_size_t,
> > > -					     PCIBIOS_MIN_IO,
> > > -					     range.pci_addr + global_io_offset);
> > > -			pp->io.end = min_t(resource_size_t,
> > > -					   IO_SPACE_LIMIT,
> > > -					   range.pci_addr + range.size
> > > -					   + global_io_offset - 1);
> > > -			pp->io_size = resource_size(&pp->io);
> > > -			pp->io_bus_addr = range.pci_addr;
> > > -			pp->io_base = range.cpu_addr;
> > > -
> > > -			/* Find the untranslated IO space address */
> > > -			pp->io_mod_base = range.cpu_addr;
> > > -		}
> > > -		if (restype == IORESOURCE_MEM) {
> > > -			of_pci_range_to_resource(&range, np, &pp->mem);
> > > -			pp->mem.name = "MEM";
> > > -			pp->mem_size = resource_size(&pp->mem);
> > > -			pp->mem_bus_addr = range.pci_addr;
> > > -
> > > -			/* Find the untranslated MEM space address */
> > > -			pp->mem_mod_base = range.cpu_addr;
> > > -		}
> > > -		if (restype == 0) {
> > > -			of_pci_range_to_resource(&range, np, &pp->cfg);
> > > -			pp->cfg0_size = resource_size(&pp->cfg)/2;
> > > -			pp->cfg1_size = resource_size(&pp->cfg)/2;
> > > -			pp->cfg0_base = pp->cfg.start;
> > > -			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> > > -
> > > -			/* Find the untranslated configuration space address
> > */
> > > -			pp->cfg0_mod_base = range.cpu_addr;
> > > -			pp->cfg1_mod_base = pp->cfg0_mod_base +
> > > -					    pp->cfg0_size;
> > > +	resource_list_for_each_entry(win, &res) {
> > > +		switch (resource_type(win->res)) {
> > > +		case IORESOURCE_IO:
> > > +			pp->io = win->res;
> > > +			pp->io->name = "I/O";
> > > +			pp->io_size = resource_size(pp->io);
> > > +			pp->io_bus_addr = pp->io->start - win->offset;
> > > +			ret = pci_remap_iospace(pp->io, pp->io_base);
> > > +			if (ret) {
> > > +				dev_warn(pp->dev, "error %d: failed to map
> > resource %pR\n",
> > > +					 ret, pp->io);
> > > +				continue;
> > > +			}
> > > +			break;
> > > +		case IORESOURCE_MEM:
> > > +			pp->mem = win->res;
> > > +			pp->mem->name = "MEM";
> > > +			pp->mem_size = resource_size(pp->mem);
> > > +			pp->mem_bus_addr = pp->mem->start - win->offset;
> > > +			break;
> > > +		case 0:
> > > +			pp->cfg = win->res;
> > > +			pp->cfg0_size = resource_size(pp->cfg)/2;
> > > +			pp->cfg1_size = resource_size(pp->cfg)/2;
> > > +			pp->cfg0_base = pp->cfg->start;
> > > +			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> > > +			break;
> > > +		case IORESOURCE_BUS:
> > > +			pp->busn = win->res;
> > > +			break;
> > > +		default:
> > > +			continue;
> > >  		}
> > >  	}
> > >
> > > -	ret = of_pci_parse_bus_range(np, &pp->busn);
> > > -	if (ret < 0) {
> > > -		pp->busn.name = np->name;
> > > -		pp->busn.start = 0;
> > > -		pp->busn.end = 0xff;
> > > -		pp->busn.flags = IORESOURCE_BUS;
> > > -		dev_dbg(pp->dev, "failed to parse bus-range property: %d,
> > using default %pR\n",
> > > -			ret, &pp->busn);
> > > -	}
> > > -
> > >  	if (!pp->dbi_base) {
> > > -		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg.start,
> > > -					resource_size(&pp->cfg));
> > > +		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
> > > +					resource_size(pp->cfg));
> > >  		if (!pp->dbi_base) {
> > >  			dev_err(pp->dev, "error with ioremap\n");
> > >  			return -ENOMEM;
> > >  		}
> > >  	}
> > >
> > > -	pp->mem_base = pp->mem.start;
> > > +	pp->mem_base = pp->mem->start;
> > >
> > >  	if (!pp->va_cfg0_base) {
> > >  		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> > > @@ -505,7 +470,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >
> > >  	if (!pp->ops->rd_other_conf)
> > >  		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> > > -					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
> > > +					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> > >  					  pp->mem_bus_addr, pp->mem_size);
> > >
> > >  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> > > @@ -517,15 +482,29 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  	val |= PORT_LOGIC_SPEED_CHANGE;
> > >  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> > >
> > > -#ifdef CONFIG_PCI_MSI
> > > +	bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> > > +				  pp, &res);
> > > +	if (!bus)
> > > +		return -ENOMEM;
> > > +
> > > +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> > > +	bus->msi = container_of(&pp->irq_domain, struct msi_controller,
> > domain);
> > > +#else
> > >  	dw_pcie_msi_chip.dev = pp->dev;
> > > -	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> > > +	bus->msi = &dw_pcie_msi_chip;
> > >  #endif
> > >
> > > -	dw_pci.nr_controllers = 1;
> > > -	dw_pci.private_data = (void **)&pp;
> > > +	pci_scan_child_bus(bus);
> > > +	if (pp->ops->scan_bus)
> > > +		pp->ops->scan_bus(pp);
> > > +
> > > +#ifdef CONFIG_ARM
> > > +	/* support old dtbs that incorrectly describe IRQs */
> > > +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > > +#endif
> > >
> > > -	pci_common_init_dev(pp->dev, &dw_pci);
> > > +	pci_assign_unassigned_bus_resources(bus);
> > > +	pci_bus_add_devices(bus);
> > >
> > >  	return 0;
> > >  }
> > > @@ -544,12 +523,12 @@ static int dw_pcie_rd_other_conf(struct
> > pcie_port *pp, struct pci_bus *bus,
> > >
> > >  	if (bus->parent->number == pp->root_bus_nr) {
> > >  		type = PCIE_ATU_TYPE_CFG0;
> > > -		cpu_addr = pp->cfg0_mod_base;
> > > +		cpu_addr = pp->cfg0_base;
> > >  		cfg_size = pp->cfg0_size;
> > >  		va_cfg_base = pp->va_cfg0_base;
> > >  	} else {
> > >  		type = PCIE_ATU_TYPE_CFG1;
> > > -		cpu_addr = pp->cfg1_mod_base;
> > > +		cpu_addr = pp->cfg1_base;
> > >  		cfg_size = pp->cfg1_size;
> > >  		va_cfg_base = pp->va_cfg1_base;
> > >  	}
> > > @@ -559,7 +538,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port
> > *pp, struct pci_bus *bus,
> > >  				  busdev, cfg_size);
> > >  	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
> > >  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> > > -				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
> > > +				  PCIE_ATU_TYPE_IO, pp->io_base,
> > >  				  pp->io_bus_addr, pp->io_size);
> > >
> > >  	return ret;
> > > @@ -579,12 +558,12 @@ static int dw_pcie_wr_other_conf(struct
> > pcie_port *pp, struct pci_bus *bus,
> > >
> > >  	if (bus->parent->number == pp->root_bus_nr) {
> > >  		type = PCIE_ATU_TYPE_CFG0;
> > > -		cpu_addr = pp->cfg0_mod_base;
> > > +		cpu_addr = pp->cfg0_base;
> > >  		cfg_size = pp->cfg0_size;
> > >  		va_cfg_base = pp->va_cfg0_base;
> > >  	} else {
> > >  		type = PCIE_ATU_TYPE_CFG1;
> > > -		cpu_addr = pp->cfg1_mod_base;
> > > +		cpu_addr = pp->cfg1_base;
> > >  		cfg_size = pp->cfg1_size;
> > >  		va_cfg_base = pp->va_cfg1_base;
> > >  	}
> > > @@ -594,7 +573,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port
> > *pp, struct pci_bus *bus,
> > >  				  busdev, cfg_size);
> > >  	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
> > >  	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> > > -				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
> > > +				  PCIE_ATU_TYPE_IO, pp->io_base,
> > >  				  pp->io_bus_addr, pp->io_size);
> > >
> > >  	return ret;
> > > @@ -626,7 +605,7 @@ static int dw_pcie_valid_config(struct pcie_port
> > *pp,
> > >  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> > >  			int size, u32 *val)
> > >  {
> > > -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> > > +	struct pcie_port *pp = bus->sysdata;
> > >  	int ret;
> > >
> > >  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> > > @@ -650,7 +629,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus,
> > u32 devfn, int where,
> > >  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> > >  			int where, int size, u32 val)
> > >  {
> > > -	struct pcie_port *pp = sys_to_pcie(bus->sysdata);
> > > +	struct pcie_port *pp = bus->sysdata;
> > >  	int ret;
> > >
> > >  	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> > > @@ -674,62 +653,6 @@ static struct pci_ops dw_pcie_ops = {
> > >  	.write = dw_pcie_wr_conf,
> > >  };
> > >
> > > -static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
> > > -{
> > > -	struct pcie_port *pp;
> > > -
> > > -	pp = sys_to_pcie(sys);
> > > -
> > > -	if (global_io_offset < SZ_1M && pp->io_size > 0) {
> > > -		sys->io_offset = global_io_offset - pp->io_bus_addr;
> > > -		pci_ioremap_io(global_io_offset, pp->io_base);
> > > -		global_io_offset += SZ_64K;
> > > -		pci_add_resource_offset(&sys->resources, &pp->io,
> > > -					sys->io_offset);
> > > -	}
> > > -
> > > -	sys->mem_offset = pp->mem.start - pp->mem_bus_addr;
> > > -	pci_add_resource_offset(&sys->resources, &pp->mem, sys-
> > >mem_offset);
> > > -	pci_add_resource(&sys->resources, &pp->busn);
> > > -
> > > -	return 1;
> > > -}
> > > -
> > > -static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data
> > *sys)
> > > -{
> > > -	struct pci_bus *bus;
> > > -	struct pcie_port *pp = sys_to_pcie(sys);
> > > -
> > > -	pp->root_bus_nr = sys->busnr;
> > > -	bus = pci_scan_root_bus(pp->dev, sys->busnr,
> > > -				  &dw_pcie_ops, sys, &sys->resources);
> > > -	if (!bus)
> > > -		return NULL;
> > > -
> > > -	if (bus && pp->ops->scan_bus)
> > > -		pp->ops->scan_bus(pp);
> > > -
> > > -	return bus;
> > > -}
> > > -
> > > -static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8
> > pin)
> > > -{
> > > -	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
> > > -	int irq;
> > > -
> > > -	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> > > -	if (!irq)
> > > -		irq = pp->irq;
> > > -
> > > -	return irq;
> > > -}
> > > -
> > > -static struct hw_pci dw_pci = {
> > > -	.setup		= dw_pcie_setup,
> > > -	.scan		= dw_pcie_scan_bus,
> > > -	.map_irq	= dw_pcie_map_irq,
> > > -};
> > > -
> > >  void dw_pcie_setup_rc(struct pcie_port *pp)
> > >  {
> > >  	u32 val;
> > > diff --git a/drivers/pci/host/pcie-designware.h
> > b/drivers/pci/host/pcie-designware.h
> > > index d0bbd27..264c969 100644
> > > --- a/drivers/pci/host/pcie-designware.h
> > > +++ b/drivers/pci/host/pcie-designware.h
> > > @@ -27,25 +27,21 @@ struct pcie_port {
> > >  	u8			root_bus_nr;
> > >  	void __iomem		*dbi_base;
> > >  	u64			cfg0_base;
> > > -	u64			cfg0_mod_base;
> > >  	void __iomem		*va_cfg0_base;
> > >  	u32			cfg0_size;
> > >  	u64			cfg1_base;
> > > -	u64			cfg1_mod_base;
> > >  	void __iomem		*va_cfg1_base;
> > >  	u32			cfg1_size;
> > > -	u64			io_base;
> > > -	u64			io_mod_base;
> > > +	resource_size_t		io_base;
> > >  	phys_addr_t		io_bus_addr;
> > >  	u32			io_size;
> > >  	u64			mem_base;
> > > -	u64			mem_mod_base;
> > >  	phys_addr_t		mem_bus_addr;
> > >  	u32			mem_size;
> > > -	struct resource		cfg;
> > > -	struct resource		io;
> > > -	struct resource		mem;
> > > -	struct resource		busn;
> > > +	struct resource		*cfg;
> > > +	struct resource		*io;
> > > +	struct resource		*mem;
> > > +	struct resource		*busn;
> > >  	int			irq;
> > >  	u32			lanes;
> > >  	struct pcie_host_ops	*ops;
> > > diff --git a/drivers/pci/host/pcie-spear13xx.c
> > b/drivers/pci/host/pcie-spear13xx.c
> > > index c49fbdc..03eb204 100644
> > > --- a/drivers/pci/host/pcie-spear13xx.c
> > > +++ b/drivers/pci/host/pcie-spear13xx.c
> > > @@ -286,7 +286,7 @@ static int spear13xx_add_pcie_port(struct
> > pcie_port *pp,
> > >  		return ret;
> > >  	}
> > >
> > > -	pp->root_bus_nr = -1;
> > > +	pp->root_bus_nr = 0;
> > >  	pp->ops = &spear13xx_pcie_host_ops;
> > >
> > >  	ret = dw_pcie_host_init(pp);
> > 
> > --
> > Pengutronix e.K.             | Lucas Stach                 |
> > Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

