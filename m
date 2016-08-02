Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Tue, 2 Aug 2016 18:27:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 07/13] PCI: pciehp: Ignore interrupts during D3cold
Message-ID: <20160802162740.GA4036@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <98a243badc295903ec4cf7de5e2985b468c45907.1463134231.git.lukas@wunner.de>
 <20160617225204.GC10416@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160617225204.GC10416@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 05:52:04PM -0500, Bjorn Helgaas wrote:
> On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> > If a hotplug port is suspended to D3cold, its slot status register
> > cannot be read.  If that hotplug port happens to share its IRQ with
> > other devices, then whenever an interrupt occurs for one of these
> > devices, a "no response from device" message is logged with level
> > KERN_INFO.  Apart from this annoyance, CPU time is needlessly spent
> > trying to read the slot status register even though we know in advance
> > that it will fail.
> 
> I guess this is a pretty generic problem that could affect any device
> that shares an IRQ.
> 
> I think I'll queue this on my pci/pm branch, since it seems closely
> related to Mika's "PCI: Add runtime PM support for PCIe ports".
> 
> Did you check for the same issue in other likely places, e.g., AER,
> PME, etc.?

Apologies for the delay, I've checked all other port services now:

- Our AER and PME drivers bind only to root ports and I can't imagine
  how those could go to D3cold, they're part of the root complex or
  PCH and I'm not aware of a chipset that would allow turning off the
  power well for individual PCIe ports.

- DPC on the other hand also binds to downstream ports. I do have
  downstream ports in my machine (as part of the Thunderbolt switch)
  but they do not have the DPC capability. I've never seen devices
  with that capability and cannot estimate what the chances are of them
  going to D3cold and sharing an IRQ with other devices. It's probably
  not worth preparing for such a situation without knowing its likelihood.

- VC: We allocate a port service for this but do not have a driver.

Bottom line is that the patch for the PCIe hotplug driver seems to be
sufficient.

FWIW, on my machine I see numerous devices with AER, PME and VC
capabilities. The Nvidia GPU as well as network, Firewire and
Thunderbolt controllers all have those. AFAICS we ignore them
because their specific drivers do not care for the capabilities
and portdrv only binds to root ports.

This seems to support your argument that the PCIe capabilities
should be handled by the core rather than portdrv, as we could
then make use of the capabilities on endpoint devices in a
universal manner.

On the other hand, I think we cannot use a separate MSI for
AER, PME et al, can we? If we cannot, then AER and PME would
share the IRQ with an endpoint device's regular interrupt handler,
and that might ruin performance. E.g. the Broadcom wireless card
generates millions of interrupts on a sufficiently active WiFi.
Accessing the device's config space on every interrupt just to
check for AER or PME seems like a bad idea. So at the very least
we'd need some kind of opt-out.

Best regards,

Lukas

> > On MacBook Pros introduced 2011 and 2012, the IRQ of a Thunderbolt
> > hotplug port is unfortunately shared with a wireless card, an audio card
> > and an SDXC controller.  When the Thunderbolt controller is powered
> > down, the machine carries out at least one unneeded slot status register
> > read for each wireless packet received and prints a corresponding error
> > message to the system log.
> > 
> > The hotplug port's current_state will be D3cold when it's powered down,
> > so ignore interrupts that occur during that power state.
> > 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 5c24e93..08e84d6 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -546,6 +546,10 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
> >  	u8 present;
> >  	bool link;
> >  
> > +	/* Interrupts cannot originate from a controller that's asleep */
> > +	if (pdev->current_state == PCI_D3cold)
> > +		return IRQ_NONE;
> > +
> >  	/*
> >  	 * In order to guarantee that all interrupt events are
> >  	 * serviced, we need to re-inspect Slot Status register after
> > -- 
> > 2.8.1
