Return-Path: <SRS0=8z5t=F6=aosc.io=icenowy@kernel.org>
Return-Path: <SRS0=8z5t=F6=aosc.io=icenowy@kernel.org>
Message-ID: <1520488103.13063.1.camel@aosc.io>
Subject: Re: Question about a quirky (DesignWare) PCIe RC in Allwinner H6
From: Icenowy Zheng <icenowy@aosc.io>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Maxime Ripard
 <maxime.ripard@bootlin.com>, linux-pci@vger.kernel.org,
 linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Marc Gonzalez
 <marc_gonzalez@sigmadesigns.com>
Date: Thu, 08 Mar 2018 13:48:23 +0800
In-Reply-To: <20180306233832.GC33706@bhelgaas-glaptop.roam.corp.google.com>
References: <1520261458.33502.10.camel@aosc.io>
	 <20180305214718.GC255556@bhelgaas-glaptop.roam.corp.google.com>
	 <1520308623.33502.13.camel@aosc.io>
	 <20180306233832.GC33706@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

在 2018-03-06二的 17:38 -0600，Bjorn Helgaas写道：
> [+cc Marc]
> 
> On Tue, Mar 06, 2018 at 11:57:03AM +0800, Icenowy Zheng wrote:
> > 在 2018-03-05一的 15:47 -0600，Bjorn Helgaas写道：
> > > On Mon, Mar 05, 2018 at 10:50:58PM +0800, Icenowy Zheng wrote:
> > > > Hi everyone,
> > > > 
> > > > I'm trying to implement a driver for the quirky (DW) PCIe RC in
> > > > the
> > > > Allwinner H6 SoC.
> > > > 
> > > > The quirk is that only the "dbi" space is always mapped, but at
> > > > the
> > > > same time only 64KiB of other spaces (config, downstream IO and
> > > > non-
> > > > prefetchable memory) are accessible. To access a certain
> > > > address
> > > > the
> > > > high 16-bit of the address (all bus addresses in H6 SoC are 32-
> > > > bit
> > > > despite the CPU is 64-bit) needs to be written into the
> > > > PCIE_ADDR_PAGE_CFG register (a vendor-defined register in DBI
> > > > space).
> > > > So the access to these spaces cannot be processed correctly
> > > > with
> > > > just
> > > > readl/writel, as the existing code does.
> > > > 
> > > > Is it possible to workaround this in the PCI subsystem of
> > > > Linux?
> > > > 
> > > > (I have thought a workaround that only maps the current
> > > > accessible
> > > > 64KiB with the MMU, and when accessing the non-accessible part,
> > > > catch
> > > > the page fault and re-setup the map to the new 64KiB page. But
> > > > surely
> > > > it will kill the performance.)
> > > 
> > > If you only need to write to PCIE_ADDR_PAGE_CFG for *config*
> > > accesses,
> > > this should be easy.  All config accesses go through wrappers
> > > (pci_read_config_word(), etc) and several host bridge drivers
> > > have to
> > > update a register with parts of the config address, e.g.,
> > > advk_pcie_rd_conf(), mvebu_pcie_hw_rd_conf().
> > > 
> > > It sounds like you also need to update PCIE_ADDR_PAGE_CFG for I/O
> > > port
> > > accesses.  I/O port accesses do go through a wrapper (inb(),
> > > etc), so
> > > it might be possible in principle to intercept these, although
> > > much
> > > more difficult than config accesses, because the config accesses
> > > are
> > > already set up with per-host bridge hooks, while the I/O port
> > > accessors are mostly per-arch.
> > > 
> > > But if you have to update PCIE_ADDR_PAGE_CFG for memory accesses,
> > > that's really a problem because drivers are allowed to
> > > essentially
> > > read a memory BAR, convert that bus address to a CPU physical
> > > memory
> > > address, ioremap() it, then directly access the PCIe memory with
> > > loads
> > > and stores.
> > 
> > Unfortunately this is the case. All above (config, IO, memory)
> > needs
> > PCIE_ADDR_PAGE_CFG update.
> 
> tango_pcie_probe() has a similar issue.  We don't have a good
> solution
> there, so we just live with the fact that the platform will be
> unreliable.

It's still less quirky than Allwinner H6 PCIe. It's only a config/MMIO
mux on tango; however on H6 PCIe both config space and MMIO space are
splitted to many pages. So on H6 if no solution is worked out, it will
not be unreliable -- it will be unusable instead.

> 
> Bjorn
