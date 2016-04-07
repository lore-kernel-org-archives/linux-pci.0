Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 7 Apr 2016 12:42:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pci: Added flag to pci_host_bridge to hint not to use
 acpi
Message-ID: <20160407174224.GE8780@localhost>
References: <1458770518-10203-1-git-send-email-jonathan.derrick@intel.com>
 <20160324164159.GB25518@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160324164159.GB25518@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-acpi]

On Thu, Mar 24, 2016 at 04:42:00PM +0000, Keith Busch wrote:
> On Wed, Mar 23, 2016 at 04:01:58PM -0600, Jon Derrick wrote:
> > This patch adds a hint, no_acpi, to the pci_host_bridge struct which
> > informs the hotplug driver to not try and release the host bridge from
> > acpi.
> > 
> > The VMD driver creates a root port which does not have an acpi entry.
> > This patch will allow the hotplug driver to bypass acpi release when
> > enumerating the VMD root port as a hotplug slot.
> 
> I want to add a little context to this for the motivation for this
> implementation.
> 
> Currently we have to set kernel parameter "pcie_ports=native" for pciehp
> to work on these domains since they are not known to ACPI. We don't want
> to force a system wide PCIe parameter for something specific to a subset
> of domains.

I agree, we shouldn't have to ask users to boot with
"pcie_ports=native".

The PCIe port driver figures out what service drivers can be enabled
by a combination of:

  - asking the platform what services it will allow the kernel to
    manage (on ACPI systems, this uses _OSC), and

  - looking at the PCIe capability to see what services the hardware
    supports.

This happens in get_port_device_capability().  When you boot with
"pcie_ports=native", get_port_device_capability() skips the _OSC part
and only looks at what the hardware supports.

Here's the rest of the path:

  pcie_portdrv_probe                     # pci_driver.probe
    pcie_port_device_register
      get_port_device_capability
        if (pcie_ports_auto)             # cleared by pcie_port=native
	  pcie_port_platform_notify
	    pcie_port_acpi_setup
	      if (no_acpi)               # added by your patch
		return 0
	      handle = acpi_find_root_bridge_handle(port)
	      if (!handle)
	        return -EINVAL
	      set mask of what we control based on _OSC
	      return 0

The spec (PCI Firmware spec 3.0, sec 4.5) says _OSC is a child of an
ACPI device and applies to that device.  In your case, I think there
is no ACPI PNP0A0x device for the VMD host bridge, and hence there is
no _OSC method for it.  There's no ACPI handle for the VMD bridge, so
I think pcie_port_acpi_setup() returns -EINVAL, which causes
get_port_device_capability() to give up and decide that the port
can't support *any* PCIe services.

I think that's the real problem: the fact that there's no ACPI device
corresponding to the bridge should not be an error.  It should just
mean the platform doesn't have an opportunity to limit what services
the kernel can manage.  I think pcie_port_acpi_setup() should return 0
in all cases.  Can you try that and see if it fixes the problem?

Bjorn

> >  arch/x86/pci/vmd.c              | 4 ++++
> >  drivers/pci/pcie/portdrv_acpi.c | 5 +++++
> >  include/linux/pci.h             | 1 +
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> > index 7792aba..a196be3 100644
> > --- a/arch/x86/pci/vmd.c
> > +++ b/arch/x86/pci/vmd.c
> > @@ -531,6 +531,7 @@ static int vmd_find_free_domain(void)
> >  static int vmd_enable_domain(struct vmd_dev *vmd)
> >  {
> >  	struct pci_sysdata *sd = &vmd->sysdata;
> > +	struct pci_host_bridge *host_bridge;
> >  	struct resource *res;
> >  	u32 upper_bits;
> >  	unsigned long flags;
> > @@ -609,6 +610,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
> >  		return -ENODEV;
> >  	}
> >  
> > +	host_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > +	host_bridge->no_acpi = true;
> > +
> >  	vmd_attach_resources(vmd);
> >  	vmd_setup_dma_ops(vmd);
> >  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> > diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
> > index b4d2894..0e6fa69 100644
> > --- a/drivers/pci/pcie/portdrv_acpi.c
> > +++ b/drivers/pci/pcie/portdrv_acpi.c
> > @@ -35,12 +35,17 @@
> >  int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
> >  {
> >  	struct acpi_pci_root *root;
> > +	struct pci_host_bridge *host_bridge;
> >  	acpi_handle handle;
> >  	u32 flags;
> >  
> >  	if (acpi_pci_disabled)
> >  		return 0;
> >  
> > +	host_bridge = pci_find_host_bridge(port->bus);
> > +	if (host_bridge && host_bridge->no_acpi)
> > +		return 0;
> > +
> >  	handle = acpi_find_root_bridge_handle(port);
> >  	if (!handle)
> >  		return -EINVAL;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 15f466e..a6958e9b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -407,6 +407,7 @@ struct pci_host_bridge {
> >  	void (*release_fn)(struct pci_host_bridge *);
> >  	void *release_data;
> >  	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
> > +	unsigned int no_acpi:1;			/* bypasses acpi release */
> >  	/* Resource alignment requirements */
> >  	resource_size_t (*align_resource)(struct pci_dev *dev,
> >  			const struct resource *res,
> > -- 
> > 1.8.3.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
