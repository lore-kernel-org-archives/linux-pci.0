Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:47192 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbaDIHw1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Apr 2014 03:52:27 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Wed, 9 Apr 2014 13:22:25 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 822061258048
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2014 13:24:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s397qSN81573332
	for <linux-pci@vger.kernel.org>; Wed, 9 Apr 2014 13:22:29 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s397qL1H023748
	for <linux-pci@vger.kernel.org>; Wed, 9 Apr 2014 13:22:22 +0530
Date: Wed, 9 Apr 2014 15:52:15 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
Message-ID: <20140409075215.GA3173@yanx>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org>
 <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx>
 <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn:

On Tue, Apr 08, 2014 at 09:02:10AM -0600, Bjorn Helgaas wrote:
> On Mon, Apr 7, 2014 at 8:57 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> > On Fri, Apr 04, 2014 at 04:43:27PM -0600, Bjorn Helgaas wrote:
> >> On Fri, Mar 7, 2014 at 1:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> > When one of children resources does not support MEM_64, MEM_64 for
> >> > bridge get reset, so pull down whole pref resource on the bridge under 4G.
> >> >
> >> > If the bridge support pref mem 64, will only allocate that with pref mem64 to
> >> > children that support it.
> >> > For children resources if they only support pref mem 32, will allocate them
> >> > from non pref mem instead.
> >> >
> >> > If the bridge only support 32bit pref mmio, will still have all children pref
> >> > mmio under that.
> >> >
> >> > -v2: Add release bridge res support with bridge mem res for pref_mem children res.
> >> > -v3: refresh and make it can be applied early before for_each_dev_res patchset.
> >> > -v4: fix non-pref mmio 64bit support found by Guo Chao.
> >> > -v7: repost as ibm's powerpc system work again when
> >> >     1. petiboot boot kernel have this patch.
> >> >     2. or mellanox driver added new .shutdown member.
> >> >     discussion could be found at:
> >> >          http://marc.info/?t=138968064500001&r=1&w=2
> >>
> >> I think this fixes some sort of bug, and I suppose if I spent a few
> >> hours decoding the discussion you mention (the 44 message-long
> >> "mlx4_core probe error after applying Yinghai's patch" discussion), I
> >> might be able to figure out what it is.
> >>
> >
> > The result of 44 message-long discussion is: the Mellanox card's failure is
> > due to a bug in its driver instead of this patch.
> >
> > The patch refines the logic of using prefetchable window, so that 64-bit
> > prefetchable BARs have a chance to be really prefetchable. It does not fix
> > any bugs, instead, it exposes one.
> 
> OK, then I'm back to square one, and I need an explanation of why we
> want to merge this patch.
> 
> I think the patch conserves 32-bit address space by putting more
> things above 4G than we used to.  But this comes at the cost of using
> non-prefetchable windows in some cases where we used to use
> prefetchable ones.
> 
> Somebody has to explain why we want to do this and why the benefit of
> conserving the 32-bit space is more important losing the
> prefetchability.

I want to make sure we are talking about this patch:
	PCI: Try best to allocate pref mmio 64bit above 4g
	http://patchwork.ozlabs.org/patch/328067/

instead of this one:
	PCI: Try to allocate mem64 above 4G at first
	http://patchwork.ozlabs.org/patch/303197/

This patch does not intend to conserve 32-bit space at all. It makes
better use of prefetchable window.

The problem with the old code is: when both 32-bit and 64-bit prefetchable
BARs present, it's in favor of 32-bit one to use prefetchable window.
This window is then not supposed to get 4G-above address, and this
32-bit-address-only property would propagates upwards until reaching root
bridge. In later assignment phase, 4G-above space is never touched. This
is just caused by a single 32-bit prefetchable BAR (say a ROM BAR).

This patch helps by making better decision:

	* Keep the old behaviour if only 32-bit or 64-bit prefetchable
	  BARs present

	* If both of them present, put 64-bit ones to prefetchable window,
	  32-bit ones to non-prefetchable window

So 4G-above space can be properly used.

Why does enabling 64-bit space matter?

* 32-bit space is just too small. If larger-than-4G BAR sounds
  unrealistic (we do have such devices), there is still a chance that
  total MMIO size under a domain is too large, especially when SR-IOV
  enabled (we met this situation).

* On PowerNV platform, we can do better platform configuration for 64-bit
  prefetchable space, that's important for enabling SR-IOV on this
  platform.


Thanks,
Guo Chao

> 
> Bjorn
> 

