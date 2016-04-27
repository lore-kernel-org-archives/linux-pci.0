Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 27 Apr 2016 16:10:36 +0100
From: Liviu.Dudau@arm.com
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	ddaney@caviumnetworks.com, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jcm@redhat.com
Subject: Re: [PATCH V6 05/13] acpi, pci: Support IO resources when parsing
 PCI host bridge resources.
Message-ID: <20160427151035.GT28464@e106497-lin.cambridge.arm.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-6-git-send-email-tn@semihalf.com>
 <20160427023916.GF6789@localhost>
 <20160427141429.GA7324@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160427141429.GA7324@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 27, 2016 at 03:26:59PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Apr 26, 2016 at 09:39:16PM -0500, Bjorn Helgaas wrote:
> > On Fri, Apr 15, 2016 at 07:06:40PM +0200, Tomasz Nowicki wrote:
> > > Platforms that have memory mapped IO port (such as ARM64) need special
> > > handling for PCI I/O resources. For host bridge's resource probing case
> > > these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.
> > 
> > ia64 also has memory-mapped I/O port space.  It would be ideal to find
> > some way to handle ia64 and ARM64 similarly.  At the very least, we
> > have to make sure that this doesn't break ia64.  The ia64 dense/sparse
> > I/O spaces complicate things; I don't know if ARM64 has something
> > similar or not.
> 
> No it does not, and that's exactly the same problem we faced with
> the DT generic version of of_pci_range_to_resource() which basically
> relies on PCI_IOBASE to be defined to add code that creates IO port
> resources out of the MMIO resource describing how IO port space is
> mapped to MMIO (physical) address space.
> 
> IIRC everything hinges on PCI_IOBASE definition to make sure that
> of_pci_range_to_resource() *works*, which means that if PCI_IOBASE is
> not defined (ie IA64) that code - acpi_pci_root_remap_iospace() in this
> case - does nothing.
> 
> So acpi_pci_root_remap_iospace() is of_pci_range_to_resource() ACPI
> equivalent + the pci_remap_iospace() call (I have to dig into the
> logs to check why Liviu did not add a call to pci_remap_iospace()
> in of_pci_get_host_bridge_resources() - I want to do that actually).

Because of_pci_get_host_bridge_resources() only gives you a list of resources,
it doesn't allocate them. An arch or platform could add further filtering
to that list before it gets requested (in our case it is done in pci-host-common.c)

Best regards,
Liviu

