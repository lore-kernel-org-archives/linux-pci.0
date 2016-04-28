Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39021 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbcD1QDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 12:03:55 -0400
Date: Thu, 28 Apr 2016 11:03:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: pci_ioremap_set_mem_type(), pci_remap_iospace()
Message-ID: <20160428160339.GA19785@localhost>
References: <20160427225827.GC17629@localhost>
 <20160428141920.GB12470@localhost>
 <20160428163646.432e2c68@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160428163646.432e2c68@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 04:36:46PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 28 Apr 2016 09:19:20 -0500, Bjorn Helgaas wrote:
> 
> > >         coherency_cpu_base = of_iomap(np, 0);
> > > -       arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
> > > +       arch_ioremap_caller = armada_wa_ioremap_caller;
> > > +       pci_ioremap_set_mem_type(MT_UNCACHED);
> > 
> > This makes sense to me because I think this changes ioremap() to do
> > the right thing.
> 
> What changes ioremap() to do the right thing for all mappings *except*
> PCI I/O mappings:
> 
>    arch_ioremap_caller = armada_wa_ioremap_caller;
> 
> >  But my concern is that ioremap_page_range() doesn't
> > actually use ioremap(), so pci_ioremap_set_mem_type() has no effect on
> > that path.  pci_remap_iospace() uses ioremap_page_range(), so I
> > suspect it will use the wrong attributes.
> 
> Indeed, ioremap_page_range() doesn't use ioremap(), and that's why
> there is this separate pci_ioremap_set_mem_type() to ensure that
> mappings done for PCI I/O space are done with MT_UNCACHED.
> 
> And indeed, pci_remap_iospace() would not work for me, as it wouldn't
> use the memory attributes set by pci_ioremap_set_mem_type().

Right.  pci_remap_iospace() is a generic interface and should work
on all arches.  It *is* declared __weak, but there's no arch-specific
implementation of it, and I think if we made ioremap_page_range()
truly generic, we could make pci_remap_iospace() non-weak.

> To be honest, I am wondering why we're not using the same memory
> attribute for PCI I/O space as the memory attributes used for anything
> else that's ioremapped. In practice, that's what happens on ARM:
> ioremap() uses MT_DEVICE by default, and pci_ioremap_io() uses
> MT_DEVICE as well.
> 
> > >  1/ Providing an alternate version of pci_remap_iospace() that allows
> > >     to pass the memory attribute to be used.
> > 
> > I'd rather fix ioremap_page_range() somehow, because that's an
> > exported interface, and if we only fix pci_remap_iospace(), we still
> > have to worry about ioremap_page_range() doing the wrong thing.
> 
> What do you want to fix in ioremap_page_range() ? It already allows
> passing the memory type that you want, so I'm not sure to understand.

Yes, but in order for ioremap_page_range() to work on arm, we have to
pass in an arm-specific memory type
(__pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte)).

We can't do that because ioremap_page_range() is a generic function,
implemented in lib/ioremap.c and exported to modules, and generic
callers only know about pgprot_noncached, pgprot_writecombine,
pgprot_writethrough, pgprot_device, etc.
