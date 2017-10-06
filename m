Return-Path: <SRS0=6ey0=BF=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=6ey0=BF=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 6 Oct 2017 09:47:05 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>, Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH v2 0/7] PCI: aardvark: improve compatibility with PCI
 devices
Message-ID: <20171006084705.GA8754@red-moon>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20171005175310.3c2dde95@windsurf.lan>
 <20171005181615.GU25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005181615.GU25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 05, 2017 at 01:16:17PM -0500, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Thu, Oct 05, 2017 at 05:53:10PM +0200, Thomas Petazzoni wrote:
> > Hello Bjorn,
> > 
> > On Thu, 28 Sep 2017 14:58:31 +0200, Thomas Petazzoni wrote:
> > 
> > > This patch series brings a number of fixes to the pci-aardvark driver
> > > that allows a much larger number of PCIe devices to be used.
> > 
> > I sent the initial version of this patch series almost a month ago, and
> > it consists of fixes that I would like to have in 4.14.
> 
> The general rule is that after the merge window, I merge fixes to
> things we put in during the merge window, as well as important
> regression fixes.  Most bug fixes will be queued for the next merge
> window.  I'll need some guidance on classifying these.
> 
> I think the map_irq/swizzle_irq patch should definitely be in v4.14.

Yes it is v4.14 (actually v4.13 - Fixes: tag will cover that) material,
I missed updating this host bridge while patching all ARM host controller
bridges, apologies.

Thanks,
Lorenzo

> (It looks a lot like these:
> 
>   1ee4d93d5037 PCI: xilinx-nwl: Move to struct pci_host_bridge IRQ mapping functions
>   5a3dc3c1f694 PCI: rockchip: Move to struct pci_host_bridge IRQ mapping functions
>   c62e98bdaa70 PCI: xgene: Move to struct pci_host_bridge IRQ mapping functions
>   6ab380957838 PCI: altera: Drop pci_fixup_irqs()
>   cf60374de8f6 PCI: versatile: Drop pci_fixup_irqs()
>   6982a068aa5f PCI: generic: Drop pci_fixup_irqs()
>   f7c2e69b65fe PCI: faraday: Drop pci_fixup_irqs()
>   60eca198b1ea PCI: designware: Drop pci_fixup_irqs()
>   64bcd00a7ef5 PCI: iproc: Drop pci_fixup_irqs()
>   29db991902ec PCI: rcar: Drop pci_fixup_irqs()
>   cc2eaaef63df PCI: xilinx: Drop pci_fixup_irqs()
>   dd5fcce2a7f9 PCI: tegra: Drop pci_fixup_irqs()
> 
> and I'm obsessive enough to use one of those subject lines to tie this
> patch together with those.)
> 
> Most of the rest look like they've been there since the driver was
> first merged, so they would *probably* go in the v4.15 queue.
> 
> > Is there a specific problem with those patches that explains why they
> > have been ignored? Or is it just lack of time?
> > 
> > If there is any problem with the patches, please let me know, I am of
> > course perfectly fine with reworking them as needed.
> 
> Sorry for the delay; mostly just lack of time.  I used to work pretty
> strictly first-in, first-out, but the native host bridge drivers
> consume a disproportionate share of my time compared with the generic
> code that benefits everybody, so I'm trying to figure out how to
> prioritize generic changes.  Obviously I need a solution that gives
> *some* time to the native drivers.
> 
> Bjorn
