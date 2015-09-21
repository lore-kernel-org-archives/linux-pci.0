Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1442870403.23936.343.camel@redhat.com>
Subject: Re: [PATCH] PCI/MSI: Fix MSI IRQ domains for SR-IOV
From: Alex Williamson <alwillia@redhat.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2015 15:20:03 -0600
In-Reply-To: <20150920125848.37d04b21@arm.com>
References: <20150918210648.19363.35694.stgit@gimli.home>
	 <20150920125848.37d04b21@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2015-09-20 at 12:58 +0100, Marc Zyngier wrote:
> On Fri, 18 Sep 2015 15:08:54 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> Hi Alex,
> 
> > SR-IOV creates a virtual bus where bus->self is NULL.  This results
> > in a segfault as VFs are added and we scan for an MSI domain without
> > taking that into account.  Detect this and scan up to the parent bus
> > until we find a real bridge.
> 
> Irk. Sorry about the breakage.
> 
> > Fixes: 44aa0c657e3e ("PCI/MSI: Add hooks to populate the msi_domain field")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/pci/probe.c |   17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 0b2be17..b42419e 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -676,15 +676,20 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
> >  static void pci_set_bus_msi_domain(struct pci_bus *bus)
> >  {
> >  	struct irq_domain *d;
> > +	struct pci_bus *b;
> >  
> >  	/*
> > -	 * Either bus is the root, and we must obtain it from the
> > -	 * firmware, or we inherit it from the bridge device.
> > +	 * The bus can be a root bus, a subordinate bus, or a virtual bus
> > +	 * created by an SR-IOV device.  Walk up to the first bridge device
> > +	 * found or derive the domain from the host bridge.
> >  	 */
> > -	if (pci_is_root_bus(bus))
> > -		d = pci_host_bridge_msi_domain(bus);
> > -	else
> > -		d = dev_get_msi_domain(&bus->self->dev);
> > +	for (b = bus, d = NULL; !d && !pci_is_root_bus(b); b = b->parent) {
> > +		if (b->self)
> > +			d = dev_get_msi_domain(&b->self->dev);
> > +	}
> > +
> > +	if (!d)
> > +		d = pci_host_bridge_msi_domain(b);
> >  
> >  	dev_set_msi_domain(&bus->dev, d);
> >  }
> > 
> 
> Out of curiosity, is this a common behaviour? I've tested the original
> code with an Intel i350 Ethernet interface (IGB+IGBVF), and used it
> with virtual functions on my arm64-based Seattle, without any issue. Do
> we have divergent implementations of the same functionality in the
> kernel? Otherwise:

Thanks for the review Marc.  I believe this is a property coming out of
the core PCI IOV code:

drivers/pci/iov.c:virtfn_add_bus()

        child = pci_add_new_bus(bus, NULL, busnr);

That second arg is the dev for the new bus, which gets passed as
'bridge' to:

drivers/pci/probe.c:pci_alloc_child_bus()

        child->self = bridge;

Resulting in our bus->self == NULL issue.

We have the following call path to virtfn_add_bus:

pci_enable_sriov
  sriov_enable
    virtfn_add
      virtfn_add_bus

The only thing unique I can think of for my system is that I'm using the
max_vfs module option for igb, but it's not apparent to me how that
would trigger anything different through here.  Thanks,

Alex

