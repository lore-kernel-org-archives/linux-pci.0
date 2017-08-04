Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 4 Aug 2017 08:18:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH v2 4/5] PCI: mediatek: Add new generation controller
 support
Message-ID: <20170804131808.GA16580@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <824c61d13fe2731d812df8a0a878ca1a36399e76.1501122135.git.honghui.zhang@mediatek.com>
 <20170803224206.GN20308@bhelgaas-glaptop.roam.corp.google.com>
 <1501835976.24341.21.camel@mtksdaap41>
MIME-Version: 1.0
In-Reply-To: <1501835976.24341.21.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, yt.shen@mediatek.com,
 matthias.bgg@gmail.com, robh@kerenl.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, bhelgaas@google.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 04:39:36PM +0800, Honghui Zhang wrote:
> On Thu, 2017-08-03 at 17:42 -0500, Bjorn Helgaas wrote:
> 
> 
> ......
> > > +}
> > > +
> > > +static struct mtk_pcie_port *mtk_pcie_find_port(struct mtk_pcie *pcie,
> > > +						struct pci_bus *bus, int devfn)
> > > +{
> > > +	struct pci_dev *dev;
> > > +	struct pci_bus *pbus;
> > > +	struct mtk_pcie_port *port, *tmp;
> > > +
> > > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > +		if (bus->number == 0 && port->index == PCI_SLOT(devfn)) {
> > > +			return port;
> > > +		} else if (bus->number != 0) {
> > > +			pbus = bus;
> > > +			do {
> > > +				dev = pbus->self;
> > > +				if (port->index == PCI_SLOT(dev->devfn))
> > > +					return port;
> > > +				pbus = dev->bus;
> > > +			} while (dev->bus->number != 0);
> > > +		}
> > > +	}
> > > +
> > > +	return NULL;
> > 
> > You should be able to use sysdata to avoid searching the list.
> > See drivers/pci/host/pci-aardvark.c, for example.
> > 
> 
> I could put the mtk_pcie * in sysdata, but still need to searching the
> list to get the mtk_pcie_port *, how about:
> 
> 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> 		if (port->index == PCI_SLOT(devfn))
> 			return port;
> 	}

No.  Other drivers don't need to search the list.  Please take a look
at them and see how they solve this problem.  I don't think your
hardware is fundamentally different in a way that means you need to
search when the others don't.

> > > +	 * Enable rc internal reset.
> > > +	 * The reset will work when the link is from link up to link down.
> > 
> > ?  That sentence doesn't parse for me.
> 
> What about:
> 
> 	/*
> 	 * Enable PCIe link down reset, if link status changed from link up to
> 	 * link down, this will reset MAC control registers and configuration
> 	 * space.
> 	 */

That at least parses as a sentence.

> > > +	port->irq_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
> > > +						 &intx_domain_ops, port);
> > 
> > I think there's an issue here with a 4-element IRQ domain and the
> > hwirq numbers 1-4 from the of_irq_parse_and_map_pci() path, so INTD
> > may not work correctly.
> > 
> > See
> > http://lkml.kernel.org/r/20170801212931.GA26498@bhelgaas-glaptop.roam.corp.google.com
> > and related discussion.
> 
> Sorry, I did not get this,
> I do some test with an intel E350T4 PCIe NICs, it's a x1 lane
> multi-function device.
> What I got from the log is below:
> ->of_irq_parse_and_map_pci
> 	->of_irq_parse_pci
> 		->irq_create_of_mapping
> 			->irq_create_fwspec_mapping
> 				->irq_domain_translate
> 				which will go through
> 				d->ops->translate #the hwirq really start from 0
> 
> And I tested every NIC port of the Intel E350T4 with tftp transfer data,
> seems all are OK with this code.

OK.  I don't know what d->ops->translate is involved here, but if it
works, I guess this is OK for now.  We're trying to clean this up and
make it consistent across all the drivers.  Many of them allocate a
5-element IRQ domain, some make a 4-element domain, and on some of
them INTD doesn't work.  It's a mess.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
