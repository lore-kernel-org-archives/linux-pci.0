Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58549 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbcBVQRw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 11:17:52 -0500
Date: Mon, 22 Feb 2016 16:17:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
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
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V4 5/5] Microblaze: Modifying microblaze PCI subsytem to
 support  generic Xilinx  AXI PCIe Host Bridge IP driver
Message-ID: <20160222161745.GL3435@leverpostej>
References: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
 <1455208091-15556-6-git-send-email-bharatku@xilinx.com>
 <8520D5D51A55D047800579B09414719825884643@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B09414719825884643@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 22, 2016 at 04:01:15PM +0000, Bharat Kumar Gogada wrote:
> Ping

Please trim your To line, and state who you're pinging, and specifically
what you are pinging for. You'll have much better luck with targetted
replies.

Given the number of people in the To line, no-one knows if they're being
poked, or if someone else is. Given the lack of any question/statement
with your ping, it's not clear what you're asking for.

The DT parts of this series already appear to have been reviewed, so
there's no reason to keep myself and other DT maintainers on the To
line for this patch.

Mark.

> 
> > Subject: [PATCH V4 5/5] Microblaze: Modifying microblaze PCI subsytem to
> > support generic Xilinx AXI PCIe Host Bridge IP driver
> > 
> > This patch does required modifications to microblaze PCI subsystem, to work
> > with generic driver (drivers/pci/host/pcie-xilinx.c) on Microblaze and Zynq.
> > 
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > ---
> > Changes:
> > Removed pcibios_get_phb_of_node in pci-common.c, using generic version
> > instead.
> > Modified pcibios_fixup_bus in pci-common.c, as per generic architecuture.
> > Modified pcibios_align_resource in pci-common.c, as per generic
> > architecuture, removed temporary variable.
> > Removed pci_domain_nr in pci-common.c, instead using generic code.
> > Added pcibios_add_device in pci-common.c, as per generic architecuture.
> > Adding Kernel configuration in arch/microblaze as required for generic PCI
> > domains.
> > Added kernel configuration for driver to support Microblaze.
> > ---
> >  arch/microblaze/Kconfig          |  3 +++
> >  arch/microblaze/pci/pci-common.c | 56 +++++++---------------------------------
> >  drivers/pci/host/Kconfig         |  2 +-
> >  3 files changed, 14 insertions(+), 47 deletions(-)
> > 
> > diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig index
> > 0bce820..c3702b9 100644
> > --- a/arch/microblaze/Kconfig
> > +++ b/arch/microblaze/Kconfig
> > @@ -271,6 +271,9 @@ config PCI
> >  config PCI_DOMAINS
> >  	def_bool PCI
> > 
> > +config PCI_DOMAINS_GENERIC
> > +	def_bool PCI_DOMAINS
> > +
> >  config PCI_SYSCALL
> >  	def_bool PCI
> > 
> > diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-
> > common.c
> > index ae838ed..35654be 100644
> > --- a/arch/microblaze/pci/pci-common.c
> > +++ b/arch/microblaze/pci/pci-common.c
> > @@ -123,17 +123,6 @@ unsigned long pci_address_to_pio(phys_addr_t
> > address)  }  EXPORT_SYMBOL_GPL(pci_address_to_pio);
> > 
> > -/*
> > - * Return the domain number for this bus.
> > - */
> > -int pci_domain_nr(struct pci_bus *bus)
> > -{
> > -	struct pci_controller *hose = pci_bus_to_host(bus);
> > -
> > -	return hose->global_number;
> > -}
> > -EXPORT_SYMBOL(pci_domain_nr);
> > -
> >  /* This routine is meant to be used early during boot, when the
> >   * PCI bus numbers have not yet been assigned, and you need to
> >   * issue PCI config cycles to an OF device.
> > @@ -863,26 +852,10 @@ void pcibios_setup_bus_devices(struct pci_bus
> > *bus)
> > 
> >  void pcibios_fixup_bus(struct pci_bus *bus)  {
> > -	/* When called from the generic PCI probe, read PCI<->PCI bridge
> > -	 * bases. This is -not- called when generating the PCI tree from
> > -	 * the OF device-tree.
> > -	 */
> > -	if (bus->self != NULL)
> > -		pci_read_bridge_bases(bus);
> > -
> > -	/* Now fixup the bus bus */
> > -	pcibios_setup_bus_self(bus);
> > -
> > -	/* Now fixup devices on that bus */
> > -	pcibios_setup_bus_devices(bus);
> > +	/* nothing to do */
> >  }
> >  EXPORT_SYMBOL(pcibios_fixup_bus);
> > 
> > -static int skip_isa_ioresource_align(struct pci_dev *dev) -{
> > -	return 0;
> > -}
> > -
> >  /*
> >   * We need to avoid collisions with `mirrored' VGA ports
> >   * and other strange ISA hardware, so we always want the @@ -899,20
> > +872,18 @@ static int skip_isa_ioresource_align(struct pci_dev *dev)
> > resource_size_t pcibios_align_resource(void *data, const struct resource
> > *res,
> >  				resource_size_t size, resource_size_t align)  {
> > -	struct pci_dev *dev = data;
> > -	resource_size_t start = res->start;
> > -
> > -	if (res->flags & IORESOURCE_IO) {
> > -		if (skip_isa_ioresource_align(dev))
> > -			return start;
> > -		if (start & 0x300)
> > -			start = (start + 0x3ff) & ~0x3ff;
> > -	}
> > -
> > -	return start;
> > +	return res->start;
> >  }
> >  EXPORT_SYMBOL(pcibios_align_resource);
> > 
> > +int pcibios_add_device(struct pci_dev *dev) {
> > +	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(pcibios_add_device);
> > +
> >  /*
> >   * Reparent resource children of pr that conflict with res
> >   * under res, and make res replace those children.
> > @@ -1333,13 +1304,6 @@ static void pcibios_setup_phb_resources(struct
> > pci_controller *hose,
> >  		 (unsigned long)hose->io_base_virt - _IO_BASE);  }
> > 
> > -struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus) -{
> > -	struct pci_controller *hose = bus->sysdata;
> > -
> > -	return of_node_get(hose->dn);
> > -}
> > -
> >  static void pcibios_scan_phb(struct pci_controller *hose)  {
> >  	LIST_HEAD(resources);
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig index
> > d5e58ba..7c56c2e 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -79,7 +79,7 @@ config PCI_KEYSTONE
> > 
> >  config PCIE_XILINX
> >  	bool "Xilinx AXI PCIe host bridge support"
> > -	depends on ARCH_ZYNQ
> > +	depends on ARCH_ZYNQ || MICROBLAZE
> >  	help
> >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> >  	  Host Bridge driver.
> > --
> > 2.1.1
> 
