Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:42159 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046AbaDHPCb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 11:02:31 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so5165712igq.4
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2014 08:02:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140408025738.GA3198@yanx>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Apr 2014 09:02:10 -0600
Message-ID: <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
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

On Mon, Apr 7, 2014 at 8:57 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> On Fri, Apr 04, 2014 at 04:43:27PM -0600, Bjorn Helgaas wrote:
>> On Fri, Mar 7, 2014 at 1:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> > When one of children resources does not support MEM_64, MEM_64 for
>> > bridge get reset, so pull down whole pref resource on the bridge under 4G.
>> >
>> > If the bridge support pref mem 64, will only allocate that with pref mem64 to
>> > children that support it.
>> > For children resources if they only support pref mem 32, will allocate them
>> > from non pref mem instead.
>> >
>> > If the bridge only support 32bit pref mmio, will still have all children pref
>> > mmio under that.
>> >
>> > -v2: Add release bridge res support with bridge mem res for pref_mem children res.
>> > -v3: refresh and make it can be applied early before for_each_dev_res patchset.
>> > -v4: fix non-pref mmio 64bit support found by Guo Chao.
>> > -v7: repost as ibm's powerpc system work again when
>> >     1. petiboot boot kernel have this patch.
>> >     2. or mellanox driver added new .shutdown member.
>> >     discussion could be found at:
>> >          http://marc.info/?t=138968064500001&r=1&w=2
>>
>> I think this fixes some sort of bug, and I suppose if I spent a few
>> hours decoding the discussion you mention (the 44 message-long
>> "mlx4_core probe error after applying Yinghai's patch" discussion), I
>> might be able to figure out what it is.
>>
>
> The result of 44 message-long discussion is: the Mellanox card's failure is
> due to a bug in its driver instead of this patch.
>
> The patch refines the logic of using prefetchable window, so that 64-bit
> prefetchable BARs have a chance to be really prefetchable. It does not fix
> any bugs, instead, it exposes one.

OK, then I'm back to square one, and I need an explanation of why we
want to merge this patch.

I think the patch conserves 32-bit address space by putting more
things above 4G than we used to.  But this comes at the cost of using
non-prefetchable windows in some cases where we used to use
prefetchable ones.

Somebody has to explain why we want to do this and why the benefit of
conserving the 32-bit space is more important losing the
prefetchability.

Bjorn
