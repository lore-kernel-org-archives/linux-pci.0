Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Jul 2015 18:15:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Jason Cooper <jason@lakedaemon.net>,
	David Daney <david.daney@cavium.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Robert Richter <rrichter@cavium.com>,
	David Daney <ddaney.cavm@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] arm64, pci: Allow RC drivers to supply
 pcibios_add_device() implementation.
Message-ID: <20150717171522.GI26091@leverpostej>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-4-git-send-email-ddaney.cavm@gmail.com>
 <20150716090426.GA17097@red-moon>
 <55A7E334.3030101@caviumnetworks.com>
 <20150717110016.GB19067@red-moon>
 <55A92F95.307@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55A92F95.307@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 05:38:45PM +0100, David Daney wrote:
> On 07/17/2015 04:00 AM, Lorenzo Pieralisi wrote:
> > Hi David,
> >
> > On Thu, Jul 16, 2015 at 06:00:36PM +0100, David Daney wrote:
> >> On 07/16/2015 02:04 AM, Lorenzo Pieralisi wrote:
> >>> Hi David,
> >>>
> >>> On Wed, Jul 15, 2015 at 05:54:43PM +0100, David Daney wrote:
> >>>> From: David Daney <david.daney@cavium.com>
> >>>>
> >> [...]
> >>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >>>> index 4095379..3356023 100644
> >>>> --- a/arch/arm64/kernel/pci.c
> >>>> +++ b/arch/arm64/kernel/pci.c
> >>>> @@ -38,11 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> >>>>    	return res->start;
> >>>>    }
> >>>>
> >>>> +static int (*pcibios_add_device_impl)(struct pci_dev *);
> >>>> +
> >>>> +void set_pcibios_add_device(int (*arg)(struct pci_dev *))
> >>>> +{
> >>>> +	pcibios_add_device_impl = arg;
> >>>> +}
> >>>> +
> >>>>    /*
> >>>>     * Try to assign the IRQ number from DT when adding a new device
> >>>>     */
> >>>>    int pcibios_add_device(struct pci_dev *dev)
> >>>>    {
> >>>> +	if (pcibios_add_device_impl)
> >>>> +		return pcibios_add_device_impl(dev);
> >>>
> >>> I am totally against this (and to be honest by reading the other
> >>> patches I failed to understand why you even need it), see above.
> >>>
> >>
> >> It is because ...
> >>
> >>
> >>> Thanks,
> >>> Lorenzo
> >>>
> >>>> +
> >>>>    	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> >>
> >>
> >>    ... this is total crap.  But I didn't want to break existing systems.
> >
> > That's a good aim, but you are still failing to explain the issue properly
> > I am afraid.
> >
> >> The PCI RC drivers need a way to configure the legacy virtual-wire
> >> interrupts, because the existing code doesn't do it.
> >
> > Can I ask you please to explain the issue a bit more clearly (and why
> > the OF API does not work for you ?)
> 
> Several problems:
> 
> 1) It prints many times to the boot log this string:
>      pci 0000:01:0e.2: of_irq_parse_pci() failed with rc=-19

which happens because...?

That's -ENODEV. As far as I can tell, that only gets printed if the
device doesn't have a wired interrupt (the interrupt pin field in config
space read as zero).

So that's beningn, but annoying?

Surely we can clean that up.

> 2) For a RC with no device_node it does nothing (in addition to printing 
> the annoying message).

Your root complex has a device_node if it is described in DT.

Is the problem that this doesn't work with ACPI?

Thanks,
Mark.