> 
> The point here is: IO space (in DT and ACPI) handling is arch specific.
> 
> For DT, by relying on PCI_IOBASE, we left that code in drivers/of and
> it works (well, with some niggles - see the thread with Murali on IO
> space on TI keystone) for ARM/ARM64.
> 
> http://www.spinics.net/lists/linux-pci/msg49725.html
> 
> What are we going to do with the ACPI version ?
> 
> Do we want to add an arch specific call that takes the raw resource
> describing IO space and creates an IO port resource (and the MMIO
> equivalent - that's what add_io_space() does in IA64) and use that
> in generic ACPI parsing code ?
> 
> Or we just do what Tomasz does, which is basically the approach we took
> for DT ?
> 
> > > Furthermore, the same I/O resources need to be released after hotplug
> > > removal so that it can be re-added back by the pci_remap_iospace
> > > function during insertion. Therefore we implement new pci_unmap_iospace call
> > > which unmaps I/O space as the symmetry to pci_remap_iospace.
> > 
> > "Furthermore" is a hint that we should check to see if this can be
> > split into two patches.
> > 
> > We already have a pci_remap_iospace(), and you're adding
> > pci_unmap_iospace(), which will be used for hotplug removal.  So let's 
> > add pci_unmap_iospace() first in a patch by itself because that's
> > potentially useful for other callers of pci_remap_iospace(), even if
> > they don't need the acpi_pci_root_remap_iospace() stuff.
> 
> I agree.
> 
> Thanks,
> Lorenzo
> 
> > > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > ---
> > >  drivers/acpi/pci_root.c | 33 +++++++++++++++++++++++++++++++++
> > >  drivers/pci/pci.c       | 24 ++++++++++++++++++++++++
> > >  include/linux/pci.h     |  1 +
> > >  3 files changed, 58 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index d9a70c4..815b6ca 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -742,6 +742,34 @@ next:
> > >  			resource_list_add_tail(entry, resources);
> > >  	}
> > >  }
> > > +static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
> > > +{
> > > +#ifdef PCI_IOBASE
> > > +	struct resource *res = entry->res;
> > > +	resource_size_t cpu_addr = res->start;
> > > +	resource_size_t pci_addr = cpu_addr - entry->offset;
> > > +	resource_size_t length = resource_size(res);
> > > +	unsigned long port;
> > > +
> > > +	if (pci_register_io_range(cpu_addr, length))
> > > +		goto err;
> > > +
> > > +	port = pci_address_to_pio(cpu_addr);
> > > +	if (port == (unsigned long)-1)
> > > +		goto err;
> > > +
> > > +	res->start = port;
> > > +	res->end = port + length - 1;
> > > +	entry->offset = port - pci_addr;
> > > +
> > > +	if (pci_remap_iospace(res, cpu_addr) < 0)
> > > +		goto err;
> > > +	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
> > > +	return;
> > > +err:
> > > +	res->flags |= IORESOURCE_DISABLED;
> > > +#endif
> > > +}
> > >  
> > >  int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
> > >  {
> > > @@ -763,6 +791,9 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
> > >  			"no IO and memory resources present in _CRS\n");
> > >  	else {
> > >  		resource_list_for_each_entry_safe(entry, tmp, list) {
> > > +			if (entry->res->flags & IORESOURCE_IO)
> > > +				acpi_pci_root_remap_iospace(entry);
> > > +
> > >  			if (entry->res->flags & IORESOURCE_DISABLED)
> > >  				resource_list_destroy_entry(entry);
> > >  			else
> > > @@ -834,6 +865,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
> > >  
> > >  	resource_list_for_each_entry(entry, &bridge->windows) {
> > >  		res = entry->res;
> > > +		if (res->flags & IORESOURCE_IO)
> > > +			pci_unmap_iospace(res);
> > >  		if (res->parent &&
> > >  		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> > >  			release_resource(res);
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 89e9996..c0f8a4e 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/device.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/pci_hotplug.h>
> > > +#include <linux/vmalloc.h>
> > >  #include <asm/setup.h>
> > >  #include <linux/aer.h>
> > >  #include "pci.h"
> > > @@ -3168,6 +3169,29 @@ int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > >  #endif
> > >  }
> > >  
> > > +/**
> > > + *	pci_unmap_iospace - Unmap the memory mapped I/O space
> > > + *	@res: resource to be unmapped
> > > + *
> > > + *	Unmap the CPU virtual address @res from virtual address space.
> > > + *	Only architectures that have memory mapped IO functions defined
> > > + *	(and the PCI_IOBASE value defined) should call this function.
> > > + */
> > > +void  pci_unmap_iospace(struct resource *res)
> > > +{
> > > +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
> > > +	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> > > +
> > > +	unmap_kernel_range(vaddr, resource_size(res));
> > > +#else
> > > +	/*
> > > +	 * This architecture does not have memory mapped I/O space,
> > > +	 * so this function should never be called.
> > > +	 */
> > > +	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
> > > +#endif
> > > +}
> > > +
> > >  static void __pci_set_master(struct pci_dev *dev, bool enable)
> > >  {
> > >  	u16 old_cmd, cmd;
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index c28adb4..df1f33d 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1168,6 +1168,7 @@ int pci_register_io_range(phys_addr_t addr, resource_size_t size);
> > >  unsigned long pci_address_to_pio(phys_addr_t addr);
> > >  phys_addr_t pci_pio_to_address(unsigned long pio);
> > >  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> > > +void pci_unmap_iospace(struct resource *res);
> > >  
> > >  static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
> > >  {
> > > -- 
> > > 1.9.1
> > > 
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
