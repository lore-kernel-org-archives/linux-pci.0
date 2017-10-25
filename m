Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:58024 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdJYPyx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Oct 2017 11:54:53 -0400
Date: Wed, 25 Oct 2017 18:54:48 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: linux-alpha@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: alpha boot hang - 4.14-rc* regression
In-Reply-To: <20171025151413.GA6499@red-moon>
Message-ID: <alpine.LRH.2.21.1710251848050.16994@math.ut.ee>
References: <alpine.LRH.2.21.1710251043170.7098@math.ut.ee> <alpine.LRH.2.21.1710251109150.7098@math.ut.ee> <alpine.LRH.2.21.1710251129520.7098@math.ut.ee> <20171025092159.GA14222@red-moon> <alpine.LRH.2.21.1710251511090.10071@math.ut.ee> <20171025133730.GA5487@red-moon>
 <alpine.LRH.2.21.1710251748170.10071@math.ut.ee> <20171025151413.GA6499@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > > > > > removing libata modules and rebooting fixes it - so it seems to be 
> > > > > > loading of libata.
> > > > > 
> > > > > Can you please cherry-pick:
> > > > > 
> > > > > commit b1f9e5e355e9 ("ide: fix IRQ assignment for PCI bus order probing")
> > > > > 
> > > > > from mainline and let us know if that solves the issue ?
> > > > 
> > > > No, still breaks the same way (b1f9e5e355e9 patched on top of 
> > > > 0e4c2eeb758a).
> > > > 
> > > > 4.14.0-rc5-00095-g1c9fec470b81 was also still broken the same way (tried 
> > > > on Sunday).
> > > 
> > > I am not sure I patched the right sys file but if I did, does the patch
> > > below help ?
> > > 
> > > I think that at sata driver binding time the kernel finds a freed
> > > pointer in the host bridge map_irq() hook and that's where things
> > > go wrong.
> > > 
> > > Please let me know if that's the right sys file, it is a mechanical
> > > change and making it for other sys file should be reasonably simple.
> > > 
> > > Lorenzo
> > > 
> > > -- >8 --
> > > diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
> > 
> > "Booting GENERIC on Tsunami variation Webbrick using machine vector 
> > Webbrick from SRM"
> > 
> > Seems to be the correct file - tsunami is referenced from this file and 
> > the IRQ-s are DP264.
> > 
> > But the patch does not make a difference :(
> 
> It is probably because I patched the wrong map_irq() function,
> I am trying to detect which one you are _actually_ using, if
> the patch below fails I will patch them all (which is what I
> have to do anyway).
> 
> Please give this a go - this _has_ to make a difference, it is not
> correct to leave map_irq() pointers as __init memory, IRQ routing
> for modules can't work.

Yes, webrick entry seems to be the correct one fro DS10L. It works fine 
on top of the cherry-picked ATA IRQ patch.

Will try it on top of current mainline git.

-- 
Meelis Roos (mroos@linux.ee)
