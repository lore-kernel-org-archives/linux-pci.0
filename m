Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62046 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbKCAPy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Nov 2015 19:15:54 -0500
Date: Tue, 3 Nov 2015 00:15:52 +0000
From: Keith Busch <keith.busch@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device
 driver
Message-ID: <20151103001552.GE13904@localhost.localdomain>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
 <1445967247-24310-4-git-send-email-keith.busch@intel.com>
 <alpine.DEB.2.11.1511021426020.4032@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.11.1511021426020.4032@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 02, 2015 at 07:35:15PM +0100, Thomas Gleixner wrote:
> On Tue, 27 Oct 2015, Keith Busch wrote:

Thomas,

Thanks a bunch for the feedback! I'll reply what I can right now, and
will take more time to consider or fix the rest for the next revision.
 
> I'm just looking at the interrupt part of the patch and it's way
> better than the first version I looked at.

Thanks! Though I have to credit Gerry for the initial setup.

I think you correctly deduced the interrupt mux/demux requirement. I
don't even completely follow how the irq domain code accomplishes this,
but it works on the h/w I've been provided and I trust Gerry wouldn't
steer me wrong with the software. :)

> > +config HAVE_VMDDEV
> > +	bool
> 
> Why do you need a seperate config symbol here?

This is to split the kernel vs. module parts. "vmd_create_irq_domain"
needs to be in-kernel, but VMD may be compiled as a module, so can't use
"CONFIG_VMD_DEV".

Alternatively we could export pci_msi_domain_ops, and no additional
in-kernel dependencies are required.

> > +	bus resources to allow more devices than are otherwise possible
> > +	with a single domain. If your system provides one of these and
> > +	has devices attached to it, say "Y".
> 
> How is one supposed to figure out that the system supports this?

I'll work out more appropriate text. Basically enabling this is a
platform setting that requires purposeful intent, almost certainly not
by accident. The user ought to know prior to OS install, so maybe it
should say 'if you're not sure, say "N"'.

> > +	int count = 0;
> > +	struct msi_desc *msi_desc;
> > +	struct irq_domain *vmd_irqdomain, *msi_irqdomain;
> > +
> > +	if (!dev->msix_enabled)
> > +		return NULL;
> > +
> > +	for_each_pci_msi_entry(msi_desc, dev)
> > +		count += msi_desc->nvec_used;
> 
> Is this the number of vectors which are available for the VMD device
> itself?

Correct, this is counting the number of the VMD vectors itself. This is
not the number of vectors that may be allocated in this domain, though
they will all need to multiplex into one of these.

> > +static void vmd_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> > +{
> > +	struct vmd_irq *vmdirq = data->chip_data;
> > +
> > +	msg->address_hi = MSI_ADDR_BASE_HI;
> > +	msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_DEST_ID(vmdirq->irq->index);
> > +	msg->data = MSI_DATA_VECTOR(vmdirq->irq->vmd_vector);
> 
> Is this the MSI msg which gets written into the VMD device or into the
> device which hangs off the VMD device bus?

This is the message to be written in the "child" device hanging off
the VMD domain. The child table must be programmed with VMD vectors,
and many child devices may share the same one. In some cases, a single
device might have multiple table entries with the same vector.

The child device driver's IRQ is purely a software concept in this domain
to facilitate chaining the VMD IRQ to the appropriate handler. The h/w
will never see it.

> > +	vmdirq->irq = &vmd->irqs[virq % vmd->msix_count];
> 
> So that points to the underlying VMD device irq, right? And you spread
> the device interrupts across the available VMD irqs. So in the worst
> case you might end up with empty and crowded VMD irqs, right?
> Shouldn't you try to fill that space in a more intelligent way?

The domain is enabled and enumerated by pci, so I thought devices will
be bound to their drivers serially, creating a more-or-less incrementing
virtual irq that should wrap in evenly.

But yes, we can be smarter about this, and the above is probably flawed
rationale, especially if considering hot-plug.

> > +static int vmd_enable_domain(struct vmd_dev *vmd)
> > +{
> > +	struct pci_sysdata *sd = &vmd->sysdata;
> 
> <SNIP>
> 
> > +	vmd->irq_domain = vmd_create_irq_domain(vmd->dev, &vmd_domain_ops);
> 
> This is the irq domain which the devices on that VMD bus are seeing, right?

Correct.
 
> > +	if (!vmd->irq_domain)
> > +		return -ENODEV;
> 
> > +static void vmd_flow_handler(struct irq_desc *desc)
> > +{
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	struct vmd_irq_list *irqs = irq_desc_get_handler_data(desc);
> > +	struct vmd_irq *vmdirq;
> > +
> > +	chained_irq_enter(chip, desc);
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> > +		generic_handle_irq(vmdirq->virq);
> > +	rcu_read_unlock();
> 
> I'm not entirely sure that the rcu protection here covers the whole
> virq thing when an interrupt is torn down. Can you please explain the
> whole protection scheme in detail?

This protects against device drivers manipulating the list through
vmd_msi_activate/deactivate. We can't spinlock the flow handler access
due to desc->lock taken through generic_handle_irq. The same lock is
held prior to vmd's msi activate/deactivate, so the lock order would be
opposite in those two paths.

I don't believe we're in danger of missing a necessary event or triggering
an unexpected event here. Is the concern that we need to synchronize rcu
instead of directly freeing the "vmdirq"? I think I see that possibility.

> > +	vmd->msix_count = pci_enable_msix_range(vmd->dev, vmd->msix_entries, 1,
> > +							vmd->msix_count);
> 
> So this allocates the CPU facing MSI vectors, which are used to run
> the demultiplex handler, right?

Correct.
 
> A few comments explaining the whole thing would be really
> appropriate. I'm sure you'll appreciate them when you look at it
> yourself a year from now.

Absolutely. It's not entirely obvious what's happening, but I think you
correctly surmised what this is about, and hopefully some of the answers
to your other questions helped with some details.

We will provide more detail in code comments for the next round.

> > +static void vmd_remove(struct pci_dev *dev)
> > +{
> > +	struct vmd_dev *vmd = pci_get_drvdata(dev);
> > +
> > +	pci_set_drvdata(dev, NULL);
> > +	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> > +	pci_stop_root_bus(vmd->bus);
> > +	pci_remove_root_bus(vmd->bus);
> > +	vmd_teardown_dma_ops(vmd);
> > +	irq_domain_remove(vmd->irq_domain);
> 
> What tears down the chained handlers and the MSIx entries?

Thanks, I will fix the chained handler in both cases mentioned.

The entries themselves should be freed through devres_release after this
exits, and after MSI-x is disabled via pcim_release.
