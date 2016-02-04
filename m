Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54240 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965345AbcBDOvx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 09:51:53 -0500
Date: Thu, 4 Feb 2016 08:51:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"paul.burton@imgtec.com" <paul.burton@imgtec.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V2 5/5] Microblaze: Modifying microblaze PCI subsytem to
 support  generic Xilinx  AXI PCIe Host Bridge IP driver
Message-ID: <20160204145148.GA26361@localhost>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-6-git-send-email-bharatku@xilinx.com>
 <20160203163207.GC32546@localhost>
 <20160203163805.GA6112@localhost>
 <8520D5D51A55D047800579B0941471982587F199@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B0941471982587F199@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 05:49:20AM +0000, Bharat Kumar Gogada wrote:
> > Subject: Re: [PATCH V2 5/5] Microblaze: Modifying microblaze PCI subsytem
> > to support generic Xilinx AXI PCIe Host Bridge IP driver
> > 
> > [+cc Ben for real this time]
> > 
> > On Wed, Feb 03, 2016 at 10:32:07AM -0600, Bjorn Helgaas wrote:
> > > [+cc Ben, pcibios_get_phb_of_node() question]
> > >
> > > On Tue, Jan 12, 2016 at 11:06:13PM +0530, Bharat Kumar Gogada wrote:
> > > > This patch does required modifications to microblaze PCI subsystem,
> > > > to work with generic driver (drivers/pci/host/pcie-xilinx.c) on
> > > > Microblaze and Zynq.
> > > >
> > > > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com> ...
> > >
> > > >  resource_size_t pcibios_align_resource(void *data, const struct resource
> > *res,
> > > >  				resource_size_t size, resource_size_t align)  {
> > > > -	struct pci_dev *dev = data;
> > > >  	resource_size_t start = res->start;
> > > >
> > > > -	if (res->flags & IORESOURCE_IO) {
> > > > -		if (skip_isa_ioresource_align(dev))
> > > > -			return start;
> > > > -		if (start & 0x300)
> > > > -			start = (start + 0x3ff) & ~0x3ff;
> > > > -	}
> > > > -
> > > >  	return start;
> > >
> > > "return res->start;" is sufficient; no need for a temporary variable.
> > >
> Agreed will address in next patch.
> > > >  }
> > > >  EXPORT_SYMBOL(pcibios_align_resource);
> > > >
> > > > +int pcibios_add_device(struct pci_dev *dev) {
> > > > +	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(pcibios_add_device);
> > > > +
> > > >  /*
> > > >   * Reparent resource children of pr that conflict with res
> > > >   * under res, and make res replace those children.
> > > > @@ -1335,9 +1308,21 @@ static void
> > > > pcibios_setup_phb_resources(struct pci_controller *hose,
> > > >
> > > >  struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)  {
> > > > -	struct pci_controller *hose = bus->sysdata;
> > > > +	struct device_node *np;
> > > > +
> > > > +	for_each_node_by_type(np, "pci") {
> > > > +		const void *prop;
> > > > +		unsigned int bus_min;
> > > > +
> > > > +		prop = of_get_property(np, "bus-range", NULL);
> > > > +		if (!prop)
> > > > +			continue;
> > > > +		bus_min = be32_to_cpup(prop);
> > > > +		if (bus->number == bus_min)
> > > > +			return np;
> > > > +	}
> > > >
> > > > -	return of_node_get(hose->dn);
> > > > +	return NULL;
> > >
> > > Hmmm.  The old microblaze code ("return of_node_get(hose->dn);") is
> > > basically the same as the mips and powerpc versions.  The new code is
> > > basically the same as the x86 version.
> > >
> > > I like the generic weak version in drivers/pci/of.c because it doesn't
> > > use any arch-specific data, and it looks like if we just set the
> > > struct device.of_node members correctly, everything should Just Work.
> > >
> > > But Ben added both the generic and the x86 versions the same day, so
> > > there must be some complication:
> > >
> > >   98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")
> > >   3d5fe5a65af9 ("x86/devicetree: Use generic PCI <-> OF matching")
> > >
> > > So I guess my question is, why do we need a microblaze-specific
> > > version at all?
> > >
> I did not notice the weak version in /pci/of.c, I have tested with
> weak version also and it is working.  We might not need this
> microblaze specific version, but will wait for ben's reply.  

If the generic version works, and you don't need the microblaze-
specific version, just remove it and we'll get this wrapped up.  No
need to wait for Ben.

Bjorn
