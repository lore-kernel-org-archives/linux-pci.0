Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49032 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbaDJR0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 13:26:35 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so4251510iec.35
        for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2014 10:26:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140409075215.GA3173@yanx>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx> <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
 <20140409075215.GA3173@yanx>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Apr 2014 11:26:14 -0600
Message-ID: <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
To: Guo Chao <yan@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 9, 2014 at 1:52 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:

>> OK, then I'm back to square one, and I need an explanation of why we
>> want to merge this patch.
>>
>> I think the patch conserves 32-bit address space by putting more
>> things above 4G than we used to.  But this comes at the cost of using
>> non-prefetchable windows in some cases where we used to use
>> prefetchable ones.
>>
>> Somebody has to explain why we want to do this and why the benefit of
>> conserving the 32-bit space is more important losing the
>> prefetchability.
>
> I want to make sure we are talking about this patch:
>         PCI: Try best to allocate pref mmio 64bit above 4g
>         http://patchwork.ozlabs.org/patch/328067/
>
> instead of this one:
>         PCI: Try to allocate mem64 above 4G at first
>         http://patchwork.ozlabs.org/patch/303197/

Yes, I'm talking about http://patchwork.ozlabs.org/patch/328067; if
you look at patchwork, the second one (303197) is marked "superseded."

> This patch does not intend to conserve 32-bit space at all. It makes
> better use of prefetchable window.
>
> The problem with the old code is: when both 32-bit and 64-bit prefetchable
> BARs present, it's in favor of 32-bit one to use prefetchable window.
> This window is then not supposed to get 4G-above address, and this
> 32-bit-address-only property would propagates upwards until reaching root
> bridge. In later assignment phase, 4G-above space is never touched. This
> is just caused by a single 32-bit prefetchable BAR (say a ROM BAR).
>
> This patch helps by making better decision:
>
>         * Keep the old behaviour if only 32-bit or 64-bit prefetchable
>           BARs present
>
>         * If both of them present, put 64-bit ones to prefetchable window,
>           32-bit ones to non-prefetchable window

I thought the patch was supposed to change the way we allocate bridge
windows.  But you are talking about the way we assign 32- and 64-bit
device resources, i.e., changing the way we decide whether to put them
in prefetchable or non-prefetchable windows.

> So 4G-above space can be properly used.
>
> Why does enabling 64-bit space matter?
>
> * 32-bit space is just too small. If larger-than-4G BAR sounds
>   unrealistic (we do have such devices), there is still a chance that
>   total MMIO size under a domain is too large, especially when SR-IOV
>   enabled (we met this situation).

Please give more details about the problem you saw.  A complete dmesg
log showing a boot failure or a device that doesn't work, and another
log with this patch applied, showing things working as desired, would
go a long ways toward clarifying this.

This sounds like a specific case that will be fixed by the patch, and
if you give more details, maybe I can figure out what's going on.

Bjorn
