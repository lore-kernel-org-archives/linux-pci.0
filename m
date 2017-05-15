Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 15 May 2017 10:17:49 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFC/RFT PATCH 3/3] PCI/ACPI: Add ACPI pci_bus_find_numa_node()
 implementation
Message-ID: <20170515091749.GA14348@red-moon>
References: <20170426100619.31758-1-lorenzo.pieralisi@arm.com>
 <20170426100619.31758-3-lorenzo.pieralisi@arm.com>
 <5919471B.7080607@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5919471B.7080607@hisilicon.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 02:13:47PM +0800, Zhou Wang wrote:
> On 2017/4/26 18:06, Lorenzo Pieralisi wrote:
> > The introduction of pci_bus_find_numa_node(pci_bus) allows at PCI
> > host bridge registration to detect the NUMA node for a given
> > struct pci_bus.dev. Implement an ACPI method that, through
> > the struct pci_bus.bridge ACPI companion, retrieve and return
> > the NUMA node corresponding to a given struct pci_bus.dev.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci-acpi.c | 20 ++++++++++++++++++++
> >  include/linux/pci.h    |  6 ++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 0018603..915da79 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/numa.h>
> >  #include <linux/pci.h>
> >  #include <linux/msi.h>
> >  #include <linux/pci_hotplug.h>
> > @@ -853,6 +854,25 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus)
> >  	return irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI);
> >  }
> >  
> > +int acpi_pci_bus_find_numa_node(struct pci_bus *bus)
> > +{
> > +	int node = NUMA_NO_NODE;
> > +	struct device *bridge = get_device(bus->bridge);
> > +
> > +	if (!bridge)
> > +		return node;
> > +
> > +	if (has_acpi_companion(bridge)) {
> > +		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
> > +
> > +		node = acpi_get_node(adev->handle);
> > +	}
> > +
> > +	put_device(bridge);
> > +
> > +	return node;
> > +}
> > +
> 
> It seems there is no function to call this, am I right?

Sorry, I missed updating pci_bus_find_numa_node() while reshuffling
the code, apologies.

I will repost shortly.

> Another question is that: in the latest IORT revision C, "Proximity
> domain" has been added to the IORT spec.  So when we enable NUMA for a
> PCIe device, should we also consider this?

That's for the SMMU device.

Lorenzo

> Thanks,
> Zhou
> 
> >  static int __init acpi_pci_init(void)
> >  {
> >  	int ret;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9e62462..b40d095 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1481,6 +1481,12 @@ static inline int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
> >  #endif
> >  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent);
> >  #endif
> > +#ifdef CONFIG_ACPI
> > +int acpi_pci_bus_find_numa_node(struct pci_bus *bus);
> > +#else
> > +static inline int acpi_pci_bus_find_numa_node(struct pci_bus *bus)
> > +{ return NUMA_NO_NODE; }
> > +#endif
> >  int pci_bus_find_numa_node(struct pci_bus *bus);
> >  
> >  /* some architectures require additional setup to direct VGA traffic */
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
