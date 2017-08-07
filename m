Return-Path: <SRS0=6JFg=7J=mediatek.com=honghui.zhang@kernel.org>
Return-Path: <SRS0=6JFg=7J=mediatek.com=honghui.zhang@kernel.org>
Message-ID: <1502077231.24341.29.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/5] PCI: mediatek: Add new generation controller
 support
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Ryder Lee <ryder.lee@mediatek.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
	<robh@kerenl.org>, <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <hongkun.cao@mediatek.com>,
	<youlin.pei@mediatek.com>, <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
	<sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Date: Mon, 7 Aug 2017 11:40:31 +0800
In-Reply-To: <1501913813.12086.17.camel@mtkswgap22>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
	 <824c61d13fe2731d812df8a0a878ca1a36399e76.1501122135.git.honghui.zhang@mediatek.com>
	 <20170803224206.GN20308@bhelgaas-glaptop.roam.corp.google.com>
	 <1501835976.24341.21.camel@mtksdaap41>
	 <20170804131808.GA16580@bhelgaas-glaptop.roam.corp.google.com>
	 <1501908763.8298.11.camel@mtkswgap22>
	 <1501913813.12086.17.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2017-08-05 at 14:16 +0800, Ryder Lee wrote:
> On Sat, 2017-08-05 at 12:52 +0800, Ryder Lee wrote:
> > Hi Honghui, Bjorn,
> > 
> > On Fri, 2017-08-04 at 08:18 -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 04, 2017 at 04:39:36PM +0800, Honghui Zhang wrote:
> > > > On Thu, 2017-08-03 at 17:42 -0500, Bjorn Helgaas wrote:
> > > > > > +
> > > > > > +static struct mtk_pcie_port *mtk_pcie_find_port(struct mtk_pcie *pcie,
> > > > > > +						struct pci_bus *bus, int devfn)
> > > > > > +{
> > > > > > +	struct pci_dev *dev;
> > > > > > +	struct pci_bus *pbus;
> > > > > > +	struct mtk_pcie_port *port, *tmp;
> > > > > > +
> > > > > > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > > > > +		if (bus->number == 0 && port->index == PCI_SLOT(devfn)) {
> > > > > > +			return port;
> > > > > > +		} else if (bus->number != 0) {
> > > > > > +			pbus = bus;
> > > > > > +			do {
> > > > > > +				dev = pbus->self;
> > > > > > +				if (port->index == PCI_SLOT(dev->devfn))
> > > > > > +					return port;
> > > > > > +				pbus = dev->bus;
> > > > > > +			} while (dev->bus->number != 0);
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	return NULL;
> > > > > 
> > > > > You should be able to use sysdata to avoid searching the list.
> > > > > See drivers/pci/host/pci-aardvark.c, for example.
> > > > > 
> > > > 
> > > > I could put the mtk_pcie * in sysdata, but still need to searching the
> > > > list to get the mtk_pcie_port *, how about:
> > > > 
> > > > 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > > 		if (port->index == PCI_SLOT(devfn))
> > > > 			return port;
> > > > 	}
> > > 
> > > No.  Other drivers don't need to search the list.  Please take a look
> > > at them and see how they solve this problem.  I don't think your
> > > hardware is fundamentally different in a way that means you need to
> > > search when the others don't.
> > > 
> > 
> > I'm not directly involved in this generation, but I guess the main reason why Honghui need to do that is just because this hardware access configuration space via per-port registers, not just for the guard.  
> > Currently, We had a host bridge with two ports (two subnodes in binding text), thus he tried to tells them apart so that he can get the correct registers.
> > 
> > Some platforms don't need to do that since they just have a single port (no more subnodes), the others might have specific/shared registers to access configuration space. (e.g. Tegra, MTK legacy IP block).
> > Or, he can split them into two independent nodes, but it will break common probing flow by doing so. (I'd prefer to use subnodes.)
> > 
> > Ryder
> > 
> 
> Sorry for the typesetting in previous mail and noise again,
> 
> I've took a look at pci-rcar-gen2.c, this is a similar case I can found
> for Honghui's case. It gathers two ports reg regions into one, and uses
> the "slot id" to calculate the cfg base of each port.
> 
> Perhaps this is a example for those who need to use subnodes and use
> port registers for cfg operation. Not sure whether it's worthwhile doing
> that since we need to changes ports/host structures.
> 
> Ryder.
> 
As Ryder's description, Mediatek's new generation HW blocks has two
separate ports, they have separate control register base address. We
must touch the per-port control register to access the EP's
configuration space. One port's control register is the only way to
access the EP's configuration space(the EP which is connect under this
very port).
Given an EP device, we need to determine which ports it's been
connected, and get the base address for that port. It's a bit like
pci-tegra/pci-mvebu.

Seems list is not forbidden, pci-tegra search the list to identify the
ports[1], mvebu use point array to search the ports[2], they have the
same functionality through different approach. I may propose another
patch to make the code like mvebu[2] if you insist, but I'm prefer the
current list way.

[1]http://elixir.free-electrons.com/linux/v4.13-rc4/source/drivers/pci/host/pci-tegra.c#L456
[2]http://elixir.free-electrons.com/linux/v4.13-rc4/source/drivers/pci/host/pci-mvebu.c#L780

thanks.
> 
