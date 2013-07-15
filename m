Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
References: <001201ce7dfa$716b3370$54419a50$@samsung.com>
 <51DFD3F3.9050704@ti.com>
In-reply-to: <51DFD3F3.9050704@ti.com>
Subject: Re: [PATCH V2] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Mon, 15 Jul 2013 17:25:15 +0900
Message-id: <000601ce8134$d5277b20$7f767160$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 12, 2013 7:01 PM, Kishon Vijay Abraham I wrote:
> On Thursday 11 July 2013 11:19 AM, Jingoo Han wrote:
> > Exynos PCIe IP consists of Synopsys specific part and Exynos
> > specific part. Only core block is a Synopsys designware part;
> > other parts are Exynos specific.
> > Also, the Synopsys designware part can be shared with other
> > platforms; thus, it can be split two parts such as Synopsys
> > designware part and Exynos specific part.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> > ---
> > Changes since v1:
> > - moved the configuration, I/O, memory space handling to dw_pcie_host_init()
> > - removed exynos_pcie_abort()
> > - replaced 'purple_base' with 'block_base'
> > - replaced 'dbi_base' with 'dbi_addr'
> >
> >  drivers/pci/host/Makefile          |    1 +
> >  drivers/pci/host/pcie-designware.c |  963 +++++++++---------------------------
> >  drivers/pci/host/pcie-designware.h |   71 +++
> >  drivers/pci/host/pcie-exynos.c     |  523 ++++++++++++++++++++
> >  4 files changed, 822 insertions(+), 736 deletions(-)
> >  create mode 100644 drivers/pci/host/pcie-designware.h
> >  create mode 100644 drivers/pci/host/pcie-exynos.c
> >

[...]

> > -static void exynos_pcie_setup_rc(struct pcie_port *pp)
> > +void dw_pcie_setup_rc(struct pcie_port *pp)
> >  {
> >  	struct pcie_port_info *config = &pp->config;
> >  	void __iomem *dbi_base = pp->dbi_base;
> > @@ -549,509 +502,47 @@ static void exynos_pcie_setup_rc(struct pcie_port *pp)
> >  	u32 memlimit;
> >
> >  	/* set the number of lines as 4 */
> > -	readl_rc(pp, dbi_base + PCIE_PORT_LINK_CONTROL, &val);
> > +	dw_pcie_readl_rc(pp, dbi_base + PCIE_PORT_LINK_CONTROL, &val);
> >  	val &= ~PORT_LINK_MODE_MASK;
> >  	val |= PORT_LINK_MODE_4_LANES;
> > -	writel_rc(pp, val, dbi_base + PCIE_PORT_LINK_CONTROL);
> > +	dw_pcie_writel_rc(pp, val, dbi_base + PCIE_PORT_LINK_CONTROL);
> 
> I guess here we need to make this configurable. In Jacinto6 this can be either
> single lane or double lane. Maybe we should have a dt property to specify the
> number of lanes?

OK, I will make it configurable.

[...]

> > +struct pcie_port_info {
> > +	u32		cfg0_size;
> > +	u32		cfg1_size;
> > +	u32		io_size;
> > +	u32		mem_size;
> > +	phys_addr_t	io_bus_addr;
> > +	phys_addr_t	mem_bus_addr;
> > +};
> > +
> > +struct pcie_port {
> > +	struct device		*dev;
> > +	u8			controller;
> > +	u8			root_bus_nr;
> > +	void __iomem		*dbi_base;
> > +	void __iomem		*elbi_base;
> > +	void __iomem		*phy_base;
> > +	void __iomem		*block_base;
> > +	u64			cfg0_base;
> > +	void __iomem		*va_cfg0_base;
> > +	u64			cfg1_base;
> > +	void __iomem		*va_cfg1_base;
> > +	u64			io_base;
> > +	u64			mem_base;
> > +	spinlock_t		conf_lock;
> > +	struct resource		cfg;
> > +	struct resource		io;
> > +	struct resource		mem;
> > +	struct pcie_port_info	config;
> > +	struct clk		*clk;
> > +	struct clk		*bus_clk;
> > +	int			irq;
> > +	int			reset_gpio;
> > +	struct dw_pcie_host_ops	*ops;
> > +};
> 
> I think this structure should be split. This has too many of platform specific
> fields. Maybe we should make pcie_port have only fields necessary for core part
> and have some other structure for platform specific part?
> 
> Something like
> struct exynos_pcie {
> 	[...]
> 	void __iomem		*dbi_base;
> 	void __iomem		*elbi_base;
> 	void __iomem		*phy_base;
> 	int			reset_gpio;
> 	struct clk		*clk;
> 	struct clk		*bus_clk;
> 	[...]
> 	struct pcie_port	pp;
> }
> 
> struct pcie_port {
> 	struct device		*dev;
> 	u64			cfg0_base;
> 	void __iomem		*va_cfg0_base;
> 	u64			cfg1_base;
> 	void __iomem		*va_cfg1_base;
> 	u64			io_base;
> 	u64			mem_base;
> 	spinlock_t		conf_lock;
> 	struct resource		cfg;
> 	struct resource		io;
> 	struct resource		mem;
> 	struct pcie_port_info	config;
> 	int			irq;
> 	struct dw_pcie_host_ops	*ops;
> };
> 
> And in ops, you can use container_of to get reference to exynos_pcie (if we
> want to write to exynos pcie registers)

OK, I see.
It looks good. I will use it as you guided.
Thank you for your suggestion. :)

Best regards,
Jingoo Han


