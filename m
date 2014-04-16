Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60614 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaDPAJ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 20:09:29 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so9843628iec.19
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2014 17:09:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140415115450.GA7792@yanx>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx> <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
 <20140409075215.GA3173@yanx> <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
 <20140415115450.GA7792@yanx>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Apr 2014 18:09:08 -0600
Message-ID: <CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
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

On Tue, Apr 15, 2014 at 5:54 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> On Thu, Apr 10, 2014 at 11:26:14AM -0600, Bjorn Helgaas wrote:
>> On Wed, Apr 9, 2014 at 1:52 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
>> > So 4G-above space can be properly used.
>> >
>> > Why does enabling 64-bit space matter?
>> >
>> > * 32-bit space is just too small. If larger-than-4G BAR sounds
>> >   unrealistic (we do have such devices), there is still a chance that
>> >   total MMIO size under a domain is too large, especially when SR-IOV
>> >   enabled (we met this situation).
>>
>> Please give more details about the problem you saw.  A complete dmesg
>> log showing a boot failure or a device that doesn't work, and another
>> log with this patch applied, showing things working as desired, would
>> go a long ways toward clarifying this.
>>
>> This sounds like a specific case that will be fixed by the patch, and
>> if you give more details, maybe I can figure out what's going on.
>>
>
> Let's see an example.

Thanks for the example.  Please open a bug report at
http://bugzilla.kernel.org and attach the complete dmesg logs before
and after Yinghai's patch.

Having the complete logs helps me answer questions myself without
having to bother you, and it also helps me figure out whether we can
improve our logging to make it easier to diagnose problems like this.

> | pci 0003:05:00.0: reg 0x10: [mem 0x3d05801000000-0x3d058010fffff 64bit]
> | pci 0003:05:00.0: reg 0x18: [mem 0x3d05010000000-0x3d05017ffffff 64bit pref]
> | pci 0003:05:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
> | pci 0003:05:00.0: reg 0x134: [mem 0x3d05018000000-0x3d0501fffffff 64bit pref]
>
> This is printed at enumeration phase. This device has a SRIOV BAR with
> size of 0x7ffffff (128M). That's the size of a signle VF BAR. The device
> supports 63 VFs so we need near 8G space in total. Apparanlty we need
> exploit 64-bit space.

Yes.  Do we print a hint anywhere about how many VFs there are?  In
other words, can you deduce the number "63" from the dmesg, or do you
have to figure that out some other way?  It'd be nice if that
information were somewhere in dmesg.

> | PCI host bridge to bus 0003:00
> | pci_bus 0003:00: root bus resource [mem 0x3d05800000000-0x3d0587ffeffff] (bus address [0x80000000-0xfffeffff])
> | pci_bus 0003:00: root bus resource [mem 0x3d05008000000-0x3d057ffffffff 64bit pref]
>
> And we do have a huge (32G) 64-bit prefetchable window supply. We expect
> everything to work fine, but:
>
> | pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0x206000000)
> | pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
> | pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)
>
> It went wrong at the beginning. Note the error message never considers
> 64-bit or not, but BAR 15 here has it MEM_64 flag cleared.

BAR 15 is a bridge window.  I think its resource flags should reflect
the capability of the *window*, even if we disable the window or we
happen to assign addresses that are under 4GB.  So I think it's wrong
that we clear the MEM_64 flag  in pbus_size_mem() and the IO flag in
pbus_size_io().

> It first
> tried to find a 32-bit prefetchable window, but we only supply a 64-bit one.
> So it fall back to (32-bit) non-prefetchable window, but there is no enough
> room there. At last it went into complicated steps (not show here) of
> allocating requested resource first, then try best for the optional ones, etc..
>
> Why is BAR 15 (prefetchable) 32 bit instead of 64? Because PCI core favours
> 32-bit prefetchable BARs and we have some. This is one of them:
>
> | pci 0003:05:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
>
> PCI core decides to let them enjoy the benefition of prefetch. They can't
> bear the risk of getting 4G-above address, so its parent, its parent's parent,
> its parent's parent's parent, finally the root bridge (00:00.0) must have their
> MEM_64 flag of prefetchable resource (BAR 15) clear.

It sounds like we're tracking the resource requirements
(prefetchability and BAR width) by using the flags on bridge windows.
If that's the case, I think it's wrong.  We should preserve the bridge
window flags, because those express the bridge hardware capabilities,
and we should explicitly keep track of what's required by devices
below the bridge in some other way.

> In the end nobody
> is eligible to use the 64-bit (prefetchable) space even we have huge
> supply !
>
> Note even the resource is small and successfully fall back into 32-bit
> non-prefetchable window, that's still not OK for us because we need
> SRIOV resource be at 64-bit prefetchable space to do platform
> configuration.
>
> With Yinghai's patch, when 64-bit prefetchable BARs found, they're more
> favoured than the 32-bit prefetchable ones (if any), so all upstream bridges'
> prefetchable windows have their MEM_64 flag reserved and the huge 64-bit
> prefetchable space will be exploited:
>
> | pci 0003:00:00.0: BAR 15: assigned [mem 0x3d05008000000-0x3d0521fffffff 64bit pref]
> | pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
> | pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)
>
> (The IO resource error here is due to we do not provide IO window)

Yes.  The lack of I/O space is just a constraint of the platform.
It'd be nice if we printed a more meaningful error message in this
case.  One really has to be a PCI expert to distinguish this from a
real problem that we need to fix.

Bjorn
