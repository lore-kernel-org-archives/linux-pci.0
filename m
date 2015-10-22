Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"gabriel.fernandez@linaro.org" <gabriel.fernandez@linaro.org>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v11 1/6] PCI: designware: move calculation of bus
 addresses to DRA7xx
Date: Thu, 22 Oct 2015 07:21:41 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E16274DCC@lhreml503-mbs>
References: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
 <1444991021-109306-2-git-send-email-wangzhou1@hisilicon.com>
 <20151021221524.GM1583@localhost>
In-Reply-To: <20151021221524.GM1583@localhost>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 21 October 2015 23:15
> To: Wangzhou (B)
> Cc: Bjorn Helgaas; jingoohan1@gmail.com; pratyush.anand@gmail.com; Arnd
> Bergmann; linux@arm.linux.org.uk; thomas.petazzoni@free-electrons.com;
> Gabriele Paoloni; lorenzo.pieralisi@arm.com; james.morse@arm.com;
> Liviu.Dudau@arm.com; jason@lakedaemon.net; robh@kernel.org;
> gabriel.fernandez@linaro.org; Minghuan.Lian@freescale.com; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; zhangjukuo;
> qiuzhenfa; liudongdong (C); qiujiang; xuwei (O); Liguozhu (Kenneth)
> Subject: Re: [PATCH v11 1/6] PCI: designware: move calculation of bus
> addresses to DRA7xx
> 
> Hi Zhou & Gabriele,

Hi Bjorn, thanks for reviewing

> 
> On Fri, Oct 16, 2015 at 06:23:36PM +0800, Zhou Wang wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > Commit f4c55c5a3f7f ("PCI: designware: Program ATU with untranslated
> > address") added the calculation of PCI BUS addresses in designware,
> > storing them in new fields added in "struct pcie_port". This
> > calculation is done for every designware user even if is only
> > applicable to DRA7xx.
> > This patch moves the calculation of the bus addresses to the DRA7xx
> > driver and is needed to allow the rework of designware to use
> > the new DT parsing API.
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
> > ---
> >  drivers/pci/host/pci-dra7xx.c      | 13 +++++++++++++
> >  drivers/pci/host/pcie-designware.c | 15 ++++-----------
> >  2 files changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> > index 199e29a..ebdffa0 100644
> > --- a/drivers/pci/host/pci-dra7xx.c
> > +++ b/drivers/pci/host/pci-dra7xx.c
> > @@ -62,6 +62,7 @@
> >
> >  #define	PCIECTRL_DRA7XX_CONF_PHY_CS			0x010C
> >  #define	LINK_UP						BIT(16)
> > +#define	CPU_TO_BUS_ADDR					0x0FFFFFFF
> 
> "CPU_TO_BUS_ADDR" is a very generic name.  Since you do have DRA7XX in
> other #defines and static symbols in this file, maybe it could be DRA7XX to
> make it obvious that it only applies here?

Ok will change to DRA7XX_CPU_TO_BUS_ADRR in v12

> 
> >
> >  struct dra7xx_pcie {
> >  	void __iomem		*base;
> > @@ -151,6 +152,18 @@ static void dra7xx_pcie_enable_interrupts(struct
> pcie_port *pp)
> >  static void dra7xx_pcie_host_init(struct pcie_port *pp)
> >  {
> >  	dw_pcie_setup_rc(pp);
> > +
> > +	if (pp->io_mod_base)
> > +		pp->io_mod_base &= CPU_TO_BUS_ADDR;
> 
> These are equivalent to
> 
>   pp->io_mod_base &= CPU_TO_BUS_ADDR;
> 
> (You don't need to test whether they're zero first.)
> 

Yes agreed, will change in v12

> > +
> > +	if (pp->mem_mod_base)
> > +		pp->mem_mod_base &= CPU_TO_BUS_ADDR;
> > +
> > +	if (pp->cfg0_mod_base) {
> > +		pp->cfg0_mod_base &= CPU_TO_BUS_ADDR;
> > +		pp->cfg1_mod_base &= CPU_TO_BUS_ADDR;
> > +	}
> > +
> >  	dra7xx_pcie_establish_link(pp);
> >  	if (IS_ENABLED(CONFIG_PCI_MSI))
> >  		dw_pcie_msi_init(pp);
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> > index 52aa6e3..75338a6 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -365,14 +365,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	struct of_pci_range range;
> >  	struct of_pci_range_parser parser;
> >  	struct resource *cfg_res;
> > -	u32 val, na, ns;
> > +	u32 val, ns;
> >  	const __be32 *addrp;
> >  	int i, index, ret;
> >
> > -	/* Find the address cell size and the number of cells in order to get
> > -	 * the untranslated address.
> > -	 */
> > -	of_property_read_u32(np, "#address-cells", &na);
> >  	ns = of_n_size_cells(np);
> >
> >  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> > @@ -415,8 +411,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  			pp->io_base = range.cpu_addr;
> >
> >  			/* Find the untranslated IO space address */
> > -			pp->io_mod_base = of_read_number(parser.range -
> > -							 parser.np + na, ns);
> > +			pp->io_mod_base = range.cpu_addr;
> 
> So apparently
> 
>   "of_read_number() == range.cpu_addr & CPU_TO_BUS_ADDR" on DRA7xx
>   "of_read_number() == range.cpu_addr" everywhere else?

Yes correct

> 
> Is that right?  Is that a valid assumption, i.e., are we assuming
> anything about DTs in the field that we shouldn't?

Before I wrote a patch that was generic to accommodate intermediate level
of translation between PCI_addr -> BUS_addr -> CPU_addr

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/360922.html

After discussion we agreed to solve it with a bitmask rather than adding
a field to of_pci_range to make it generic.
The bitmask only applies to DRA7xx

> 
> >  		}
> >  		if (restype == IORESOURCE_MEM) {
> >  			of_pci_range_to_resource(&range, np, &pp->mem);
> > @@ -425,8 +420,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  			pp->mem_bus_addr = range.pci_addr;
> >
> >  			/* Find the untranslated MEM space address */
> > -			pp->mem_mod_base = of_read_number(parser.range -
> > -							  parser.np + na, ns);
> > +			pp->mem_mod_base = range.cpu_addr;
> >  		}
> >  		if (restype == 0) {
> >  			of_pci_range_to_resource(&range, np, &pp->cfg);
> > @@ -436,8 +430,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  			pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
> >
> >  			/* Find the untranslated configuration space address */
> > -			pp->cfg0_mod_base = of_read_number(parser.range -
> > -							   parser.np + na, ns);
> > +			pp->cfg0_mod_base = range.cpu_addr;
> >  			pp->cfg1_mod_base = pp->cfg0_mod_base +
> >  					    pp->cfg0_size;
> >  		}
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
