Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:64620 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbaGPXr2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 19:47:28 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so1769150igc.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 16:47:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
	<CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
	<CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
	<CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
Date: Wed, 16 Jul 2014 16:47:27 -0700
Message-ID: <CAE9FiQW+GbprQZNvHC-ek1cSydP3KWcjgAU0ii5_jECC1+tXrg@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Yinghai Lu <yinghai@kernel.org>
To: Chuck Tuffli <ctuffli@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 1:55 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 16, 2014 at 11:54 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Yinghai]
>>
>> On Wed, Jul 16, 2014 at 11:19 AM, Chuck Tuffli <ctuffli@gmail.com> wrote:
>>> On Tue, Jul 8, 2014 at 12:37 PM, Chuck Tuffli <ctuffli@gmail.com> wrote:
>>>> On a system with a recent Fedora kernel (3.14.9-200.fc20.x86_64), a
>>>> hotplugged PCI device is unable to get memory mapped IO:
>>>> ...
>>>> [  183.247377] pcieport 0000:9a:00.0: BAR 15: can't assign mem pref
>>>> (size 0x100000)
>>>> [  183.247384] pcieport 0000:9b:15.0: BAR 14: can't assign mem (size 0x100000)
>>>> [  183.247388] pcieport 0000:9b:15.0: BAR 15: can't assign mem pref
>>>> (size 0x100000)
>>>> [  183.247394] pci 0000:a5:00.0: BAR 6: can't assign mem pref (size 0x10000)
>>>> [  183.247397] pci 0000:a5:00.0: BAR 0: can't assign mem (size 0x4000)
>>>>
>>>> The device is connected to a switch supporting hotplug (i.e. SltCap
>>>> includes HotPlug+) and I have added
>>>> pci=realloc,hpmemsize=16M
>>>> to the kernel boot parameters. This appears to have increased the
>>>> prefetchable memory but not the memory mapped IO:
>>>
>>> Further investigation suggests that pbus_size_mem() never really gets
>>> a chance to increase the bridge aperture by the hpmemsize value
>>> because find_free_bus_resource() returns NULL. This apparently happens
>>> because the function "skip[s] the bus resources which have already
>>> been assigned (that is, have non-NULL parent resource)". Specifically,
>>> it checks
>>>
>>>     if (r && (r->flags & type_mask) == type && !r->parent)
>>>
>>> and in my configuration, finds that r->parent != NULL for the memory
>>> mapped IO resource. Wouldn't r->parent be non-NULL in most cases other
>>> than for bridges in the root complex? If so, does that imply hpmemsize
>>> would only be used for bridges advertising hot plug in the root
>>> complex?
>
> Please try current tree linus/master or pci/next.
> also need boot with "debug ignore_loglevel pciehp.pciehp_debug=1".
>
> post
> dmesg -s 262144
> lspci -tv
> lspci -vvxxx

in the tree:
   80:03.0 ==> 96:00.0 ==> 97:08.0 ==> 98:00.0 ==> 99:00.0 ==> 9a:00.0
==> 9b:15.0

only 97:08.0 and 99:00.0 is hotplug+.

and kernel will honor BIOS set value at first, and realloc will only work on
unassigned/invalid assigned BARs. and hpmem_size will be only treated at
optional size even on hotplug slots.

a5:00.0 is not in 9b:15.0 at first, so yo just put the card in can
rescan the card,
right?

In this case we don't to realloc, as other devices could already have
driver loaded.

You need to fix the BIOS to have correct setting for 96:1b.0.

                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #21, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+

to make it really hotplug slot.

And BIOS need to make sure parent bus/bridge have enough resource ranges
for the hotplug slots.

Yinghai
