Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:58260 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbaGCWL4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 18:11:56 -0400
Received: by mail-ig0-f173.google.com with SMTP id uq10so8164688igb.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2014 15:11:56 -0700 (PDT)
Date: Thu, 3 Jul 2014 16:11:52 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci: Allow very large resource windows
Message-ID: <20140703221152.GH28852@google.com>
References: <20140611060118.GB3169@yanx>
 <CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
 <20140702210736.GB28852@google.com>
 <CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
 <20140703131526.GG28852@google.com>
 <CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 03, 2014 at 12:59:21PM -0700, Yinghai Lu wrote:
> On Thu, Jul 3, 2014 at 6:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >>
> >> >> +     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
> >> >> +
> >> >> +     /* kernel does not support 64bit res */
> >> >> +     if (sizeof(resource_size_t) == 4)
> >> >> +             mem64_mask &= ~IORESOURCE_MEM_64;
> >
> > I think you're fixing two things at once, and they should be split
> > into two separate patches:
> >
> >   1) Change aligns[] size to increase support alignment from 8GB to 2^63
> >
> >      I'm not sure about going all the way to aligns[44].  That array
> >      by itself puts 352 bytes in the stack frame (240 of which are
> >      added by this patch), which seems excessive.  I suspect that
> >      supporting BARs up to 64GB or 128GB would be enough for the
> >      foreseeable future.
> 
> ok, let's use 128G this time.
> 
> >
> >   2) Adding mem64_mask
> >
> >      I think the idea is that even if we have a 64-bit window, we
> >      can't use anything above 4GB if we only have 32-bit resources.
> >      That's true, but I don't think we can enforce that in
> >      pbus_size_mem() because we're only figuring out how much space is
> >      needed; we have no idea where that space will be allocated.
> 
> with current version of __pci_bus_size_bridges, we separate pref_mem64 with
> pref_mem32 to calling pbus_size_mem.
> 
> so if we have pref 64bit window, we will only size pref 64 bit
> children under it.
> and will only assign pref 64bit mem64 to them late.
> 
> If the bridge does not support 64bit pref windows, and child support
> 64bit pref mmio, then bridge will try to use pref 32 window, in that
> case, .... could have
> size overflow as you state follow.

This problem has nothing to do with overflow.  We're concerned with
IORESOURCE_MEM_64, which tells us the width of the bridge window
registers: obviously we can't put a 64-bit bus address in a 32-bit
window register.

pbus_size_mem() figures out how much space we need.  If we need 4GB or
more and the kernel only supports 32-bit resources, we can fail
immediately because we can't describe a 4GB window in a 32-bit
resource.

But if we need less than 4GB, pbus_size_mem() should succeed.  We
might fail *later*, if we can't allocate bus addresses that fit in a
32-bit bridge window register.  But in pbus_size_mem(), we have no
idea where the space will come from.

So I don't think there's any point in looking at the sizes of
individual BARs in pbus_size_mem().  We should only look at the total
size required.

> > And I think there are more problems:
> >
> >   - I don't think we handle overflow of "size" correctly.  Assume that
> >     we have BARs of 2GB, 2GB, and 8GB.  If we have 32-bit resources,
> >     when we add those up, it will overflow and we'll mistakenly think
> >     we only need 8MB.
> 
> in this case we should check the overflow.
> 
> >
> >   - We shouldn't set "r->flags = 0".  The warning says we're disabling
> >     the BAR, but this *doesn't* disable the BAR, and in fact, there is
> >     no way to disable a single BAR.  What we can do is turn off
> >     PCI_COMMAND_MEMORY to disable all the memory BARs for the device.
> >     And to do that, we need to keep IORESOURCE_MEM in r->flags so
> >     pci_enable_resources() can tell that this is a memory BAR.
> 
> when we try to size it,  means that bar is not assigned. with r->flags
> = 0, means
> we will ignore it all the way.

With "r->flags = 0", we will not try to assign resources to the BAR,
but the hardware BAR still exists and contains some address.  If the
device has other memory BARs, pci_enable_resources() will turn on
PCI_COMMAND_MEMORY.  Now the "r->flags == 0" BAR is enabled but the
address it contains might conflict with other devices.  That's the
problem.

To fix this, I think we need to do "r->flags |= IORESOURCE_UNSET |
IORESOURCE_DISABLED".

Bjorn
