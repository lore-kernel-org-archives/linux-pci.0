Return-Path: <SRS0=QVVl=ZL=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=QVVl=ZL=wunner.de=lukas@kernel.org>
Date: Sun, 29 Jan 2017 01:26:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170129002616.GA28225@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
 <bfabf33fc63abbeb84e11e544456098dff0e4604.1484486499.git.lukas@wunner.de>
 <20170128215208.GM20550@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170128215208.GM20550@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 28, 2017 at 03:52:08PM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> > We're about to allow runtime PM on Thunderbolt ports in
> > pci_bridge_d3_possible() and unblock runtime PM for Thunderbolt host
> > hotplug ports in pci_dev_check_d3cold().  In both cases we need to
> > uniquely identify if a PCI device belongs to a Thunderbolt controller.
> 
> Sounds like "a device belongs to a Thunderbolt controller" means the
> device is part of a Thunderbolt controller or part of the hierarchy
> below it?

The above paragraph and the following two in the commit message are
intended to explain the need for this additional bit in struct pci_dev.

Yes, the bit is set on all PCI devices that are part of the Thunderbolt
controller (upstream bridge, downstream bridges, NHI and on Thunderbolt 3
there's also an XHCI) as well as on all PCI devices below it.

That's why it says /* part of Thunderbolt daisy chain */ in the line
added to pci.h at the bottom of this patch.


> > We also have the need to detect presence of a Thunderbolt controller in
> > drivers/platform/x86/apple-gmux.c because dual GPU MacBook Pros cannot
> > switch external DP/HDMI ports between GPUs if they have Thunderbolt.
> 
> This series doesn't touch apple-gmux.c, and I don't know anything
> about this MacBook Pro topology, so I can't tell why Thunderbolt is
> relevant here.

It's just another example why this bit in struct pci_dev is needed:

Dual GPU MacBook Pros introduced before 2011 are able to switch the
external DisplayPort between GPUs.  All newer models lost this ability
and the external port can only be driven by the discrete GPU.  That's
because the port is no longer just used for DisplayPort, it's become a
combined DP/Thunderbolt port.  I guess the wiring would have been too
complicated to keep the external port switchable between GPUs and also
use it for Thunderbolt.  They already had to go to great lengths and
put various redrivers on the logic board to support the combined
DP/thunderbolt port.

We need to recognize if the model has Thunderbolt and in that case keep
the external port switched to the discrete GPU.  I have a patch for this
in the pipeline but this one needs to go in first.


> > Furthermore, in multiple places in the DRM subsystem we need to detect
> > whether a GPU is on-board or attached with Thunderbolt.  As an example,
> > Thunderbolt-attached GPUs shall not be registered with vga_switcheroo.
> 
> Why?  The connection between vga_switcheroo and Thunderbolt is not
> obvious, at least to this non-GPU person.

nouveau, radeon and amdgpu register any GPU they find with vga_switcheroo,
but vga_switcheroo only becomes enabled if the system has Optimus, AMD
PowerXpress or an apple-gmux controller.

If the user connects an external GPU to a dual GPU laptop, that external
GPU will be registered with vga_switcheroo as well.  When that external
GPU runtime suspends, vga_switcheroo will invoke the callback to cut
power to the internal discrete GPU and obviously things go south at that
point.

The solution is to not register external GPUs with vga_switcheroo at all.
For this I need the is_thunderbolt bit.


[snip]
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1206,6 +1206,37 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
> >  		pdev->is_hotplug_bridge = 1;
> >  }
> >  
> > +static void set_pcie_vendor_specific(struct pci_dev *dev)
> 
> This is very specific to Thunderbolt, so let's name it something that
> conveys that information.  The fact that we use a vendor-specific
> capability to figure it out isn't really relevant in the caller.

I thought that we may have the necessity in the future to parse other
VSECs on device probe, so I gave the function this generic name.

Think about it, every VSEC that needs to be parsed needs the while loop
below.  It's more efficient to have only a single while loop that handles
*all* VSECs at once.

If someone needs to parse another VSEC, they just add it to this function.
So IMO the way I've solved it is preferable to just adding a Thunderbolt-
specific function.

Are you sure you want this renamed? (y/n)


> > +{
> > +	int vsec = 0;
> > +	u32 header;
> > +
> > +	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> > +						    PCI_EXT_CAP_ID_VNDR))) {
> > +		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> > +
> > +		/* Is the device part of a Thunderbolt controller? */
> > +		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> > +		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT)
> > +			dev->is_thunderbolt = 1;
> 
> 			return;

Well, see above.  I don't want to return here to allow parsing other VSECs.

Thanks,

Lukas

> > +	}
> > +
> > +	/*
> > +	 * Is the device attached with Thunderbolt?  Walk upwards and check for
> > +	 * each encountered bridge if it's part of a Thunderbolt controller.
> > +	 * Reaching the host bridge means dev is soldered to the mainboard.
> > +	 */
> > +	if (!dev->is_thunderbolt) {
> 
> The "if" is unnecessary if you return above.
> 
> > +		struct pci_dev *parent = dev;
> > +
> > +		while ((parent = pci_upstream_bridge(parent)))
> > +			if (parent->is_thunderbolt) {
> > +				dev->is_thunderbolt = 1;
> > +				break;
> > +			}
> > +	}
> > +}
> > +
> >  /**
> >   * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
> >   * @dev: PCI device
> > @@ -1358,6 +1389,9 @@ int pci_setup_device(struct pci_dev *dev)
> >  	/* need to have dev->class ready */
> >  	dev->cfg_size = pci_cfg_space_size(dev);
> >  
> > +	/* need to have dev->cfg_size ready */
> > +	set_pcie_vendor_specific(dev);
> > +
> >  	/* "Unknown power state" */
> >  	dev->current_state = PCI_UNKNOWN;
> >  
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index e2d1a124216a..3c775e8498f1 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -358,6 +358,7 @@ struct pci_dev {
> >  	unsigned int	is_virtfn:1;
> >  	unsigned int	reset_fn:1;
> >  	unsigned int    is_hotplug_bridge:1;
> > +	unsigned int	is_thunderbolt:1; /* part of Thunderbolt daisy chain */
> >  	unsigned int    __aer_firmware_first_valid:1;
> >  	unsigned int	__aer_firmware_first:1;
> >  	unsigned int	broken_intx_masking:1;
> > -- 
> > 2.11.0
> > 
