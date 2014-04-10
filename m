Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47349 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965159AbaDJVYY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 17:24:24 -0400
Message-ID: <1397165033.3671.210.camel@pasglop>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>, Yinghai Lu <yinghai@kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Fri, 11 Apr 2014 07:23:53 +1000
In-Reply-To: <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
	 <1394222924-28886-1-git-send-email-yinghai@kernel.org>
	 <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
	 <20140408025738.GA3198@yanx>
	 <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
	 <20140409075215.GA3173@yanx>
	 <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-04-10 at 11:26 -0600, Bjorn Helgaas wrote:
> > The problem with the old code is: when both 32-bit and 64-bit prefetchable
> > BARs present, it's in favor of 32-bit one to use prefetchable window.
> > This window is then not supposed to get 4G-above address, and this
> > 32-bit-address-only property would propagates upwards until reaching root
> > bridge. In later assignment phase, 4G-above space is never touched. This
> > is just caused by a single 32-bit prefetchable BAR (say a ROM BAR).
> >
> > This patch helps by making better decision:
> >
> >         * Keep the old behaviour if only 32-bit or 64-bit prefetchable
> >           BARs present
> >
> >         * If both of them present, put 64-bit ones to prefetchable window,
> >           32-bit ones to non-prefetchable window
> 
> I thought the patch was supposed to change the way we allocate bridge
> windows.  But you are talking about the way we assign 32- and 64-bit
> device resources, i.e., changing the way we decide whether to put them
> in prefetchable or non-prefetchable windows.

Wait...

Are you putting "non-prefetchable" 64-bit BARs in the prefetchable
range ?

That's bad. Don't do that.

Some switches or bridges *will* actively prefetch, and putting a
register BAR marked non-prefetchable in the prefetchable range will thus
cause nasty bugs if a register with side effects becomes the target of a
prefetch operations.

We can do that on powerpc *selectively* when and only when we know for
sure that no bridge will prefetch on the path to the device. We know our
host bridges won't and we *might* (to be verified) know that the PLX
switches we have soldered on the mobo won't, but that's the only cases
where it is legit.

> > So 4G-above space can be properly used.
> >
> > Why does enabling 64-bit space matter?
> >
> > * 32-bit space is just too small. If larger-than-4G BAR sounds
> >   unrealistic (we do have such devices), there is still a chance that
> >   total MMIO size under a domain is too large, especially when SR-IOV
> >   enabled (we met this situation).
> 
> Please give more details about the problem you saw.  A complete dmesg
> log showing a boot failure or a device that doesn't work, and another
> log with this patch applied, showing things working as desired, would
> go a long ways toward clarifying this.
> 
> This sounds like a specific case that will be fixed by the patch, and
> if you give more details, maybe I can figure out what's going on.

Well, in our case it's a very complicated story. We have this segmented
space where we have 256 segments covering our 32-bit space. We need each
"partitionable endpoint" to be in separate sets of segments. PEs are
basically iommu domain but also affect MMIO and are our unit of
assignment to guests when virtualizing and of error handling when doing
EEH (so we freeze access on error by PE).

So with something like SR-IOV where each VF has to be a separate PE,
the 32-bit space is problematic because we want the VF BARs to stride
over segments so each VF lives in a separate PE, but we run out of
segments and the 32-bit space has a fixed segment size that may not
match the VF BAR stride.

So we want our BARs to shoot into 64-bit space where we have additional
windows with each 256 segments that we can use, and additionally, we can
resize these to make the segment size match the VF BAR stride.

Cheers,
Ben.

