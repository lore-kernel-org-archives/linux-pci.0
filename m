Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 Aug 2017 15:16:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v2 4/5] PCI: mediatek: Add new generation controller
 support
Message-ID: <20170808201647.GI16580@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <824c61d13fe2731d812df8a0a878ca1a36399e76.1501122135.git.honghui.zhang@mediatek.com>
 <20170803224206.GN20308@bhelgaas-glaptop.roam.corp.google.com>
 <1501835976.24341.21.camel@mtksdaap41>
 <20170804131808.GA16580@bhelgaas-glaptop.roam.corp.google.com>
 <1501908763.8298.11.camel@mtkswgap22>
MIME-Version: 1.0
In-Reply-To: <1501908763.8298.11.camel@mtkswgap22>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, yt.shen@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
 robh@kerenl.org, linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
 Honghui Zhang <honghui.zhang@mediatek.com>, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 05, 2017 at 12:52:43PM +0800, Ryder Lee wrote:
> Hi Honghui, Bjorn,
> 
> On Fri, 2017-08-04 at 08:18 -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 04, 2017 at 04:39:36PM +0800, Honghui Zhang wrote:
> > > On Thu, 2017-08-03 at 17:42 -0500, Bjorn Helgaas wrote:
> > > > > +
> > > > > +static struct mtk_pcie_port *mtk_pcie_find_port(struct mtk_pcie *pcie,
> > > > > +						struct pci_bus *bus, int devfn)
> > > > > +{
> > > > > +	struct pci_dev *dev;
> > > > > +	struct pci_bus *pbus;
> > > > > +	struct mtk_pcie_port *port, *tmp;
> > > > > +
> > > > > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > > > +		if (bus->number == 0 && port->index == PCI_SLOT(devfn)) {
> > > > > +			return port;
> > > > > +		} else if (bus->number != 0) {
> > > > > +			pbus = bus;
> > > > > +			do {
> > > > > +				dev = pbus->self;
> > > > > +				if (port->index == PCI_SLOT(dev->devfn))
> > > > > +					return port;
> > > > > +				pbus = dev->bus;
> > > > > +			} while (dev->bus->number != 0);
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return NULL;
> > > > 
> > > > You should be able to use sysdata to avoid searching the list.
> > > > See drivers/pci/host/pci-aardvark.c, for example.
> > > > 
> > > 
> > > I could put the mtk_pcie * in sysdata, but still need to searching the
> > > list to get the mtk_pcie_port *, how about:
> > > 
> > > 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > 		if (port->index == PCI_SLOT(devfn))
> > > 			return port;
> > > 	}
> > 
> > No.  Other drivers don't need to search the list.  Please take a look
> > at them and see how they solve this problem.  I don't think your
> > hardware is fundamentally different in a way that means you need to
> > search when the others don't.
> > 
> 
> I'm not directly involved in this generation, but I guess the main
> reason why Honghui need to do that is just because this hardware
> access configuration space via per-port registers, not just for the
> guard.  Currently, We had a host bridge with two ports (two subnodes
> in binding text), thus he tried to tells them apart so that he can
> get the correct registers.
> 
> Some platforms don't need to do that since they just have a single
> port (no more subnodes), the others might have specific/shared
> registers to access configuration space. (e.g. Tegra, MTK legacy IP
> block).  Or, he can split them into two independent nodes, but it
> will break common probing flow by doing so. (I'd prefer to use
> subnodes.)

The PCI core interface (pci_scan_root_bus_bridge()) starts with
sysdata in the struct pci_host_bridge, so every PCI bus under that
host bridge has the same sysdata.  

You have multiple root ports (sounds like two ports in this case)
under that host bridge.  Each port has independent interrupt mappings,
but the MMIO address space routed to the ports is described in the
upper-level host bridge (the "pcie" node in DT).  I assume the I/O and
MMIO routing through the root ports works as described in the
PCI-to-PCI bridge spec, using PCI_MEMORY_BASE, PCI_PREF_MEMORY_BASE,
etc.

If that's the case, I think your current DT "pcie" node is
appropriate, and both ports should have the same sysdata (as they do
in your current patch), and you do need some additional way to get
from that sysdata (the struct mtk_pcie) to the per-port data (the
struct mtk_pcie_port).

Apparently the two root ports of this MT7622/MT2712 controller are
hardwired at device (PCI_SLOT) 0 and 1.  Using a list to look that up
seems like a little overkill, since you could index an array by
PCI_SLOT(), but I guess you could do it either way.

I would probably rename "port->index" to "port->slot" or similar to
make it more obvious that it's not merely the Nth port we found; it's
the one that is hardwired at PCI_SLOT N.

Also, s/mtk_pcie_parse_ports/mtk_pcie_parse_port/, since it parses one
port each time you call it.

And factor out the lookup as Ryder suggested so it's not duplicated in
the mtk_pcie_config_read()/mtk_pcie_config_write() paths.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
