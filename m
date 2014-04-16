Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:41920 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaDPRKm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 13:10:42 -0400
Received: by mail-ig0-f175.google.com with SMTP id ur14so1280339igb.14
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2014 10:10:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV2eJGNusy1M8jO7EMRwsU4C6809dRkzXAqEVH34y82ig@mail.gmail.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx> <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
 <20140409075215.GA3173@yanx> <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
 <20140415115450.GA7792@yanx> <CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
 <CAE9FiQV2eJGNusy1M8jO7EMRwsU4C6809dRkzXAqEVH34y82ig@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 16 Apr 2014 11:10:21 -0600
Message-ID: <CAErSpo5qwwq9zrRRusgaH_Pk-iCbm94CuBDEE9jxmGa2cmcP+g@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
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

On Tue, Apr 15, 2014 at 10:16 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Apr 15, 2014 at 5:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> It first
>>> tried to find a 32-bit prefetchable window, but we only supply a 64-bit one.
>>> So it fall back to (32-bit) non-prefetchable window, but there is no enough
>>> room there. At last it went into complicated steps (not show here) of
>>> allocating requested resource first, then try best for the optional ones, etc..
>>>
>>> Why is BAR 15 (prefetchable) 32 bit instead of 64? Because PCI core favours
>>> 32-bit prefetchable BARs and we have some. This is one of them:
>>>
>>> | pci 0003:05:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
>>>
>>> PCI core decides to let them enjoy the benefition of prefetch. They can't
>>> bear the risk of getting 4G-above address, so its parent, its parent's parent,
>>> its parent's parent's parent, finally the root bridge (00:00.0) must have their
>>> MEM_64 flag of prefetchable resource (BAR 15) clear.
>>
>> It sounds like we're tracking the resource requirements
>> (prefetchability and BAR width) by using the flags on bridge windows.
>> If that's the case, I think it's wrong.  We should preserve the bridge
>> window flags, because those express the bridge hardware capabilities,
>> and we should explicitly keep track of what's required by devices
>> below the bridge in some other way.
>
> if the BAR support 64bit, then resource could be 64bit.
> if the BAR does not support 64bit, then resource should be 32bit.
>
> That should be best guess to decide resource flag.

We don't need to "decide" the resource flags.  The hardware tells us
what it can support, and *that* should be reflected in the flags.  We
do need to decide what addresses to assign and whether to put a
prefetchable BAR in a prefetchable or non-prefetchable window.

Putting decision results in the resource flags obfuscates the whole process.
