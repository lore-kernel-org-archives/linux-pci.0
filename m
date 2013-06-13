Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>
Subject: Re: [PATCH V4 1/3] pci: Add PCIe driver for Samsung Exynos
Date: Thu, 13 Jun 2013 16:18:47 +0200
Message-ID: <28355406.ThqqvnG0Yj@wuerfel>
In-Reply-To: <000901ce6838$8b514720$a1f3d560$@samsung.com>
References: <003601ce6756$444e8cd0$cceba670$@samsung.com> <2061566.hRLrhtBK6z@wuerfel> <000901ce6838$8b514720$a1f3d560$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 June 2013 22:18:50 Jingoo Han wrote:
> On Wednesday, June 12, 2013 8:23 PM, Arnd Bergmann wrote:
> > On Wednesday 12 June 2013 19:19:05 Jingoo Han wrote:

> > > +
> > > +/* synopsis specific PCIE configuration registers*/
> > > +#define PCIE_PORT_LINK_CONTROL		0x710
> > > +#define PORT_LINK_MODE_MASK		(0x3f << 16)
> > > +#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> > 
> > Do you mean this is a "Synopsys" designware part? In that case it
> > should really not be called "exynos-pcie" but "designware-pcie"
> > and you should make sure that the driver makes no assumptions about
> > the platform. A lot of other platforms also use designware
> > parts and should be able to reuse this driver.
> 
> Sorry, I don't think so.
> Only core block is a "Synopsys" designware part IP block,
> other parts are Exynos-specific.
> So, it is hard to share with other PCIe IPs using synopsis core.

Just call it synopsys anyway and put a comment in to explain this.
That should be enough for the next person with a synopsys PCI core
to reuse your code and split out the exynos specific parts into a
separate file.

> > I think you should not assume that the physical base address is a 32
> > bit value. The hardware clearly supports "lower" and "upper" halves
> > for the address window, so when resource_size_t is 64 bit, you should
> > set the upper half accordingly. Since the hardware is always 64 bit,
> > you can use a "u64" type rather than resource_size_t to simplify the
> > code here.
> 
> OK, I will replace "u32" with "u64".

Not what I meant, please read it again.

> > > +static void exynos_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
> > > +{
> > > +	u32 val;
> > > +	void __iomem *dbi_base = pp->dbi_base;
> > > +
> > > +	/* Program viewport 1 : OUTBOUND : IO */
> > > +	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1;
> > > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > > +	writel_rc(pp, PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
> > > +	val = PCIE_ATU_ENABLE;
> > > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > > +	writel_rc(pp, (u32)pp->io_base, dbi_base + PCIE_ATU_LOWER_BASE);
> > > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > > +	writel_rc(pp, (u32)(pp->io_base + pp->config.io_size - 1),
> > > +			dbi_base + PCIE_ATU_LIMIT);
> > > +	writel_rc(pp, (u32)pp->io_base, dbi_base + PCIE_ATU_LOWER_TARGET);
> > > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > > +}
> > 
> > You don't actually map the I/O space anywhere into virtual memory.
> > I think you need to call pci_ioremap_io with the pp->io_base at
> > boot time.
> 
> Sorry, when pci_ioremap_io() is used, Exynos5440 hangs.
> I don't know how to deal this.

You have to call it, there is no way around that. You will have to debug
this yourself, I'm sure there is an easy solution.

> > 
> > You hardcode the in_mem_size to 256 MB. Does that mean you only allow
> > PCI bus master DMA on the first part of RAM? Shouldn't it get
> > computed from the actual location and size of RAM?
> 
> I will remove the hard-coded in_mem_size, instead use the size of MEM region.

This should be system RAM, not the PCI memory space. What good would
it be to have an inbound window that only redirects back to the bus?

> > > +static void exynos_pcie_prog_viewport_io_inbound(struct pcie_port *pp)
> > > +{
> > > +	u32 val;
> > > +	void __iomem *dbi_base = pp->dbi_base;
> > > +	struct pcie_port_info *config = &pp->config;
> > > +
> > > +	/* Program viewport 1 : INBOUND : IO */
> > > +	val = PCIE_ATU_REGION_INBOUND | PCIE_ATU_REGION_INDEX1;
> > > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > > +	writel_rc(pp, PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
> > > +	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
> > > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_LOWER_BASE);
> > > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > > +	writel_rc(pp, config->in_mem_size - 1, dbi_base + PCIE_ATU_LIMIT);
> > > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_LOWER_TARGET);
> > > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > > +}
> > 
> > I don't understand what in inbound I/O access actually means. What
> > does this do, is it for PCI target emulation?
> 
> I reviewed the manual, and I will fix it.
> I will add bus addresses and host physical addresses to
> PCIE_ATU_LOWER_BASE/ PCIE_ATU_LOWER_TARGET.
 
You have not answered my question.

> > > +static int exynos_pcie_setup(int nr, struct pci_sys_data *sys)
> > > +{
> > > +	struct pcie_port *pp;
> > > +
> > > +	pp = sys_to_pcie(sys);
> > > +
> > > +	if (!pp)
> > > +		return 0;
> > > +
> > > +	pci_add_resource_offset(&sys->resources, &pp->io, sys->io_offset);
> > > +	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> > > +
> > > +	return 1;
> > > +}
> > 
> > You don't actually set up io_offset and mem_offset, right?
> 
> OK, I will replace pci_add_resource_offset() with pci_add_resource().

No, you have to set up the offsets.

Please don't post another version until you actually understand what
you need to do. If you don't understand the comments, ask back rather
than picking a random interpretation.

	Arnd
