Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37738 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752759AbcD1OhF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 10:37:05 -0400
Date: Thu, 28 Apr 2016 16:36:46 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: pci_ioremap_set_mem_type(), pci_remap_iospace()
Message-ID: <20160428163646.432e2c68@free-electrons.com>
In-Reply-To: <20160428141920.GB12470@localhost>
References: <20160427225827.GC17629@localhost>
	<20160428141920.GB12470@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 28 Apr 2016 09:19:20 -0500, Bjorn Helgaas wrote:

> >         coherency_cpu_base = of_iomap(np, 0);
> > -       arch_ioremap_caller = armada_pcie_wa_ioremap_caller;
> > +       arch_ioremap_caller = armada_wa_ioremap_caller;
> > +       pci_ioremap_set_mem_type(MT_UNCACHED);
> 
> This makes sense to me because I think this changes ioremap() to do
> the right thing.

What changes ioremap() to do the right thing for all mappings *except*
PCI I/O mappings:

   arch_ioremap_caller = armada_wa_ioremap_caller;

>  But my concern is that ioremap_page_range() doesn't
> actually use ioremap(), so pci_ioremap_set_mem_type() has no effect on
> that path.  pci_remap_iospace() uses ioremap_page_range(), so I
> suspect it will use the wrong attributes.

Indeed, ioremap_page_range() doesn't use ioremap(), and that's why
there is this separate pci_ioremap_set_mem_type() to ensure that
mappings done for PCI I/O space are done with MT_UNCACHED.

And indeed, pci_remap_iospace() would not work for me, as it wouldn't
use the memory attributes set by pci_ioremap_set_mem_type().

To be honest, I am wondering why we're not using the same memory
attribute for PCI I/O space as the memory attributes used for anything
else that's ioremapped. In practice, that's what happens on ARM:
ioremap() uses MT_DEVICE by default, and pci_ioremap_io() uses
MT_DEVICE as well.

> >  1/ Providing an alternate version of pci_remap_iospace() that allows
> >     to pass the memory attribute to be used.
> 
> I'd rather fix ioremap_page_range() somehow, because that's an
> exported interface, and if we only fix pci_remap_iospace(), we still
> have to worry about ioremap_page_range() doing the wrong thing.

What do you want to fix in ioremap_page_range() ? It already allows
passing the memory type that you want, so I'm not sure to understand.

It is worth mentioning that on ARM, the arch_ioremap_caller mechanism
allows platform-specific to do its own magic for each mapping. I.e, it
might decide to use some specific memory attributes, or some specific
way of doing the mappings.

It is used on 5 platforms:

 * EBSA110, where it does a 1:1 mapping with the physical address if I
   understand correctly:

static void __iomem *ebsa110_ioremap_caller(phys_addr_t cookie, size_t size,
                                            unsigned int flags, void *caller)
{
        return (void __iomem *)cookie;
}

 * i.MX3, where it forces the memory attribute to be
   MT_DEVICE_NONSHARED, but only for the mappings that are below
   0x80000000 and not within the L2 cache registers. Otherwise, the
   default memory attribute is used.

 * iop13xx, where it really does some magic calculations to get the
   virtual addresses matching some specific physical addresses (and
   falls back to a real ioremap for other areas).

 * ixp4xx, which does a normal ioremap() for non-PCI devices, and a 1:1
   mapping for PCI stuff.

 * mvebu, where we currently override the memory attribute to strongly
   ordered for PCI devices only (but I need to change that so that all
   mappings are strongly ordered)

All in all, the pgprot_device() mechanism added by Liviu is not really
sufficient to address all those customizations, which is why ARM has
this more complicated way of allowing platform specific code to
override the ioremap behavior.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
