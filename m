Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Oct 2017 09:54:47 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-alpha@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: alpha boot hang - 4.14-rc* regression
Message-ID: <20171026085447.GA16024@red-moon>
References: <alpine.LRH.2.21.1710251043170.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251109150.7098@math.ut.ee>
 <alpine.LRH.2.21.1710251129520.7098@math.ut.ee>
 <20171025092159.GA14222@red-moon>
 <alpine.LRH.2.21.1710251511090.10071@math.ut.ee>
 <20171025133730.GA5487@red-moon>
 <alpine.LRH.2.21.1710251748170.10071@math.ut.ee>
 <20171025151413.GA6499@red-moon>
 <alpine.LRH.2.21.1710252100080.16994@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.21.1710252100080.16994@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 09:01:07PM +0300, Meelis Roos wrote:
> > It is probably because I patched the wrong map_irq() function,
> > I am trying to detect which one you are _actually_ using, if
> > the patch below fails I will patch them all (which is what I
> > have to do anyway).
> > 
> > Please give this a go - this _has_ to make a difference, it is not
> > correct to leave map_irq() pointers as __init memory, IRQ routing
> > for modules can't work.
> 
> This works for mainline git too.
> 
> If you have another round that fixes all subarches, I will try it on a 
> PC164 too.

Sure, I will send one patch shortly updating all map/swizzle functions
to remove the __init markers.

Thanks,
Lorenzo
