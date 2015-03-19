Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 19 Mar 2015 10:04:47 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Daniel J Blueman <daniel@numascale.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>,
	"x86@kernel.org" <x86@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: PCIe 32-bit MMIO exhaustion
Message-ID: <20150319150447.GC26935@google.com>
References: <54C8A10B.3070207@numascale.com>
 <CAErSpo4t94BXYhhE+bh5-3_PsdKTSa113beqqz14W+_emdCGMQ@mail.gmail.com>
 <54EC0013.7000100@numascale.com>
 <20150303223816.GB22299@google.com>
 <54F6B044.7000609@numascale.com>
 <20150304170159.GC22299@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150304170159.GC22299@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 04, 2015 at 11:01:59AM -0600, Bjorn Helgaas wrote:
> On Wed, Mar 04, 2015 at 03:12:04PM +0800, Daniel J Blueman wrote:
> > Your patch solves the conflicts nicely [1] with:
> > 
> > From f835b16b0758a1dde6042a0e4c8aa5a2e8be5f21 Mon Sep 17 00:00:00 2001
> > From: Daniel J Blueman <daniel@numascale.com>
> > Date: Wed, 4 Mar 2015 14:53:00 +0800
> > Subject: [PATCH] Mark PCI BARs with address 0 as unset
> > 
> > Allow the kernel to activate the unset flag for PCI BAR resources if
> > the firmware assigns address 0 (invalid as legacy IO is in this range).
> > 
> > This allows preventing conflicts with legacy IO/ACPI PNP resources in
> > this range.
> > 
> > Signed-off-by: Daniel J Blueman <daniel@numascale.com>
> > ---
> >  drivers/pci/probe.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 8d2f400..ef43652 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -281,6 +281,13 @@ int __pci_read_base(struct pci_dev *dev, enum
> > pci_bar_type type,
> >  	pcibios_resource_to_bus(dev->bus, &inverted_region, res);
> > 
> >  	/*
> > +	 * If firmware doesn't assign a valid PCI address (as legacy IO is below
> > +	 * PCI IO), mark resource unset to prevent later resource conflicts
> > +	 */
> > +	if (region.start == 0)
> > +		res->flags |= IORESOURCE_UNSET;
> 
> It's true that an uninitialized BAR should contain zero.  But an
> initialized BAR may also contain zero, since zero is a valid PCI memory or
> I/O address, so I don't really want to preclude that here.  On large
> systems with host bridges that support address translation, it would be
> reasonable to have something like this:
> 
>   pci_bus 0001:00: root bus resource [mem 0x100000000-0x1ffffffff] (bus address [0x00000000-0xffffffff])
> 
> In that case, an initialized BAR may contain zero and that should not be an
> error.
> 
> On your system, I don't think you advertise an I/O aperture to bus 0001:00.
> I'd like to make the PCI core smart enough to notice that and just ignore
> any I/O BARs on that bus.
> 
> There's an argument for doing this immediately, here inside
> __pci_read_base(): we could look for an upstream window that contains the
> BAR we're reading.  I'd like to be able to do that someday, but I'm not
> sure we have enough of the upstream topology set up to do that.
> 
> Can you try the patch below, which tries to do it a little later?
> 
> > +	/*
> >  	 * If "A" is a BAR value (a bus address), "bus_to_resource(A)" is
> >  	 * the corresponding resource address (the physical address used by
> >  	 * the CPU.  Converting that resource address back to a bus address
> > 
> > [1] https://resource.numascale.com/dmesg-4.0.0-rc2.txt
> 
> This URL doesn't work for me.

Ping?

> commit 66c15b678466cb217f2615d4078d12a2ee4c99ac
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Mar 4 10:47:35 2015 -0600
> 
>     PCI: Mark invalid BARs as unassigned
>     
>     If a BAR is not inside any upstream bridge window, or if it conflicts with
>     another resource, mark it as IORESOURCE_UNSET so we don't try to use it.
>     We may be able to assign a different address for it.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index b7c3a5ea1fca..232f9254c11a 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -120,6 +120,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
>  	if (!root) {
>  		dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible bridge window\n",
>  			 resource, res);
> +		res->flags |= IORESOURCE_UNSET;
>  		return -EINVAL;
>  	}
>  
> @@ -127,6 +128,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
>  	if (conflict) {
>  		dev_info(&dev->dev, "can't claim BAR %d %pR: address conflict with %s %pR\n",
>  			 resource, res, conflict->name, conflict);
> +		res->flags |= IORESOURCE_UNSET;
>  		return -EBUSY;
>  	}
>  
