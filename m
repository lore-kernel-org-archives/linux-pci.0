Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52306 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaGPUzN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 16:55:13 -0400
Received: by mail-ie0-f170.google.com with SMTP id rl12so1507002iec.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 13:55:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
References: <CAKAYmMLfxkmaVxaPDd6z=B0ESQ3mR=dUG4OFFgEoy0295qLYgg@mail.gmail.com>
	<CAKAYmMLhPhukBbR8NhPk3EigmvwiX+DEGj-Mod7zpHMnZKRsLw@mail.gmail.com>
	<CAErSpo7vooChRfSF6oY8GcqVYZruv-7_D0zm3a4M_KDVMbWNiA@mail.gmail.com>
Date: Wed, 16 Jul 2014 13:55:12 -0700
Message-ID: <CAE9FiQWomktcpSHeFwxWBLXmAsbdXEHv6sOrNXodobkBw=mRKA@mail.gmail.com>
Subject: Re: Error assigning BAR 0 to hotplugged device
From: Yinghai Lu <yinghai@kernel.org>
To: Chuck Tuffli <ctuffli@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 11:54 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Yinghai]
>
> On Wed, Jul 16, 2014 at 11:19 AM, Chuck Tuffli <ctuffli@gmail.com> wrote:
>> On Tue, Jul 8, 2014 at 12:37 PM, Chuck Tuffli <ctuffli@gmail.com> wrote:
>>> On a system with a recent Fedora kernel (3.14.9-200.fc20.x86_64), a
>>> hotplugged PCI device is unable to get memory mapped IO:
>>> ...
>>> [  183.247377] pcieport 0000:9a:00.0: BAR 15: can't assign mem pref
>>> (size 0x100000)
>>> [  183.247384] pcieport 0000:9b:15.0: BAR 14: can't assign mem (size 0x100000)
>>> [  183.247388] pcieport 0000:9b:15.0: BAR 15: can't assign mem pref
>>> (size 0x100000)
>>> [  183.247394] pci 0000:a5:00.0: BAR 6: can't assign mem pref (size 0x10000)
>>> [  183.247397] pci 0000:a5:00.0: BAR 0: can't assign mem (size 0x4000)
>>>
>>> The device is connected to a switch supporting hotplug (i.e. SltCap
>>> includes HotPlug+) and I have added
>>> pci=realloc,hpmemsize=16M
>>> to the kernel boot parameters. This appears to have increased the
>>> prefetchable memory but not the memory mapped IO:
>>
>> Further investigation suggests that pbus_size_mem() never really gets
>> a chance to increase the bridge aperture by the hpmemsize value
>> because find_free_bus_resource() returns NULL. This apparently happens
>> because the function "skip[s] the bus resources which have already
>> been assigned (that is, have non-NULL parent resource)". Specifically,
>> it checks
>>
>>     if (r && (r->flags & type_mask) == type && !r->parent)
>>
>> and in my configuration, finds that r->parent != NULL for the memory
>> mapped IO resource. Wouldn't r->parent be non-NULL in most cases other
>> than for bridges in the root complex? If so, does that imply hpmemsize
>> would only be used for bridges advertising hot plug in the root
>> complex?

Please try current tree linus/master or pci/next.
also need boot with "debug ignore_loglevel pciehp.pciehp_debug=1".

post
dmesg -s 262144
lspci -tv
lspci -vvxxx

Thanks

Yinghai
