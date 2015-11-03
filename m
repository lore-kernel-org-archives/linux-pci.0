Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43607 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbKCLmv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2015 06:42:51 -0500
Date: Tue, 3 Nov 2015 12:42:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <20151103001552.GE13904@localhost.localdomain>
Message-ID: <alpine.DEB.2.11.1511031001130.4032@nanos>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com> <1445967247-24310-4-git-send-email-keith.busch@intel.com> <alpine.DEB.2.11.1511021426020.4032@nanos> <20151103001552.GE13904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Keith,

On Tue, 3 Nov 2015, Keith Busch wrote:
> On Mon, Nov 02, 2015 at 07:35:15PM +0100, Thomas Gleixner wrote:
> > On Tue, 27 Oct 2015, Keith Busch wrote:

> > > +config HAVE_VMDDEV
> > > +	bool
> > 
> > Why do you need a seperate config symbol here?
> 
> This is to split the kernel vs. module parts. "vmd_create_irq_domain"
> needs to be in-kernel, but VMD may be compiled as a module, so can't use
> "CONFIG_VMD_DEV".

#ifdef IS_ENABLED(CONFIG_VMD_DEV)

is true for both "m" and "y"
 
> Alternatively we could export pci_msi_domain_ops, and no additional
> in-kernel dependencies are required.

That might be not the worst choice.
 
> > > +	int count = 0;
> > > +	struct msi_desc *msi_desc;
> > > +	struct irq_domain *vmd_irqdomain, *msi_irqdomain;
> > > +
> > > +	if (!dev->msix_enabled)
> > > +		return NULL;
> > > +
> > > +	for_each_pci_msi_entry(msi_desc, dev)
> > > +		count += msi_desc->nvec_used;
> > 
> > Is this the number of vectors which are available for the VMD device
> > itself?
> 
> Correct, this is counting the number of the VMD vectors itself. This is
> not the number of vectors that may be allocated in this domain, though
> they will all need to multiplex into one of these.

But you actually limit the number of vectors in that domain:

> > > +	for_each_pci_msi_entry(msi_desc, dev)
> > > +		count += msi_desc->nvec_used;
> > > +	vmd_irqdomain = irq_domain_add_linear(NULL, count,
> > > +						  domain_ops, dev);

So vmd_irqdomain can only hand out "count" vectors. 

The vmd_irqdomain is the parent of the msi_irqdomain:

> > > +	msi_irqdomain = pci_msi_create_irq_domain(NULL, &pci_chained_msi_domain_info,
> > > +						  vmd_irqdomain);

But that parent limitation does not matter simply because your
msi_irqdomain does not follow down the hierarchy in the allocation
path.

So we can avoid the vmd_irqdomain creation completely. It's just
wasting memory and has no value at all. Creating the msi domain with a
NULL parent is possible.

> > > +	vmdirq->irq = &vmd->irqs[virq % vmd->msix_count];
> > 
> > So that points to the underlying VMD device irq, right? And you spread
> > the device interrupts across the available VMD irqs. So in the worst
> > case you might end up with empty and crowded VMD irqs, right?
> > Shouldn't you try to fill that space in a more intelligent way?
> 
> The domain is enabled and enumerated by pci, so I thought devices will
> be bound to their drivers serially, creating a more-or-less incrementing
> virtual irq that should wrap in evenly.
> 
> But yes, we can be smarter about this, and the above is probably flawed
> rationale, especially if considering hot-plug.

Not only hotplug. It also depends on the init ordering and the
population of the interrupt descriptor space.
 
> > > +static void vmd_flow_handler(struct irq_desc *desc)
> > > +{
> > > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > > +	struct vmd_irq_list *irqs = irq_desc_get_handler_data(desc);
> > > +	struct vmd_irq *vmdirq;
> > > +
> > > +	chained_irq_enter(chip, desc);
> > > +	rcu_read_lock();
> > > +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> > > +		generic_handle_irq(vmdirq->virq);
> > > +	rcu_read_unlock();
> > 
> > I'm not entirely sure that the rcu protection here covers the whole
> > virq thing when an interrupt is torn down. Can you please explain the
> > whole protection scheme in detail?
> 
> This protects against device drivers manipulating the list through
> vmd_msi_activate/deactivate. We can't spinlock the flow handler access
> due to desc->lock taken through generic_handle_irq. The same lock is
> held prior to vmd's msi activate/deactivate, so the lock order would be
> opposite in those two paths.
> 
> I don't believe we're in danger of missing a necessary event or triggering
> an unexpected event here. Is the concern that we need to synchronize rcu
> instead of directly freeing the "vmdirq"? I think I see that possibility.

synchronize rcu does not help. You surely need to kfree_rcu()
"vmdirq", but that alone is not sufficient. You also need to think
about the underlying irq descriptor, which is not freed via rcu. Lets
look at it:

CPU0					CPU1

driver_exit()
 free_irq(D)
  lock(irqdesc(D))
  irq_shutdown(D)
    irq_domain_deactivate_irq(D)	vmd_flow_handler()
      vmd_msi_deactivate()		  rcu_read_lock()
        lock()				  vmdirq = list_entry(...)
        list_del_rcu()			---> NMI  
	unlock()
  unlock(irqdesc(D))
  synchronize_irq(D)			    
 pci_misx_disable(device)
  irq_domain_free_irqs()
    vmd_msi_free_irqs()			  
      kfree_rcu(vmdirq)			<--- NMI done  
					  D = vmdirq->virq; <- Protected by RCU
					  generic_handle_irq(D)
					    desc = irqdesc(D)
    irq_free_descs()
     kfree(irqdesc(D))
					    desc->handle_irq(desc) <-- KABOOOOM!

Subtle, isn't it? It's extremly unlikely, but when it happens you have
no chance to ever debug that.

The good news for you is that this is a general issue and you can
ignore it for now. The bad news for me is, that I have another urgent
issue on my ever growing todo list.

> > > +static void vmd_remove(struct pci_dev *dev)
> > > +{
> > > +	struct vmd_dev *vmd = pci_get_drvdata(dev);
> > > +
> > > +	pci_set_drvdata(dev, NULL);
> > > +	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
> > > +	pci_stop_root_bus(vmd->bus);
> > > +	pci_remove_root_bus(vmd->bus);
> > > +	vmd_teardown_dma_ops(vmd);
> > > +	irq_domain_remove(vmd->irq_domain);
> > 
> > What tears down the chained handlers and the MSIx entries?
> 
> Thanks, I will fix the chained handler in both cases mentioned.
> 
> The entries themselves should be freed through devres_release after this
> exits, and after MSI-x is disabled via pcim_release.
 
Ok.

Thanks,

	tglx
