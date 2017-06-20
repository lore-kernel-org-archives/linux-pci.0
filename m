Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdFTUjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2017 16:39:47 -0400
Date: Tue, 20 Jun 2017 22:39:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Keith Busch <keith.busch@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 15/55] PCI: vmd: Create named irq domain
In-Reply-To: <alpine.DEB.2.20.1706202206370.2157@nanos>
Message-ID: <alpine.DEB.2.20.1706202238350.2157@nanos>
References: <20170619233700.547167146@linutronix.de> <20170619235444.379861978@linutronix.de> <20170620200758.GC24415@localhost.localdomain> <alpine.DEB.2.20.1706202206370.2157@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 20 Jun 2017, Thomas Gleixner wrote:
> On Tue, 20 Jun 2017, Keith Busch wrote:
> > On Tue, Jun 20, 2017 at 01:37:15AM +0200, Thomas Gleixner wrote:
> > >  static int vmd_enable_domain(struct vmd_dev *vmd)
> > >  {
> > >  	struct pci_sysdata *sd = &vmd->sysdata;
> > > +	struct fwnode_handle *fn;
> > >  	struct resource *res;
> > >  	u32 upper_bits;
> > >  	unsigned long flags;
> > > @@ -617,8 +618,13 @@ static int vmd_enable_domain(struct vmd_
> > >  
> > >  	sd->node = pcibus_to_node(vmd->dev->bus);
> > >  
> > > -	vmd->irq_domain = pci_msi_create_irq_domain(NULL, &vmd_msi_domain_info,
> > > +	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
> > > +	if (!fn)
> > > +		return -ENODEV;
> > > +
> > > +	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
> > >  						    x86_vector_domain);
> > > +	kfree(fn);
> > 
> > If I'm following all this correctly, it looks like we need to use
> > irq_domain_free_fwnode with irq_domain_alloc_named_id_fwnode instead of
> > freeing 'fn' directly, otherwise we leak 'fwid->name'.
> 
> Yes, I'm a moron.

Fixed up the mess and updated the git branch.

Thanks for catching it.

       tglx
