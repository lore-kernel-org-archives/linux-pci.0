Return-Path: <SRS0=djuk=Z7=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=djuk=Z7=wunner.de=lukas@kernel.org>
Date: Sat, 18 Feb 2017 10:12:24 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Erik Veijola <erik.veijola@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v6 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170218091224.GA1335@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
 <fee5154ef747e34684f316a9edf1ec7f635fd0f8.1486913733.git.lukas@wunner.de>
 <20170217152903.GB10663@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217152903.GB10663@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 17, 2017 at 09:29:03AM -0600, Bjorn Helgaas wrote:
> On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > Detect on device probe whether a PCI device is part of a Thunderbolt
> > daisy chain (i.e. it is either part of a Thunderbolt controller or part
> > of the hierarchy below a Thunderbolt controller).
> 
> My problem with this is that "is_thunderbolt" is not well-defined.
> The PCI specs lay out the common vocabulary and framework for this
> area.  To keep the code maintainable, we need to connect things back
> to the specs somehow.
> 
> For example, it might make sense to have a bit that means "this device
> can generate PME from D3hot", because PME and D3hot are part of that
> common understanding of how PCI works, and we can use that information
> to design the software.
> 
> An "is_thunderbolt" bit doesn't have any of that context.  It doesn't
> say anything about how the device behaves, so I can't evaluate the
> code that uses it.

No, this *does* connect back to the spec, the Thunderbolt spec to be
specific, except that spec is not available publicly.  (I assume it's
available under NDA.)  FWIW the PCI SIG doesn't make its specs freely
available either, only to members or for $$$.  As Andreas Noever has
pointed out before, there is plenty of precedent for including
(reverse-engineered) code in the kernel for stuff that isn't public.

The rationale for this bit is that devices on a Thunderbolt daisy chain
differ from plain PCIe devices and as such require special treatment.

Thunderbolt encapsulates PCIe and other protocols such as DisplayPort
into Thunderbolt packets and tunnels them over a network of Converged I/O
switches, so what's transmitted on the wire differs significantly from
plain PCIe.  That should already make the necessity for special treatment
obvious.  I've named three use cases for the is_thunderbolt bit in the
commit message of this patch but expect there will be more in the future.
E.g. Apple has a traffic prioritization mechanism on the Converged I/O
layer which is afforded to specific devices on the PCIe layer above,
see US 9,015,384:
http://pimg-fpiw.uspto.gov/fdd/84/153/090/0.pdf


> A secondary issue is that I think whatever bit you define here should
> only be set for the actual Thunderbolt device itself.  The bit will
> presumably tell us something about how that particular device works.

I don't quite follow, the bit *does* tell us something about how the
device works, doesn't it?  That it's situated on a Thunderbolt daisy
chain, I've clearly spelled that out in the commit message as well as
in a code comment of this patch.


> This is an enumeration-time thing and could be done either as in this
> path or as a quirk, since it only affects one device.

You're contradicting yourself by suggesting to use a quirk here:

Back in 2014 an Intel engineer tried to add a PCI quirk with a long
list of Thunderbolt devices and none other than you objected that
you're "really not happy about checking a list of device IDs to identify
Thunderbolt devices.  Surely there's a better way, because a list
like this has to be updated regularly."
https://patchwork.ozlabs.org/patch/409994/

The better way you were asking for back then is to probe for presence
of the Thunderbolt VSEC, which is what this patch does.  Yet you're
still not happy.  I don't get it.

FWIW I've asked an Intel engineer for details on the contents of the
VSEC but he declined to comment:
https://lkml.org/lkml/2017/1/11/153


> If runtime code needs to know whether any upstream bridge is
> Thunderbolt, it can always search up the hierarchy.  I think that
> would improve readability because the software model would map more
> closely to the hardware situation.

That would be more expensive than just checking a bit that is searched
only once and then cached.  We have is_hotplug_bridge for just eight
places where we check presence of hotplug capability, why can't we have
is_thunderbolt?  Beats me.

Thanks,

Lukas

> 
> > Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234
> > on devices belonging to a Thunderbolt controller.  Detect presence of
> > this VSEC on the device itself or on one of its parents and cache it in
> > a newly added is_thunderbolt bit in struct pci_dev.
> > 
> > The necessity arises from the following:
> > 
> > * To power off Thunderbolt controllers on Macs when nothing is plugged
> >   in, we need to allow runtime PM on their PCIe ports in
> >   pci_bridge_d3_possible().  For this we need a way to recognize them.
> > 
> > * Dual GPU MacBook Pros introduced 2011+ can no longer switch external
> >   DisplayPort ports between GPUs.  (They're no longer just used for DP
> >   but have become combined DP/Thunderbolt ports.)  The driver to switch
> >   the ports, drivers/platform/x86/apple-gmux.c, needs to detect presence
> >   of a Thunderbolt controller and, if found, keep external ports
> >   permanently switched to the discrete GPU.
> > 
> > * If an external Thunderbolt GPU is connected to a dual GPU laptop (Mac
> >   or not), that GPU is currently registered with vga_switcheroo even
> >   though it can neither drive the laptop's panel nor be powered off by
> >   the platform.  To vga_switcheroo it will appear as if two discrete
> >   GPUs are present.  As a result, when the external GPU is runtime
> >   suspended, vga_switcheroo will cut power to the internal discrete GPU
> >   which may not be runtime suspended at all at this moment.  The
> >   solution is to not register external GPUs with vga_switcheroo, which
> >   necessitates a way to recognize if they're part of a Thunderbolt daisy
> >   chain.
> > 
> > Cc: Andreas Noever <andreas.noever@gmail.com>
> > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > Cc: Amir Levy <amir.jer.levy@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/pci.h   |  2 ++
> >  drivers/pci/probe.c | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/pci.h |  1 +
> >  3 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index cb17db242f30..45c2b8144911 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -3,6 +3,8 @@
> >  
> >  #define PCI_FIND_CAP_TTL	48
> >  
> > +#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> > +
> >  extern const unsigned char pcie_link_speed[];
> >  
> >  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 204960e70333..2fcbc535786e 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1208,6 +1208,35 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
> >  		pdev->is_hotplug_bridge = 1;
> >  }
> >  
> > +static void set_pcie_thunderbolt(struct pci_dev *dev)
> > +{
> > +	struct pci_dev *parent = dev;
> > +	int vsec = 0;
> > +	u32 header;
> > +
> > +	/* Is the device part of a Thunderbolt controller? */
> > +	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> > +						    PCI_EXT_CAP_ID_VNDR))) {
> > +		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> > +		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> > +		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
> > +			dev->is_thunderbolt = 1;
> > +			return;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Is the device attached with Thunderbolt?  Walk upwards and check for
> > +	 * each encountered bridge if it's part of a Thunderbolt controller.
> > +	 * Reaching the host bridge means dev is soldered to the mainboard.
> > +	 */
> > +	while ((parent = pci_upstream_bridge(parent)))
> > +		if (parent->is_thunderbolt) {
> > +			dev->is_thunderbolt = 1;
> > +			return;
> > +		}
> > +}
> > +
> >  /**
> >   * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
> >   * @dev: PCI device
> > @@ -1360,6 +1389,9 @@ int pci_setup_device(struct pci_dev *dev)
> >  	/* need to have dev->class ready */
> >  	dev->cfg_size = pci_cfg_space_size(dev);
> >  
> > +	/* need to have dev->cfg_size ready */
> > +	set_pcie_thunderbolt(dev);
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
